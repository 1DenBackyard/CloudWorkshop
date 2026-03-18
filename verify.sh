#!/usr/bin/env bash
set -euo pipefail

STACK_DIR="/opt/user1-stack"
cd "${STACK_DIR}"

DOMAIN_N8N="$(grep '^DOMAIN_N8N=' .env | cut -d= -f2)"
DOMAIN_QDRANT="$(grep '^DOMAIN_QDRANT=' .env | cut -d= -f2)"
DOMAIN_RSSHUB="$(grep '^DOMAIN_RSSHUB=' .env | cut -d= -f2)"

echo "[1/6] Контейнеры"
sudo docker compose ps

echo
echo "[2/6] n8n"
curl -I "https://${DOMAIN_N8N}" || true

echo
echo "[3/6] qdrant"
curl -I "https://${DOMAIN_QDRANT}" || true

echo
echo "[4/6] rsshub"
curl -I "https://${DOMAIN_RSSHUB}" || true

echo
echo "[5/6] qdrant из n8n"
sudo docker exec n8n sh -c 'wget -qO- http://qdrant:6333/' || true

echo
echo "[6/6] rsshub из n8n"
sudo docker exec n8n sh -c 'wget -qO- http://rsshub:1200/' | head -n 5 || true