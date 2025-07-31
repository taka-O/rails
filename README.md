# README
railsサンプル

# 環境
ruby 3.4<br/>
rails 8.0<br/>
mysql 8.4<br/>

# Dockerセットアップ、および起動
<ul>
<li>Dockerセットアップ、および起動</li>
docker compose up -d<br>
  ※　エラー「network dev_network declared as external, but could not be found」が表示された場合、compose.ymlの「external: true」をコメントアウトして再実行する
<li>bundle install（railsコンテナの起動に失敗するため）</li>
docker compose run --rm rails bundle install
<li>Dockerを再度起動</li>
docker compose up -d
</ul>

# Docker rails環境への接続
docker compose exec rails bash

# rspec
bundle exec rspec spec

# Rubocop
bundle exec rubocop<br/>
bundle exec rubocop -a（自動修正）
