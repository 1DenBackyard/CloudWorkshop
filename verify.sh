#!/usr/bin/env bash
set -euo pipefail

STACK_DIR="/opt/user1-stack"
cd "${STACK_DIR}"

DOMAIN="$(grep '^DOMAIN=' .env | cut -d= -f2)"

echo "[1/5] Контейнеры"
sudo docker compose ps

echo
echo "[2/5] HTTP"
curl -I "http://${DOMAIN}" || true

echo
echo "[3/5] HTTPS"
curl -I "https://${DOMAIN}" || true

echo
echo "[4/5] Qdrant из n8n"
sudo docker exec n8n sh -c 'wget -qO- http://qdrant:6333/healthz' || true

echo
echo "[5/5] RSSHub из n8n"
sudo docker exec n8n sh -c 'wget -qO- http://rsshub:1200/' | head -n 5 || true