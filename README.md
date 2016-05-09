laravel on docker
=================

WIP: Laravelを利用したWebアプリケーションをDocker環境で動かす検証。

```sh
# 起動
docker-compose up -d

# webapp/Dockerfileのビルドしてから起動
docker-compose up --build

# コンテナに入って操作する(alpineなのでash)
docker exec -it laradocker_webapp_1 ash
```