# README для деплоя

Ниже готовый текст.

````md
# README

## 1. Перейти в локальную папку

```bash
cd ~/CloudWorkshop
````

## 2. Проверить файлы

```bash
ls
ls envs
```

## 3. Создать папку на ВМ

```bash
ssh user@IP_ВМ "mkdir -p ~/stack-deploy"
```

## 4. Скопировать файлы на ВМ

Поменять user - на логин, ip ВМ - на ip ВМ актуальный, envs/userN - N поменять на цифру пользователя которого создаете

Например scp envs/user2.env user2@176.xxx.xxx.178:~/stack-deploy/.env
```bash
scp bootstrap.sh docker-compose.yml verify.sh user@IP_ВМ:~/stack-deploy/
scp envs/userN.env user@IP_ВМ:~/stack-deploy/.env
```

## 5. Подключиться к ВМ

```bash
ssh user@IP_ВМ
```

## 6. Перейти в папку

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

## 11. Проверить DNS

```bash
dig +short userN.workshop-cloud.ru
dig +short qdrant.userN.workshop-cloud.ru
dig +short rsshub.userN.workshop-cloud.ru
```

## 12. Проверить HTTPS

```bash
curl -I https://user2.workshop-cloud.ru
curl -I https://qdrant.user2.workshop-cloud.ru
curl -I https://rsshub.user2.workshop-cloud.ru
```

## 13. Открыть в браузере

n8n:

```text
https://userN.workshop-cloud.ru
```

qdrant:

```text
https://qdrant.userN.workshop-cloud.ru
```

rsshub:

```text
https://rsshub.userN.workshop-cloud.ru
```

## 14. Если нужно посмотреть контейнеры

```bash
sudo docker ps
```

## 15. Если нужно посмотреть логи Traefik

```bash
sudo docker logs traefik
```

## 16. Если нужно посмотреть логи n8n

```bash
sudo docker logs n8n
```

## 17. Для следующей ВМ повторить

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
