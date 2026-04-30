#!/usr/bin/env python3
"""
RAG Natan Re-indexer — DOC-SYNC v2 Step 5

Re-indexes SSOT markdown files into rag_natan schema (documents, chunks, embeddings).
Transactional per SSOT. Blocking sanity check after each upsert.

@author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
@version 2.0.0 (FlorenceEGI — ecosistema)
@date 2026-04-30
@purpose Re-index SSOT docs into RAG piattaforma after DOC-SYNC v2 modifications
"""

import argparse
import hashlib
import json
import os
import re
import sys
import time
from pathlib import Path

import psycopg2
from psycopg2.extras import execute_values
from openai import OpenAI


def get_db_connection():
    env_path = Path("/home/fabio/NATAN_LOC/laravel_backend/.env")
    env_vars = {}
    if env_path.exists():
        for line in env_path.read_text().splitlines():
            line = line.strip()
            if line and not line.startswith("#") and "=" in line:
                key, _, val = line.partition("=")
                env_vars[key.strip()] = val.strip().strip('"').strip("'")

    return psycopg2.connect(
        host=env_vars.get("DB_HOST", ""),
        dbname=env_vars.get("DB_DATABASE", "florenceegi"),
        user=env_vars.get("DB_USERNAME", "florence_app"),
        password=env_vars.get("DB_PASSWORD", ""),
        port=int(env_vars.get("DB_PORT", "5432")),
        connect_timeout=10,
    )


def get_openai_client():
    env_path = Path("/home/fabio/NATAN_LOC/laravel_backend/.env")
    api_key = os.environ.get("OPENAI_API_KEY", "")
    if not api_key and env_path.exists():
        for line in env_path.read_text().splitlines():
            if line.startswith("OPENAI_API_KEY="):
                api_key = line.split("=", 1)[1].strip().strip('"').strip("'")
                break
    if not api_key:
        raise ValueError("OPENAI_API_KEY not found")
    return OpenAI(api_key=api_key)


def chunk_markdown(content: str, max_chars: int = 1500, overlap: int = 100) -> list[dict]:
    heading_pattern = re.compile(r"^(#{2,3})\s+(.+)$", re.MULTILINE)
    sections = []
    matches = list(heading_pattern.finditer(content))

    if not matches:
        sections.append({"title": "Content", "text": content.strip()})
    else:
        if matches[0].start() > 0:
            preamble = content[: matches[0].start()].strip()
            if preamble:
                sections.append({"title": "Introduction", "text": preamble})
        for i, match in enumerate(matches):
            end = matches[i + 1].start() if i + 1 < len(matches) else len(content)
            section_text = content[match.start() : end].strip()
            sections.append({"title": match.group(2).strip(), "text": section_text})

    chunks = []
    for section in sections:
        text = section["text"]
        if len(text) <= max_chars:
            chunks.append({"title": section["title"], "text": text})
            continue

        paragraphs = text.split("\n\n")
        current_chunk = ""
        for para in paragraphs:
            if len(current_chunk) + len(para) + 2 > max_chars and current_chunk:
                chunks.append({"title": section["title"], "text": current_chunk.strip()})
                if overlap > 0 and len(current_chunk) > overlap:
                    current_chunk = current_chunk[-overlap:] + "\n\n" + para
                else:
                    current_chunk = para
            else:
                current_chunk = current_chunk + "\n\n" + para if current_chunk else para

        if current_chunk.strip():
            chunks.append({"title": section["title"], "text": current_chunk.strip()})

    return chunks


def generate_embeddings(client: OpenAI, texts: list[str], batch_size: int = 20) -> list[list[float]]:
    all_embeddings = []
    for i in range(0, len(texts), batch_size):
        batch = texts[i : i + batch_size]
        for attempt in range(3):
            try:
                response = client.embeddings.create(
                    input=batch, model="text-embedding-3-small"
                )
                all_embeddings.extend([d.embedding for d in response.data])
                break
            except Exception as e:
                if attempt == 2:
                    raise
                wait = (2**attempt) * 2
                print(f"Embedding retry {attempt+1}, waiting {wait}s: {e}", file=sys.stderr)
                time.sleep(wait)
    return all_embeddings


