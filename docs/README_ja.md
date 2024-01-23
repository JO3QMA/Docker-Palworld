# Docker-Palworld

[English README](/README.md)

このリポジトリは、パルワールドのサーバーをDockerで簡単に立ち上げるためのファイルをまとめたものです。

## サーバーの起動方法 (docker composeを使用する場合)
1. このリポジトリをクローンする
1. クローンしたリポジトリのディレクトリに移動する
1. `compose.yml.sample`を`compose.yml`にリネームし、設定を書き換える
1. `docker compose up -d` を実行する

## サーバーの起動方法 (systemd serviceを使用する場合)
1. このリポジトリをクローンする
1. クローンしたリポジトリのディレクトリに移動する
1. `compose.yml.sample`を`compose.yml`にリネームし、設定を書き換える
1. `./systemd/palworld.service`の`COMPOSE_DIR`を現在のディレクトリに書き換える
1. `sudo systemctl link ./service/palworld.service`を実行する
1. `sudo systemctl enable --now palworld.service` を実行する

## サーバー自動再起動 (systemd serviceを使用している場合のみ)
1. `sudo systemctl link ./service/palworld-restart.service`を実行する
1. `sudo systemctl link ./service/palworld-restart.timer`を実行する
1. `sudo systemctl enable --now palworld-restarter.timer`を実行する

## 機能一覧
* 簡単にサーバーを起動できます
* パルワールドに更新がある場合、自動的に更新します
* メモリ使用量に基づいたdockerヘルスレポートを提供します (ベータ)
    * この機能が必要ない場合は`compose.yml`から`healthcheck`節を削除してください
