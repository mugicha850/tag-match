FROM ruby:3.0.2

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn



# タイムゾーン設定
ENV TZ=Asia/Tokyo



# cronのインストール
RUN apt-get update && apt-get install -y \
  busybox-static \
  && apt-get clean



# アプリケーションフォルダを環境変数として設定
ENV APP_HOME /usr/share/nginx

# nginxのuidとgidをdocker user uid/gidに変更。
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data


# ソースコードと.envファイルをDockerImageに埋め込む
COPY . $APP_HOME
COPY .env /usr/share/nginx/html/.env

# 初回起動時に行うスクリプトファイルをコピーして実行権限を与える
COPY start.sh /usr/share/nginx/html/start.sh
RUN chmod 744 /usr/share/nginx/html/start.sh

# 必ずキャッシュ用のディレクトリを作っておくこと→ Fargateの場合ずっとキャッシュが残ることになる
# RUN mkdir storage/framework/cache/data

# フレームワークに必要なモジュールをDockerImageにインストール
# RUN composer install --no-dev --no-interaction

# 書き込み権限を与える
RUN chown -R www-data:www-data $APP_HOME



RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN rm -rf vendor/cache
RUN bundle config set force_ruby_platform true 
RUN bundle install -j4

COPY ./bin/webpack /bin/webpack
RUN chmod +x /bin/webpack
RUN NODE_ENV=production /bin/webpack

RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids


COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]


COPY . /myapp

VOLUME /myapp/public
VOLUME /myapp/tmp

# CMD ruby artisan migrate --force
CMD ["bash", "start.sh"]