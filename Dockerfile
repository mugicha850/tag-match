FROM ruby:3.0.2

RUN apt-get update && apt-get install -y apache2

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
ENV APP_HOME /var/www/html

# apacheのuidとgidをdocker user uid/gidに変更。
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

#change the web_root to laravel /var/www/html/public folder
# RUN sed -i -e "s/html/html\/public/g" /etc/apache2/sites-enabled/000-default.conf
COPY ./ruby/vhost.conf /etc/apache2/conf-enabled/vhost.conf

#  apache module rewrite を有効にする
RUN a2enmod rewrite

# ソースコードと.envファイルをDockerImageに埋め込む
COPY . $APP_HOME
COPY .env.production /var/www/html/.env
# 初回起動時に行うスクリプトファイルをコピーして実行権限を与える
COPY ./ruby/start.sh /var/www/html/start.sh
RUN chmod 744 /var/www/html/start.sh

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

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

COPY . /myapp


# CMD ruby artisan migrate --force
CMD ["bash", "start.sh"]
