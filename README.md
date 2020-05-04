# README

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

# 参考
 https://www.youtube.com/watch?v=jmrGgPaZqro ¥¥
↑この動画の概要欄に動画で使った参考ページのリンクある

* Dockerfile
* docker-comopse.yml
* Gemfile
* Gemfile.lock

を用意したら以下のように進める。

これでいけるはず。

```
docker-compose run web rails new . --force --database=mysql --skip-bundle
```
```
docker-compose build
```
docker-compose build でこけたら、以下を実施
```
docker-compose run web bundle update
```

そのあと、
```
docker-compose up -d
docker-compose run web bundle exec rails db:create
```

コンテナに入ってからmysqlに入るには、/app配下で
```
mysql -u root -ppassword -h db
```

---

docker-compose upしたときにtmp/pids/server.pidを確認してくださいと出たときは下記のコマンドを実行してサーバーファイルを消す
```
rm -f tmp/pids/server.pid
```
[参考](https://qiita.com/paranishian/items/862ce4de104992df48e1)


コンテナを一括削除するとき
```
docker rm $(docker ps -aq)
```

# ロゴ

こんなふうに使うとよさそうか
https://matome.naver.jp/odai/2137235809433069901

scssの書き方
https://qiita.com/nchhujimiyama/items/8a6aad5abead39d1352a

# 画面固有JSファイルの適用方法
デフォルトのapp/assets/javascripts/application.jsに記載されている```//= require_tree .```では、
app/assets/javascripts配下にあるファイルが全画面で読み込まれてしまうらしい。
← バグの原因になりうる。

以下の方法で回避する
* app/assets/javascripts配下に「コントローラー名＋js.js」としてJSファイルを作成
 * 例) app/assets/javascripts/logsjs.js
* 対象erbファイルの最上部に```<%= javascript_include_tag "JSファイル名" %>```を挿入
 * 例) <%= javascript_include_tag "logsjs.js" %>

### 「コントローラー名＋.js」でなく「コントローラー名＋js.js」とする理由
rails g controller コントローラー名 した際に```app/assets/javascripts/コントローラー名.coffee```が自動作成される

coffeeファイルがあると、同じ名前で作ったjsファイルがあっても、coffeeファイルが優先的にRailsから呼び出されるため、jsファイルが呼び出されないくなる。
参考:[RailsでJSファイルが読み込まれない！と困った話](https://qiita.com/s-yank/items/cf7cadbb6c6996d67cf7)

