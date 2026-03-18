Понял. Без лишнего.

Ниже чистый README, нормальный рабочий вариант. `verify.sh` оставлен как опциональный инструмент проверки, но не обязателен.

---

````md
# DEPLOY n8n STACK (scp + ssh, без git)

Развёртывание n8n + Traefik + Qdrant + RSSHub на ВМ.

---

## ОБЩАЯ ЛОГИКА

1. Локально генерируются env-файлы
2. env копируется на ВМ
3. bootstrap.sh запускается на ВМ
4. сервисы поднимаются

## 2. ЧТО ДОЛЖНО БЫТЬ У ТЕБЯ ЛОКАЛЬНО

Файлы:

* bootstrap.sh
* docker-compose.yml
* папка envs/

---

## 3. КОПИРОВАНИЕ НА ВМ

Создать папку на ВМ:

```bash
ssh user@IP "mkdir -p ~/stack-deploy"
```

Скопировать файлы:

```bash
scp bootstrap.sh docker-compose.yml user@IP:~/stack-deploy/
scp envs/userN.env user@IP:~/stack-deploy/.env
```

---

## 4. РАБОТА НА ВМ

Подключиться:

```bash
ssh user@IP
```

Перейти:

```bash
cd ~/stack-deploy
```

Сделать скрипт исполняемым:

```bash
chmod +x bootstrap.sh
```

Запустить:

```bash
sudo bash bootstrap.sh
```

---

## 5. ПРОВЕРКА

Проверить HTTP:

```bash
curl -I http://userN.iamesin.ru
```

Проверить HTTPS:

```bash
curl -I https://userN.iamesin.ru
```

Открыть в браузере:

```
https://userN.iamesin.ru
```

---

## 6. ДОПОЛНИТЕЛЬНЫЕ ПРОВЕРКИ (ЕСЛИ ЧТО-ТО НЕ РАБОТАЕТ)

Контейнеры:

```bash
sudo docker ps
```

Логи Traefik:

```bash
sudo docker logs traefik
```

Логи n8n:

```bash
sudo docker logs n8n
```

Проверка сервисов изнутри:

```bash
sudo docker exec -it n8n sh
```

```bash
wget -qO- http://qdrant:6333/healthz
wget -qO- http://rsshub:1200/
```

---

## 7. ПРО verify.sh

verify.sh не обязателен.

Он нужен только чтобы одной командой проверить:

* контейнеры
* HTTP
* HTTPS
* доступность qdrant/rsshub

Если не хочешь — не используй. Все проверки выше можно выполнять вручную.

---

## 8. ДЕПЛОЙ СЛЕДУЮЩЕЙ ВМ

```bash
scp bootstrap.sh docker-compose.yml user@IP:~/stack-deploy/
scp envs/userN.env user@IP:~/stack-deploy/.env

ssh user@IP
cd ~/stack-deploy
chmod +x bootstrap.sh
sudo bash bootstrap.sh
```

---

## 9. ЧТО МЕНЯЕТСЯ

Уникально для каждой ВМ:

* DOMAIN
* N8N_ENCRYPTION_KEY
* QDRANT_API_KEY

---

## 10. ЧТО ОБЩЕЕ

* bootstrap.sh
* docker-compose.yml
* LETSENCRYPT_EMAIL
* TZ

---

## 11. ТИПОВЫЕ ПРОБЛЕМЫ

n8n permission denied:

```bash
sudo chown -R 1000:1000 /opt/user1-stack/n8n_data
```

DNS:

```bash
dig +short A userN.iamesin.ru
```

SSL не сразу:

подождать несколько минут

---

## ГОТОВО

```

---

Если дальше — могу дать один файл, который будет деплоить все 20 ВМ подряд без ручных ssh/scp.
```
