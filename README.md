````md
# README

## 1. Перейти в локальную папку

```bash
cd ~/CloudWorkshop
````

## 2. Проверить, что файлы на месте

```bash
ls
ls envs
```

## 3. Создать папку на ВМ

```bash
ssh user@IP_ВМ "mkdir -p ~/stack-deploy"
```

## 4. Скопировать файлы на ВМ

```bash
scp bootstrap.sh docker-compose.yml verify.sh user@IP_ВМ:~/stack-deploy/
scp envs/userN.env user@IP_ВМ:~/stack-deploy/.env
```

## 5. Подключиться к ВМ

```bash
ssh user@IP_ВМ
```

## 6. Перейти в рабочую папку

```bash
cd ~/stack-deploy
```

## 7. Проверить env

```bash
cat .env
```

## 8. Сделать скрипты исполняемыми

```bash
chmod +x bootstrap.sh
chmod +x verify.sh
```

## 9. Запустить установку

```bash
sudo bash bootstrap.sh
```

## 10. Запустить проверку

```bash
sudo bash verify.sh
```

## 11. Проверить HTTP

```bash
curl -I http://userN.iamesin.ru
```

## 12. Проверить HTTPS

```bash
curl -I https://userN.iamesin.ru
```

## 13. Открыть в браузере

```text
https://userN.iamesin.ru
```

## 14. Если нужно посмотреть контейнеры

```bash
sudo docker ps
```

## 15. Если нужно посмотреть логи traefik

```bash
sudo docker logs traefik
```

## 16. Если нужно посмотреть логи n8n

```bash
sudo docker logs n8n
```

## 17. Если нужно проверить qdrant и rsshub изнутри n8n

```bash
sudo docker exec -it n8n sh
```

```bash
wget -qO- http://qdrant:6333/healthz
wget -qO- http://rsshub:1200/
```

## 18. Для следующей ВМ повторить

```bash
cd ~/CloudWorkshop
ssh user@IP_СЛЕДУЮЩЕЙ_ВМ "mkdir -p ~/stack-deploy"
scp bootstrap.sh docker-compose.yml verify.sh user@IP_СЛЕДУЮЩЕЙ_ВМ:~/stack-deploy/
scp envs/userM.env user@IP_СЛЕДУЮЩЕЙ_ВМ:~/stack-deploy/.env
ssh user@IP_СЛЕДУЮЩЕЙ_ВМ
cd ~/stack-deploy
chmod +x bootstrap.sh
chmod +x verify.sh
sudo bash bootstrap.sh
sudo bash verify.sh
```

```
```
