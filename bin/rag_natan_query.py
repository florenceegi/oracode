#!/usr/bin/env python3
"""
RAG Natan Query — DOC-SYNC v2 Step 3

Queries rag_natan.embeddings for SSOT documents semantically related to a concept.
Used by doc-sync-v2 agent for lateral discovery.

@author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
@version 2.0.0 (FlorenceEGI — ecosistema)
@date 2026-04-30
@purpose Query RAG piattaforma for laterally impacted SSOT documents
"""

import argparse
import json
import os
import sys
from pathlib import Path

import psycopg2
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


def query_rag(concept: str, threshold: float = 0.55, limit: int = 10) -> list[dict]:
    client = get_openai_client()
    response = client.embeddings.create(input=concept, model="text-embedding-3-small")
    embedding = response.data[0].embedding

    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute(
        """SELECT d.id, d.title, d.slug, d.tags,
                  1 - (e.embedding <=> %s::vector) as similarity
           FROM rag_natan.embeddings e
           JOIN rag_natan.chunks c ON e.chunk_id = c.id
           JOIN rag_natan.documents d ON c.document_id = d.id
           WHERE d.status = 'published'
             AND 1 - (e.embedding <=> %s::vector) > %s
           ORDER BY similarity DESC
           LIMIT %s""",
        (str(embedding), str(embedding), threshold, limit),
    )
    rows = cur.fetchall()
    conn.close()

    seen = {}
    for doc_id, title, slug, tags, sim in rows:
        if slug not in seen or sim > seen[slug]["similarity"]:
            seen[slug] = {
                "document_id": doc_id,
                "title": title,
                "slug": slug,
                "tags": tags or [],
                "similarity": round(float(sim), 4),
            }

    return sorted(seen.values(), key=lambda x: x["similarity"], reverse=True)


def main():
    parser = argparse.ArgumentParser(description="RAG Natan SSOT Query (DOC-SYNC v2)")
    parser.add_argument("--concept", required=True, help="Concept to search for")
    parser.add_argument("--threshold", type=float, default=0.55, help="Cosine similarity threshold")
    parser.add_argument("--limit", type=int, default=10, help="Max results")
    args = parser.parse_args()

    results = query_rag(args.concept, args.threshold, args.limit)
    print(json.dumps(results, indent=2))


if __name__ == "__main__":
    main()
