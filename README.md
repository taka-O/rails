# README
railsサンプル

# 環境
ruby 3.4<br/>
rails 8.0<br/>
mysql 8.4<br/>

# Dockerセットアップ、および起動
docker compose up -d

# Docker rails環境への接続
docker compose exec rails bash

# rspec
bundle exec rspec spec

# Rubocop
bundle exec rubocop<br/>
bundle exec rubocop -a（自動修正）
