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


