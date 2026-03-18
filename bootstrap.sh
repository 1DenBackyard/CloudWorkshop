#!/usr/bin/env bash
set -euo pipefail

STACK_DIR="/opt/user1-stack"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[1/8] Проверка .env"
if [[ ! -f "${REPO_DIR}/.env" ]]; then
  echo "Файл .env не найден в ${REPO_DIR}"
  exit 1
fi

echo "[2/8] Установка Docker"
sudo apt update
sudo apt install -y ca-certificates gnupg curl

sudo install -m 0755 -d /etc/apt/keyrings

if [[ ! -f /etc/apt/keyrings/docker.gpg ]]; then
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
fi

sudo chmod a+r /etc/apt/keyrings/docker.gpg

if [[ ! -f /etc/apt/sources.list.d/docker.list ]]; then
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo $VERSION_CODENAME) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
fi

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable docker
sudo systemctl start docker

echo "[3/8] Подготовка каталогов"
sudo mkdir -p "${STACK_DIR}/traefik"
sudo mkdir -p "${STACK_DIR}/n8n_data"
sudo mkdir -p "${STACK_DIR}/qdrant_data"

sudo touch "${STACK_DIR}/traefik/acme.json"
sudo chmod 600 "${STACK_DIR}/traefik/acme.json"

echo "[4/8] Копирование файлов"
sudo cp "${REPO_DIR}/docker-compose.yml" "${STACK_DIR}/docker-compose.yml"
sudo cp "${REPO_DIR}/.env" "${STACK_DIR}/.env"

echo "[5/8] Остановка старого стека"
cd "${STACK_DIR}"
sudo docker compose down || true

echo "[6/8] Права для n8n"
sudo chown -R 1000:1000 "${STACK_DIR}/n8n_data"
sudo chmod -R u+rwX "${STACK_DIR}/n8n_data"

echo "[7/8] Запуск"
sudo docker compose config > /dev/null
sudo docker compose pull
sudo docker compose up -d

echo "[8/8] Статус"
sudo docker compose ps