# README

詳しくは Udemyからご覧ください。


Dockerfileが入ったリポジトリは[こちら](https://github.com/uchidayuma/udemy-laravel8-mysql-simple-memo/tree/feature_ecs)

## ECSドキュメント
https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/Welcome.html

## AWS CLIにインストール（Windows）
https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/install-cliv2-windows.html

## AWS CLIにインストール（Mac）
https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/install-cliv2-mac.html


### AWS CLI 用の IAM ポリシーを設定する

IAMロールに以下を追記

```
{
"Version": "2012-10-17",
"Statement": [
{
"Effect": "Allow",
"Action": [
"ecs:ExecuteCommand",
"ssm:StartSession",
"ecs:DescribeTasks"
],
"Resource": "*"
}
]
}
```



## FargateでコンテナにExec

### Session Manager プラグインをインストール

[Windows](https://docs.aws.amazon.com/ja_jp/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html#install-plugin-windows)

[Mac](https://docs.aws.amazon.com/ja_jp/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html#install-plugin-macos)


### ECS タスクロールを追加する
https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/ecs-exec.html#ecs-exec-required-iam-permissions

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
        }
    ]
}
```

### ECS サービス作成時に ECS Exec フラグを有効化

aws ecs update-service --region ap-northeast-1 --cluster クラスター名 --service サービス名 --enable-execute-command
aws ecs update-service --region ap-northeast-1 --cluster tag-match-ecs --service tag-match-service --enable-execute-command



### AWS CLI の ecs execute-command を実行

aws ecs execute-command --region ap-northeast-1 --cluster クラスター名 --task タスクID --container コンテナ名 --interactive --command "/bin/sh"

aws ecs execute-command --region ap-northeast-1 --cluster tag-match-ecs --task e148789c783c4bf29e7e6faf688f1dd8 --container rails_app --interactive --command "/bin/sh"

## MariaDBコンテナのヘルスチェック
CMD-SHELL, mysqladmin ping -u dbuser -psimplememodbuser -h 127.0.0.1 || exit 1
CMD-SHELL, mysqladmin ping -u dbuser -ptagmatchdbuser -h 127.0.0.1 || exit 1


## 手動DB作成
CREATE DATABASE simplememo CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

grant all privileges on simplememo.* TO 'dbuser'@'127.0.0.1' identified by 'simplememodbuser';


## ECSサービスのオートスケーリング
[AWS公式ドキュメント](https://aws.amazon.com/jp/blogs/news/automatic-scaling-with-amazon-ecs/)


## ローカル環境からコンテナに接続し任意のコマンドを実行
docker-compose -f docker-compose.dev.yml exec app tail -f log/production.log

## docker-composeを指定してコンテナにアタッチ
docker-compose -f docker-compose.dev.yml exec app bash

## dockerイメージの作成
docker build -f Dockerfile -t railsecs --platform amd64 .

## docker-composeを使用してイメージをビルド
docker-compose -f docker-compose.yml build --no-cache

## docker-composeを使用してコンテナを起動
docker-compose -f docker-compose.yml up -d


【mysql】
## 文字コードの確認
show variables like "chara%";

【findコマンド】
## 便利なファイル検索
find / -name 'hoge*.txt'
# アクセス権限を表示を消してファイル検索
find / -name 'hoge*.txt' 2>/dev/null

## gemリスト一覧表示コマンド
gem list



This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...




お世話になっております。
昨日は夜分までご対応有難うございました。

昨日の作業後、上記の回答通り、手元のdatabase.ymlを確認するとデータベースのhostの指定がlocalhostではなくdbにしておりました。


なのでmain-prdブランチのconfig/database.ymlの設定で再度ECS上のタスクをデプロイ。
が、以下エラーが発生。
# bundle exec rails db:create RAILS_ENV=production
Can't connect to local MySQL server through socket '/tmp/sockets/puma.sock' (2)
Couldn't create 'tagmatch' database. Please check your configuration.
rails aborted!

/tmp/sockets/配下にpuma.sockがなくて怒られているので、
config/database.ymlのsocket:の指定を以下に変更
socket: /myapp/tmp/sockets/puma.sock

再度ECS上のタスクをデプロイ。
が、エラー
# bundle exec rails db:create RAILS_ENV=production
Can't connect to local MySQL server through socket '/myapp/tmp/sockets/puma.sock' (2)























~server name web~
■rails-app
2023-04-18 20:32:33Use Ctrl-C to stop
Use Ctrl-C to stop
2023-04-18 20:32:33* Listening on tcp://0.0.0.0:3000
* Listening on tcp://0.0.0.0:3000
2023-04-18 20:32:33* Listening on unix:///myapp/tmp/sockets/puma.sock
* Listening on unix:///myapp/tmp/sockets/puma.sock
2023-04-18 20:32:25Puma starting in single mode...
Puma starting in single mode...
2023-04-18 20:32:25* Version 3.12.6 (ruby 3.0.2-p107), codename: Llamas in Pajamas
* Version 3.12.6 (ruby 3.0.2-p107), codename: Llamas in Pajamas
2023-04-18 20:32:25* Min threads: 5, max threads: 5
* Min threads: 5, max threads: 5
2023-04-18 20:32:25* Environment: production
* Environment: production
2023-04-18 20:32:24I, [2023-04-18T20:32:24.019966 #8] INFO -- : Writing /myapp/public/assets/application-e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855.css.gz
I, [2023-04-18T20:32:24.019966 #8] INFO -- : Writing /myapp/public/assets/application-e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855.css.gz
2023-04-18 20:32:24I, [2023-04-18T20:32:24.019727 #8] INFO -- : Writing /myapp/public/assets/application-e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855.css
I, [2023-04-18T20:32:24.019727 #8] INFO -- : Writing /myapp/public/assets/application-e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855.css
2023-04-18 20:32:23I, [2023-04-18T20:32:23.953254 #8] INFO -- : Writing /myapp/public/assets/application-65213f037878bf576e41e63e04ca925db9919ef2cd1fd23de9bbee0ff16e3758.js.gz
I, [2023-04-18T20:32:23.953254 #8] INFO -- : Writing /myapp/public/assets/application-65213f037878bf576e41e63e04ca925db9919ef2cd1fd23de9bbee0ff16e3758.js.gz
2023-04-18 20:32:23I, [2023-04-18T20:32:23.945770 #8] INFO -- : Writing /myapp/public/assets/application-65213f037878bf576e41e63e04ca925db9919ef2cd1fd23de9bbee0ff16e3758.js
I, [2023-04-18T20:32:23.945770 #8] INFO -- : Writing /myapp/public/assets/application-65213f037878bf576e41e63e04ca925db9919ef2cd1fd23de9bbee0ff16e3758.js
2023-04-18 20:32:08I, [2023-04-18T20:32:08.721351 #8] INFO -- : Writing /myapp/public/assets/logo-8802f83d7f00fcbd22b4173c60d172ecaa188042f6306a2154861b2555515ad5.gif
I, [2023-04-18T20:32:08.721351 #8] INFO -- : Writing /myapp/public/assets/logo-8802f83d7f00fcbd22b4173c60d172ecaa188042f6306a2154861b2555515ad5.gif
2023-04-18 20:32:07Done in 0.41s.
Done in 0.41s.
2023-04-18 20:32:07[4/4] Building fresh packages...
[4/4] Building fresh packages...
2023-04-18 20:32:07[3/4] Linking dependencies...
[3/4] Linking dependencies...
2023-04-18 20:32:07[2/4] Fetching packages...
[2/4] Fetching packages...
2023-04-18 20:32:07[1/4] Resolving packages...
[1/4] Resolving packages...
2023-04-18 20:32:07yarn install v1.22.19
yarn install v1.22.19

ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

■nginx
2023-04-18 21:05:38106.72.55.160 - - [18/Apr/2023:12:05:38 +0000] "GET /foo HTTP/1.1" 404 1722 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
106.72.55.160 - - [18/Apr/2023:12:05:38 +0000] "GET /foo HTTP/1.1" 404 1722 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
2023-04-18 21:05:23106.72.55.160 - - [18/Apr/2023:12:05:23 +0000] "GET /foo HTTP/1.1" 404 1722 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
106.72.55.160 - - [18/Apr/2023:12:05:23 +0000] "GET /foo HTTP/1.1" 404 1722 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
2023-04-18 21:05:17106.72.55.160 - - [18/Apr/2023:12:05:17 +0000] "GET /favicon.ico HTTP/1.1" 200 0 "http://54.248.195.48/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
106.72.55.160 - - [18/Apr/2023:12:05:17 +0000] "GET /favicon.ico HTTP/1.1" 200 0 "http://54.248.195.48/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
2023-04-18 21:05:17106.72.55.160 - - [18/Apr/2023:12:05:17 +0000] "GET / HTTP/1.1" 200 615 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
106.72.55.160 - - [18/Apr/2023:12:05:17 +0000] "GET / HTTP/1.1" 200 615 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
2023-04-18 20:32:39106.73.161.97 - - [18/Apr/2023:11:32:39 +0000] "GET /favicon.ico HTTP/1.1" 200 0 "http://54.248.195.48/external_coach/users" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
106.73.161.97 - - [18/Apr/2023:11:32:39 +0000] "GET /favicon.ico HTTP/1.1" 200 0 "http://54.248.195.48/external_coach/users" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
2023-04-18 20:32:39106.73.161.97 - - [18/Apr/2023:11:32:39 +0000] "GET /external_coach/users HTTP/1.1" 500 1635 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
106.73.161.97 - - [18/Apr/2023:11:32:39 +0000] "GET /external_coach/users HTTP/1.1" 500 1635 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
2023-04-18 20:32:33106.73.161.97 - - [18/Apr/2023:11:32:33 +0000] "GET /favicon.ico HTTP/1.1" 502 559 "http://54.248.195.48/external_coach/users" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
106.73.161.97 - - [18/Apr/2023:11:32:33 +0000] "GET /favicon.ico HTTP/1.1" 502 559 "http://54.248.195.48/external_coach/users" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
2023-04-18 20:32:332023/04/18 11:32:33 [crit] 13#13: *2 connect() to unix:///myapp/tmp/sockets/puma.sock failed (2: No such file or directory) while connecting to upstream, client: 106.73.161.97, server: web, request: "GET /favicon.ico HTTP/1.1", upstream: "http://unix:///myapp/tmp/sockets/puma.sock:/favicon.ico", host: "54.248.195.48", referrer: "http://54.248.195.48/external_coach/users"
2023/04/18 11:32:33 [crit] 13#13: *2 connect() to unix:///myapp/tmp/sockets/puma.sock failed (2: No such file or directory) while connecting to upstream, client: 106.73.161.97, server: web, request: "GET /favicon.ico HTTP/1.1", upstream: "http://unix:///myapp/tmp/sockets/puma.sock:/favicon.ico", host: "54.248.195.48", referrer: "http://54.248.195.48/external_coach/users"
2023-04-18 20:32:332023/04/18 11:32:33 [crit] 13#13: *2 connect() to unix:///myapp/tmp/sockets/puma.sock failed (2: No such file or directory) while connecting to upstream, client: 106.73.161.97, server: web, request: "GET /favicon.ico HTTP/1.1", upstream: "http://unix:///myapp/tmp/sockets/puma.sock:/500.html", host: "54.248.195.48", referrer: "http://54.248.195.48/external_coach/users"
2023/04/18 11:32:33 [crit] 13#13: *2 connect() to unix:///myapp/tmp/sockets/puma.sock failed (2: No such file or directory) while connecting to upstream, client: 106.73.161.97, server: web, request: "GET /favicon.ico HTTP/1.1", upstream: "http://unix:///myapp/tmp/sockets/puma.sock:/500.html", host: "54.248.195.48", referrer: "http://54.248.195.48/external_coach/users"
2023-04-18 20:32:332023/04/18 11:32:33 [crit] 13#13: *2 connect() to unix:///myapp/tmp/sockets/puma.sock failed (2: No such file or directory) while connecting to upstream, client: 106.73.161.97, server: web, request: "GET /external_coach/users HTTP/1.1", upstream: "http://unix:///myapp/tmp/sockets/puma.sock:/500.html", host: "54.248.195.48"
2023/04/18 11:32:33 [crit] 13#13: *2 connect() to unix:///myapp/tmp/sockets/puma.sock failed (2: No such file or directory) while connecting to upstream, client: 106.73.161.97, server: web, request: "GET /external_coach/users HTTP/1.1", upstream: "http://unix:///myapp/tmp/sockets/puma.sock:/500.html", host: "54.248.195.48"
2023-04-18 20:32:33106.73.161.97 - - [18/Apr/2023:11:32:33 +0000] "GET /external_coach/users HTTP/1.1" 502 559 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
106.73.161.97 - - [18/Apr/2023:11:32:33 +0000] "GET /external_coach/users HTTP/1.1" 502 559 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
2023-04-18 20:32:332023/04/18 11:32:33 [crit] 13#13: *2 connect() to unix:///myapp/tmp/sockets/puma.sock failed (2: No such file or directory) while connecting to upstream, client: 106.73.161.97, server: web, request: "GET /external_coach/users HTTP/1.1", upstream: "http://unix:///myapp/tmp/sockets/puma.sock:/external_coach/users", host: "54.248.195.48"
2023/04/18 11:32:33 [crit] 13#13: *2 connect() to unix:///myapp/tmp/sockets/puma.sock failed (2: No such file or directory) while connecting to upstream, client: 106.73.161.97, server: web, request: "GET /external_coach/users HTTP/1.1", upstream: "http://unix:///myapp/tmp/sockets/puma.sock:/external_coach/users", host: "54.248.195.48"
2023-04-18 20:32:18106.73.161.97 - - [18/Apr/2023:11:32:18 +0000] "GET /favicon.ico HTTP/1.1" 502 559 "http://54.248.195.48/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
106.73.161.97 - - [18/Apr/2023:11:32:18 +0000] "GET /favicon.ico HTTP/1.1" 502 559 "http://54.248.195.48/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
2023-04-18 20:32:182023/04/18 11:32:18 [crit] 14#14: *1 connect() to unix:///myapp/tmp/sockets/puma.sock failed (2: No such file or directory) while connecting to upstream, client: 106.73.161.97, server: web, request: "GET /favicon.ico HTTP/1.1", upstream: "http://unix:///myapp/tmp/sockets/puma.sock:/500.html", host: "54.248.195.48", referrer: "http://54.248.195.48/"
2023/04/18 11:32:18 [crit] 14#14: *1 connect() to unix:///myapp/tmp/sockets/puma.sock failed (2: No such file or directory) while connecting to upstream, client: 106.73.161.97, server: web, request: "GET /favicon.ico HTTP/1.1", upstream: "http://unix:///myapp/tmp/sockets/puma.sock:/500.html", host: "54.248.195.48", referrer: "http://54.248.195.48/"
2023-04-18 20:32:182023/04/18 11:32:18 [crit] 14#14: *1 connect() to unix:///myapp/tmp/sockets/puma.sock failed (2: No such file or directory) while connecting to upstream, client: 106.73.161.97, server: web, request: "GET /favicon.ico HTTP/1.1", upstream: "http://unix:///myapp/tmp/sockets/puma.sock:/favicon.ico", host: "54.248.195.48", referrer: "http://54.248.195.48/"
2023/04/18 11:32:18 [crit] 14#14: *1 connect() to unix:///myapp/tmp/sockets/puma.sock failed (2: No such file or directory) while connecting to upstream, client: 106.73.161.97, server: web, request: "GET /favicon.ico HTTP/1.1", upstream: "http://unix:///myapp/tmp/sockets/puma.sock:/favicon.ico", host: "54.248.195.48", referrer: "http://54.248.195.48/"
2023-04-18 20:32:18106.73.161.97 - - [18/Apr/2023:11:32:18 +0000] "GET / HTTP/1.1" 200 615 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
106.73.161.97 - - [18/Apr/2023:11:32:18 +0000] "GET / HTTP/1.1" 200 615 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
2023-04-18 20:31:212023/04/18 11:31:21 [notice] 1#1: start worker processes
2023/04/18 11:31:21 [notice] 1#1: start worker processes
2023-04-18 20:31:212023/04/18 11:31:21 [notice] 1#1: start worker process 13
2023/04/18 11:31:21 [notice] 1#1: start worker process 13
2023-04-18 20:31:212023/04/18 11:31:21 [notice] 1#1: start worker process 14
2023/04/18 11:31:21 [notice] 1#1: start worker process 14
2023-04-18 20:31:212023/04/18 11:31:21 [notice] 1#1: using the "epoll" event method
2023/04/18 11:31:21 [notice] 1#1: using the "epoll" event method
2023-04-18 20:31:212023/04/18 11:31:21 [notice] 1#1: nginx/1.23.4
2023/04/18 11:31:21 [notice] 1#1: nginx/1.23.4
2023-04-18 20:31:212023/04/18 11:31:21 [notice] 1#1: built by gcc 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4)
2023/04/18 11:31:21 [notice] 1#1: built by gcc 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4)
2023-04-18 20:31:212023/04/18 11:31:21 [notice] 1#1: OS: Linux 5.10.173-154.642.amzn2.x86_64
2023/04/18 11:31:21 [notice] 1#1: OS: Linux 5.10.173-154.642.amzn2.x86_64
ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

■mariadb
2023-04-18 20:31:39Version: '10.4.28-MariaDB-1:10.4.28+maria~ubu2004' socket: '/var/run/mysqld/mysqld.sock' port: 3306 mariadb.org binary distribution
Version: '10.4.28-MariaDB-1:10.4.28+maria~ubu2004' socket: '/var/run/mysqld/mysqld.sock' port: 3306 mariadb.org binary distribution
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] Reading of all Master_info entries succeeded
2023-04-18 11:31:39 0 [Note] Reading of all Master_info entries succeeded
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] Added new Master_info '' to hash table
2023-04-18 11:31:39 0 [Note] Added new Master_info '' to hash table
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] mysqld: ready for connections.
2023-04-18 11:31:39 0 [Note] mysqld: ready for connections.
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] Server socket created on IP: '::'.
2023-04-18 11:31:39 0 [Note] Server socket created on IP: '::'.
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] InnoDB: Buffer pool(s) load completed at 230418 11:31:39
2023-04-18 11:31:39 0 [Note] InnoDB: Buffer pool(s) load completed at 230418 11:31:39
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] InnoDB: Loading buffer pool(s) from /var/lib/mysql/ib_buffer_pool
2023-04-18 11:31:39 0 [Note] InnoDB: Loading buffer pool(s) from /var/lib/mysql/ib_buffer_pool
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] Plugin 'FEEDBACK' is disabled.
2023-04-18 11:31:39 0 [Note] Plugin 'FEEDBACK' is disabled.
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] InnoDB: 10.4.28 started; log sequence number 60952; transaction id 20
2023-04-18 11:31:39 0 [Note] InnoDB: 10.4.28 started; log sequence number 60952; transaction id 20
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] InnoDB: Waiting for purge to start
2023-04-18 11:31:39 0 [Note] InnoDB: Waiting for purge to start
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] InnoDB: 128 out of 128 rollback segments are active.
2023-04-18 11:31:39 0 [Note] InnoDB: 128 out of 128 rollback segments are active.
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] InnoDB: Creating shared tablespace for temporary tables
2023-04-18 11:31:39 0 [Note] InnoDB: Creating shared tablespace for temporary tables
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] InnoDB: Setting file './ibtmp1' size to 12 MB. Physically writing the file full; Please wait ...
2023-04-18 11:31:39 0 [Note] InnoDB: Setting file './ibtmp1' size to 12 MB. Physically writing the file full; Please wait ...
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] InnoDB: File './ibtmp1' size is now 12 MB.
2023-04-18 11:31:39 0 [Note] InnoDB: File './ibtmp1' size is now 12 MB.
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. See the man page of setpriority().
2023-04-18 11:31:39 0 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. See the man page of setpriority().
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] InnoDB: Completed initialization of buffer pool
2023-04-18 11:31:39 0 [Note] InnoDB: Completed initialization of buffer pool
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] InnoDB: Initializing buffer pool, total size = 256M, instances = 1, chunk size = 128M
2023-04-18 11:31:39 0 [Note] InnoDB: Initializing buffer pool, total size = 256M, instances = 1, chunk size = 128M
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] InnoDB: Using Linux native AIO
2023-04-18 11:31:39 0 [Note] InnoDB: Using Linux native AIO
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
2023-04-18 11:31:39 0 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] InnoDB: Uses event mutexes
2023-04-18 11:31:39 0 [Note] InnoDB: Uses event mutexes
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] InnoDB: Compressed tables use zlib 1.2.11
2023-04-18 11:31:39 0 [Note] InnoDB: Compressed tables use zlib 1.2.11
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] InnoDB: Number of pools: 1
2023-04-18 11:31:39 0 [Note] InnoDB: Number of pools: 1
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] InnoDB: Using SSE2 crc32 instructions
2023-04-18 11:31:39 0 [Note] InnoDB: Using SSE2 crc32 instructions
2023-04-18 20:31:392023-04-18 11:31:39 0 [Note] mysqld: O_TMPFILE is not supported on /tmp (disabling future attempts)
2023-04-18 11:31:39 0 [Note] mysqld: O_TMPFILE is not supported on /tmp (disabling future attempts)
2023-04-18 20:31:382023-04-18 11:31:38 0 [Note] Starting MariaDB 10.4.28-MariaDB-1:10.4.28+maria~ubu2004 source revision c8f2e9a5c0ac5905f28b050b7df5a9ffd914b7e7 as process 1
2023-04-18 11:31:38 0 [Note] Starting MariaDB 10.4.28-MariaDB-1:10.4.28+maria~ubu2004 source revision c8f2e9a5c0ac5905f28b050b7df5a9ffd914b7e7 as process 1
2023-04-18 20:31:382023-04-18 11:31:38 0 [Warning] Could not increase number of max_open_files to more than 1024 (request: 6533)
2023-04-18 11:31:38 0 [Warning] Could not increase number of max_open_files to more than 1024 (request: 6533)
2023-04-18 20:31:382023-04-18 11:31:38+00:00 [Note] [Entrypoint]: MariaDB init process done. Ready for start up.
2023-04-18 11:31:38+00:00 [Note] [Entrypoint]: MariaDB init process done. Ready for start up.
2023-04-18 20:31:382023-04-18 11:31:38+00:00 [Note] [Entrypoint]: Temporary server stopped
2023-04-18 11:31:38+00:00 [Note] [Entrypoint]: Temporary server stopped
2023-04-18 20:31:382023-04-18 11:31:38 0 [Note] mysqld: Shutdown complete
2023-04-18 11:31:38 0 [Note] mysqld: Shutdown complete
2023-04-18 20:31:382023-04-18 11:31:38 0 [Note] InnoDB: Removed temporary tablespace data file: "ibtmp1"
2023-04-18 11:31:38 0 [Note] InnoDB: Removed temporary tablespace data file: "ibtmp1"
2023-04-18 20:31:382023-04-18 11:31:38 0 [Note] InnoDB: Shutdown completed; log sequence number 60952; transaction id 21
2023-04-18 11:31:38 0 [Note] InnoDB: Shutdown completed; log sequence number 60952; transaction id 21
2023-04-18 20:31:362023-04-18 11:31:36 0 [Note] InnoDB: Starting shutdown...
2023-04-18 11:31:36 0 [Note] InnoDB: Starting shutdown...
2023-04-18 20:31:362023-04-18 11:31:36 0 [Note] InnoDB: Dumping buffer pool(s) to /var/lib/mysql/ib_buffer_pool
2023-04-18 11:31:36 0 [Note] InnoDB: Dumping buffer pool(s) to /var/lib/mysql/ib_buffer_pool
2023-04-18 20:31:362023-04-18 11:31:36 0 [Note] InnoDB: Buffer pool(s) dump completed at 230418 11:31:36
2023-04-18 11:31:36 0 [Note] InnoDB: Buffer pool(s) dump completed at 230418 11:31:36
2023-04-18 20:31:362023-04-18 11:31:36 0 [Note] InnoDB: FTS optimize thread exiting.
2023-04-18 11:31:36 0 [Note] InnoDB: FTS optimize thread exiting.
2023-04-18 20:31:362023-04-18 11:31:36 0 [Note] Event Scheduler: Purging the queue. 0 events
2023-04-18 11:31:36 0 [Note] Event Scheduler: Purging the queue. 0 events
2023-04-18 20:31:362023-04-18 11:31:36+00:00 [Note] [Entrypoint]: Stopping temporary server
2023-04-18 11:31:36+00:00 [Note] [Entrypoint]: Stopping temporary server
2023-04-18 20:31:362023-04-18 11:31:36 0 [Note] mysqld (initiated by: unknown): Normal shutdown
2023-04-18 11:31:36 0 [Note] mysqld (initiated by: unknown): Normal shutdown
2023-04-18 20:31:362023-04-18 11:31:36+00:00 [Note] [Entrypoint]: /usr/local/bin/docker-entrypoint.sh: running /docker-entrypoint-initdb.d/init.sql
2023-04-18 11:31:36+00:00 [Note] [Entrypoint]: /usr/local/bin/docker-entrypoint.sh: running /docker-entrypoint-initdb.d/init.sql
2023-04-18 20:31:362023-04-18 11:31:36+00:00 [Note] [Entrypoint]: Securing system users (equivalent to running mysql_secure_installation)
2023-04-18 11:31:36+00:00 [Note] [Entrypoint]: Securing system users (equivalent to running mysql_secure_installation)
2023-04-18 20:31:362023-04-18 11:31:36+00:00 [Note] [Entrypoint]: Giving user dbuser access to schema tagmatch
2023-04-18 11:31:36+00:00 [Note] [Entrypoint]: Giving user dbuser access to schema tagmatch
2023-04-18 20:31:362023-04-18 11:31:36+00:00 [Note] [Entrypoint]: Creating user dbuser
2023-04-18 11:31:36+00:00 [Note] [Entrypoint]: Creating user dbuser
2023-04-18 20:31:362023-04-18 11:31:36+00:00 [Note] [Entrypoint]: Creating database tagmatch
2023-04-18 11:31:36+00:00 [Note] [Entrypoint]: Creating database tagmatch
2023-04-18 20:31:302023-04-18 11:31:30+00:00 [Note] [Entrypoint]: Temporary server started.
2023-04-18 11:31:30+00:00 [Note] [Entrypoint]: Temporary server started.
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] Reading of all Master_info entries succeeded
2023-04-18 11:31:29 0 [Note] Reading of all Master_info entries succeeded
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] Added new Master_info '' to hash table
2023-04-18 11:31:29 0 [Note] Added new Master_info '' to hash table
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] mysqld: ready for connections.
2023-04-18 11:31:29 0 [Note] mysqld: ready for connections.
2023-04-18 20:31:29Version: '10.4.28-MariaDB-1:10.4.28+maria~ubu2004' socket: '/var/run/mysqld/mysqld.sock' port: 0 mariadb.org binary distribution
Version: '10.4.28-MariaDB-1:10.4.28+maria~ubu2004' socket: '/var/run/mysqld/mysqld.sock' port: 0 mariadb.org binary distribution
2023-04-18 20:31:292023-04-18 11:31:29 0 [Warning] 'proxies_priv' entry '@% root@881ef595a95544888a14643f7aa8ddcb-235824611' ignored in --skip-name-resolve mode.
2023-04-18 11:31:29 0 [Warning] 'proxies_priv' entry '@% root@881ef595a95544888a14643f7aa8ddcb-235824611' ignored in --skip-name-resolve mode.
2023-04-18 20:31:292023-04-18 11:31:29 0 [Warning] 'user' entry 'root@881ef595a95544888a14643f7aa8ddcb-235824611' ignored in --skip-name-resolve mode.
2023-04-18 11:31:29 0 [Warning] 'user' entry 'root@881ef595a95544888a14643f7aa8ddcb-235824611' ignored in --skip-name-resolve mode.
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] Plugin 'FEEDBACK' is disabled.
2023-04-18 11:31:29 0 [Note] Plugin 'FEEDBACK' is disabled.
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] InnoDB: 10.4.28 started; log sequence number 60943; transaction id 20
2023-04-18 11:31:29 0 [Note] InnoDB: 10.4.28 started; log sequence number 60943; transaction id 20
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] InnoDB: Waiting for purge to start
2023-04-18 11:31:29 0 [Note] InnoDB: Waiting for purge to start
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] InnoDB: Creating shared tablespace for temporary tables
2023-04-18 11:31:29 0 [Note] InnoDB: Creating shared tablespace for temporary tables
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] InnoDB: Setting file './ibtmp1' size to 12 MB. Physically writing the file full; Please wait ...
2023-04-18 11:31:29 0 [Note] InnoDB: Setting file './ibtmp1' size to 12 MB. Physically writing the file full; Please wait ...
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] InnoDB: File './ibtmp1' size is now 12 MB.
2023-04-18 11:31:29 0 [Note] InnoDB: File './ibtmp1' size is now 12 MB.
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] InnoDB: 128 out of 128 rollback segments are active.
2023-04-18 11:31:29 0 [Note] InnoDB: 128 out of 128 rollback segments are active.
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. See the man page of setpriority().
2023-04-18 11:31:29 0 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. See the man page of setpriority().
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] InnoDB: Completed initialization of buffer pool
2023-04-18 11:31:29 0 [Note] InnoDB: Completed initialization of buffer pool
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] InnoDB: Initializing buffer pool, total size = 256M, instances = 1, chunk size = 128M
2023-04-18 11:31:29 0 [Note] InnoDB: Initializing buffer pool, total size = 256M, instances = 1, chunk size = 128M
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] InnoDB: Using Linux native AIO
2023-04-18 11:31:29 0 [Note] InnoDB: Using Linux native AIO
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
2023-04-18 11:31:29 0 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] InnoDB: Uses event mutexes
2023-04-18 11:31:29 0 [Note] InnoDB: Uses event mutexes
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] InnoDB: Compressed tables use zlib 1.2.11
2023-04-18 11:31:29 0 [Note] InnoDB: Compressed tables use zlib 1.2.11
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] InnoDB: Number of pools: 1
2023-04-18 11:31:29 0 [Note] InnoDB: Number of pools: 1
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] InnoDB: Using SSE2 crc32 instructions
2023-04-18 11:31:29 0 [Note] InnoDB: Using SSE2 crc32 instructions
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] mysqld: O_TMPFILE is not supported on /tmp (disabling future attempts)
2023-04-18 11:31:29 0 [Note] mysqld: O_TMPFILE is not supported on /tmp (disabling future attempts)
2023-04-18 20:31:292023-04-18 11:31:29 0 [Note] Starting MariaDB 10.4.28-MariaDB-1:10.4.28+maria~ubu2004 source revision c8f2e9a5c0ac5905f28b050b7df5a9ffd914b7e7 as process 139
2023-04-18 11:31:29 0 [Note] Starting MariaDB 10.4.28-MariaDB-1:10.4.28+maria~ubu2004 source revision c8f2e9a5c0ac5905f28b050b7df5a9ffd914b7e7 as process 139
2023-04-18 20:31:292023-04-18 11:31:29 0 [Warning] Could not increase number of max_open_files to more than 1024 (request: 6533)
2023-04-18 11:31:29 0 [Warning] Could not increase number of max_open_files to more than 1024 (request: 6533)
2023-04-18 20:31:292023-04-18 11:31:29+00:00 [Note] [Entrypoint]: Waiting for server startup
2023-04-18 11:31:29+00:00 [Note] [Entrypoint]: Waiting for server startup
2023-04-18 20:31:292023-04-18 11:31:29+00:00 [Note] [Entrypoint]: Starting temporary server
2023-04-18 11:31:29+00:00 [Note] [Entrypoint]: Starting temporary server
2023-04-18 20:31:292023-04-18 11:31:29+00:00 [Note] [Entrypoint]: Database files initialized
2023-04-18 11:31:29+00:00 [Note] [Entrypoint]: Database files initialized
2023-04-18 20:31:29PLEASE REMEMBER TO SET A PASSWORD FOR THE MariaDB root USER !
PLEASE REMEMBER TO SET A PASSWORD FOR THE MariaDB root USER !
2023-04-18 20:31:29To do so, start the server, then issue the following command:
To do so, start the server, then issue the following command:
2023-04-18 20:31:29'/usr/bin/mysql_secure_installation'
'/usr/bin/mysql_secure_installation'
2023-04-18 20:31:29which will also give you the option of removing the test
which will also give you the option of removing the test
2023-04-18 20:31:29databases and anonymous user created by default. This is
databases and anonymous user created by default. This is
2023-04-18 20:31:29strongly recommended for production servers.
strongly recommended for production servers.
2023-04-18 20:31:29See the MariaDB Knowledgebase at http://mariadb.com/kb
See the MariaDB Knowledgebase at http://mariadb.com/kb
2023-04-18 20:31:29Please report any problems at http://mariadb.org/jira
Please report any problems at http://mariadb.org/jira
2023-04-18 20:31:29The latest information about MariaDB is available at http://mariadb.org/.
The latest information about MariaDB is available at http://mariadb.org/.
2023-04-18 20:31:29Consider joining MariaDB's strong and vibrant community:
Consider joining MariaDB's strong and vibrant community:
2023-04-18 20:31:29https://mariadb.org/get-involved/
https://mariadb.org/get-involved/
2023-04-18 20:31:262023-04-18 11:31:26+00:00 [Note] [Entrypoint]: Initializing database files
2023-04-18 11:31:26+00:00 [Note] [Entrypoint]: Initializing database files
2023-04-18 20:31:242023-04-18 11:31:24+00:00 [Note] [Entrypoint]: Entrypoint script for MariaDB Server 1:10.4.28+maria~ubu2004 started.
2023-04-18 11:31:24+00:00 [Note] [Entrypoint]: Entrypoint script for MariaDB Server 1:10.4.28+maria~ubu2004 started.
2023-04-18 20:31:242023-04-18 11:31:24+00:00 [Note] [Entrypoint]: Switching to dedicated user 'mysql'
2023-04-18 11:31:24+00:00 [Note] [Entrypoint]: Switching to dedicated user 'mysql'
2023-04-18 20:31:212023-04-18 11:31:21+00:00 [Note] [Entrypoint]: Entrypoint script for MariaDB Server 1:10.4.28+maria~ubu2004 started.
2023-04-18 11:31:21+00:00 [Note] [Entrypoint]: Entrypoint script for MariaDB Server 1:10.4.28+maria~ubu2004 started.
ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー


■rails s
~/web-app/tag-match/myapp % aws ecs execute-command --region ap-northeast-1 --cluster tag-match-ecs --task 881ef595a95544888a14643f7aa8ddcb --container rails_app --interactive --command "/bin/sh"

The Session Manager plugin was installed successfully. Use the AWS CLI to start a session.


Starting session with SessionId: ecs-execute-command-0235b0473ba70ae69
#
#
# ls
Dockerfile	Gemfile.lock  app      config	   db			   favicon.ico	mariadb-dockerfile  node_modules  ruby			     spec      test	vendor
Dockerfile.dev	README.md     bin      config.ru   docker-compose.dev.yml  lib		mysqldb-dockerfile  package.json  sessionmanager-bundle      start.sh  test.rb	yarn.lock
Gemfile		Rakefile      chatgpt  containers  entrypoint.sh	   log		nginx		    public	  sessionmanager-bundle.zip  storage   tmp
#
#
# rails s
=> Booting Puma
=> Rails 6.1.4.7 application starting in development
=> Run `bin/rails server --help` for more startup options
A server is already running. Check /myapp/tmp/pids/server.pid.
Exiting
#
#
#
# ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0   5728  3120 ?        Ss   20:31   0:00 bash start.sh
root         9  0.0  0.3 1322116 13684 ?       Ssl  20:31   0:00 /managed-agents/execute-command/amazon-ssm-agent
root        24  0.0  0.6 1408324 24152 ?       Sl   20:31   0:00 /managed-agents/execute-command/ssm-agent-worker
root        90  0.1  2.6 909548 103020 ?       Sl   20:32   0:02 puma 3.12.6 (tcp://0.0.0.0:3000,unix:///myapp/tmp/sockets/puma.sock) [myapp]
root       129  0.1  0.5 1326628 21212 ?       Sl   20:59   0:00 /managed-agents/execute-command/ssm-session-worker ecs-execute-command-0235b0473ba70ae69
root       139  0.0  0.0   2420   580 pts/0    Ss   20:59   0:00 /bin/sh
root       152  0.0  0.0   8592  3320 pts/0    R+   21:03   0:00 ps aux
#
#
# kill 90
#
------------------------------------------------------


なぜpuma用のソケットがここで指定されているのか分かりませんが、そもそもソケットでMySQLと接続しようとしているわけではなくtcpの3306ポートで接続しようとしているのだと思いますので、ここの行は削除する必要がありますね。

bundle exec rake db:cr
bundle exec rake db:create