def reindex_ssot(conn, client: OpenAI, file_path: str) -> dict:
    path = Path(file_path)
    if not path.exists():
        return {"ssot_path": file_path, "status": "error", "reason": "file_not_found"}

    content = path.read_text(encoding="utf-8")
    filename = path.stem
    slug = re.sub(r"[^a-z0-9-]", "-", filename.lower()).strip("-")
    slug = re.sub(r"-+", "-", slug)
    title = filename.replace("_", " ").replace("-", " ").title()

    first_line = content.split("\n", 1)[0].strip()
    if first_line.startswith("# "):
        title = first_line[2:].strip()

    tags = []
    for part in path.parts:
        if part == "docs":
            continue
        if part.endswith(".md"):
            continue
        if part in ("EGI-DOC", "home", "fabio"):
            continue
        tags.append(part.lower())

    chunks = chunk_markdown(content)
    if not chunks:
        return {"ssot_path": file_path, "status": "error", "reason": "no_chunks_produced"}

    chunk_texts = [c["text"] for c in chunks]
    embeddings = generate_embeddings(client, chunk_texts)

    result = {
        "ssot_path": file_path,
        "slug": slug,
        "chunks_updated": len(chunks),
        "embeddings_generated": len(embeddings),
        "sanity_check_passed": False,
        "status": "success",
    }

    cur = conn.cursor()
    try:
        cur.execute("BEGIN")

        cur.execute(
            "SELECT id FROM rag_natan.documents WHERE slug = %s AND language = 'it'",
            (slug,),
        )
        row = cur.fetchone()

        if row:
            doc_id = row[0]
            cur.execute("DELETE FROM rag_natan.chunks WHERE document_id = %s", (doc_id,))
            cur.execute(
                """UPDATE rag_natan.documents
                   SET title = %s, content = %s, updated_at = NOW(),
                       last_indexed_at = NOW(), is_indexed = true,
                       tags = %s, document_type = 'ssot', status = 'published'
                   WHERE id = %s""",
                (title, content, tags, doc_id),
            )
        else:
            cur.execute(
                """INSERT INTO rag_natan.documents
                   (title, slug, content, language, document_type, version, status, tags, is_indexed, last_indexed_at)
                   VALUES (%s, %s, %s, 'it', 'ssot', '1.0', 'published', %s, true, NOW())
                   RETURNING id""",
                (title, slug, content, tags),
            )
            doc_id = cur.fetchone()[0]

        chunk_ids = []
        for i, chunk in enumerate(chunks):
            cur.execute(
                """INSERT INTO rag_natan.chunks
                   (document_id, text, section_title, chunk_order, chunk_type, language)
                   VALUES (%s, %s, %s, %s, 'paragraph', 'it')
                   RETURNING id""",
                (doc_id, chunk["text"], chunk["title"], i),
            )
            chunk_ids.append(cur.fetchone()[0])

        emb_data = [
            (chunk_ids[i], "text-embedding-3-small", embeddings[i])
            for i in range(len(chunk_ids))
        ]
        for cid, model, emb in emb_data:
            cur.execute(
                """INSERT INTO rag_natan.embeddings (chunk_id, model, embedding)
                   VALUES (%s, %s, %s::vector)""",
                (cid, model, str(emb)),
            )

        cur.execute("COMMIT")
        result["index_transaction_id"] = doc_id

        sanity_ok = run_sanity_check(conn, chunk_ids[0], embeddings[0])
        result["sanity_check_passed"] = sanity_ok

    except Exception as e:
        cur.execute("ROLLBACK")
        result["status"] = "error"
        result["reason"] = str(e)

    return result


def run_sanity_check(conn, first_chunk_id: int, first_embedding: list[float]) -> bool:
    cur = conn.cursor()
    for attempt in range(3):
        try:
            cur.execute(
                """SELECT chunk_id, 1 - (embedding <=> %s::vector) as sim
                   FROM rag_natan.embeddings
                   ORDER BY embedding <=> %s::vector
                   LIMIT 5""",
                (str(first_embedding), str(first_embedding)),
            )
            rows = cur.fetchall()
            if any(r[0] == first_chunk_id for r in rows):
                return True
            if attempt < 2:
                time.sleep(2 ** (attempt + 1))
        except Exception:
            if attempt < 2:
                time.sleep(2 ** (attempt + 1))
    return False


def main():
    parser = argparse.ArgumentParser(description="RAG Natan SSOT Re-indexer (DOC-SYNC v2)")
    parser.add_argument(
        "--files", nargs="+", required=True, help="Absolute paths to SSOT .md files"
    )
    args = parser.parse_args()

    conn = get_db_connection()
    client = get_openai_client()

    results = []
    for fpath in args.files:
        result = reindex_ssot(conn, client, fpath)
        results.append(result)
        print(f"[reindex] {result['ssot_path']}: {result['status']}", file=sys.stderr)

    conn.close()
    print(json.dumps(results, indent=2))


if __name__ == "__main__":
    main()
