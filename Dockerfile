# ベースとなるイメージの指定　rubyのバージョン2.5.0を指定しています
FROM ruby:2.5.0
# パッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       nodejs
# コンテナ上の作業ディレクトリの作成
RUN mkdir /app
# 作業ディレクトリの指定
WORKDIR /app
# ローカル上のファイルをコンテナ上の作業ディレクトリにコピー
COPY ./Gemfile /app/Gemfile
COPY ./Gemfile.lock /app/Gemfile.lock
# gemのインストール
RUN bundle install
# ローカルのファイルを全部コンテナにコピー
COPY . /app