# 配信用のキルデスカウンター

基本的に無サポート。自分用なので

## インストール方法・動かし方

### コンテナで動かす（簡単）

- docker, docker-compose をインストールする
- docker-compose.yml を環境に合わせて修正する（ポート番号とか）
- `docker-compose build` でイメージを作成する
- `docker-compose up` で起動する

### nginx で動かす（難易度高め、非推奨）
- spawn-fcgi, fcgiwrap をインストールして nginx で動かせるように設定する
  - [参考:fcgiwrapをインストールしてNginxでCGIを動かす](https://worklog.be/archives/3230)
- nginx で設定する
```
# ※ スクリプトが /home/www/default/html/cgi/hogehoge/ にある場合
location /cgi/ {
  root /home/www/default/html;
  include /etc/nginx/fcgiwrap.conf;
}
```
- index.rb, app.rb を修正する
  - 特に1行目は環境依存の書き方をしているので修正必須
- gem を bundle してインストールする(以下のどちらか。rbenv 使ってる場合は前者)
  - `rbenv exec bundle`
  - `bundle`
- とりあえず、gem とか入ってるか、ruby が動いてるかどうか確認したいなら
  - `rbenv exec bundle exec ruby app.rb`
  - `bundle exec ruby app.rb`
- 動作確認する
  - http://example.com/cgi/url/index.rb


## 構成要素と注意点

- index.rb
  - nginx で動作させる場合のマウントポイント
  - 1行目は環境に合わせて修正してください
  - rbenv で ruby 2.7.3 を入れている想定で書かれています
- app.rb
  - メインプログラム
  - nginx を使わずに、コンテナも使わない場合は、このファイルを実行すると webrick サーバーが起動する
- db/stream.db
  - db ディレクトリはパーミッションを 777 にしてください。
  - stream.db はパーミッションを 666 にしてください。
  - 何もない場合は db ディレクトリさえあれば勝手に作成する
- public/
  - 静的なファイル（画像や JavaScript ファイル）の置き場
- views/
  - テンプレートファイル。HTML として出力される元となるファイル
- esp32/
  - Arduino IDE で書き込む用のスケッチサンプル
  - URL や無線LANアクセスポイントのSSID，パスワードは自分の環境に合わせて書き直してください
