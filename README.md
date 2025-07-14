# README

railsサッmプル

# 環境
rails 8.0
mysql 8.4

# Dockerセットアップ、および起動
docker compose up -d

# Docker rails環境への接続
docker compose exec rails bash

# rspec
bundle exec rspec spec

# Rubocop
bundle exec rubocop
bundle exec rubocop -a（自動修正）
