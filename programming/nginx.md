# nginx 実践入門

目的はOpenRestyの章

1.1 nginx
nginx は 軽量かつ高いスケーラビリティを誇るオープンソースのHTTPサーバ

## nginx の特徴

- アクセス制御
- URI Rewrite
- gzip compression
- reverse proxy
- L7 load balance
- contents cache
- SSL termination
- HTTP/2 gatewai
- L4 load balance
- mail proxy

## nginx のarchitecture

- Event-Driven

libevent, libuv

- event
 - accept
 - read
 - write

## I/O multiplexing

複数のファイルディスクリプタを監視し、それらのどれかが入出力可能になるまでプログラムを待機させる
select, epoll, kqueue など

## non-blocking I/O

通常,(blocking-I/Oでは)I/O 関連のシステムコールが処理を完了するまでプログラムがブロックされる
non-blocking I/Oの場合, I/Oシステムコールによってプログラムがブロックされる見込みの場合即errorと適切なerrnoがセットされる

stream 系統のモジュールはTCPのレイヤでリクエストをプロキシするためのもの

--with-stream

nginx コマンドに-sをつけるのはマスタプロセスへのシグナル発行

nginx.pid に直接signalを送っても良い

system service としても実行できる

プログラムの並行性が高められる

## nginx の動作モデル

nginx はマスタプロセスとワーカプロセスのマルチプロセス構成で稼働する
マスタプロセス:ワーカプロセス = 1:N
マスタプロセスはワーカプロセスのPidを保持している
これによって命令することで全体のプロセスを制御する
SIGTERM, SIGQUIT, SIGHUP など送られた場合マスタプロセスはまずワーカプロセスにシグナルを送る

# 2

- 依存ライブラリの静的な読み込み

PCRE, zlib, OpenSSL など

- あらかじめインストールされているライブラリを検索し動的にリンクする
- nginx と一緒にビルドして静的にリンクする

```
./configure --with-pcre=/path/to/pcre/dir
```

最新のOpenRestyだとLuaJITのみ

nginx の機能はすべてモジュール構造

nginx では変数名の先頭にドル記号をつける

$url
$status
$scheme

$arg_page など

include directive

相対パスで指定できる

include sites-enabled/*.conf;


## HTTP サーバに関する設定

ngx_http_core_module

### http context の定義

```
http {
}

```

### バーチャルサーバの定義

```
server {
  server_name = static.examble.com;
}
```

- listen directive

types {} とすることで拡張子による割り当てを無効にする

- log_format directive

user directive によりworker process の実行ユーザを指定できる

events directive

worker_connections directive

keepalive_timeout directiveを0にするとクライアントからの常時接続を0にできる

sendfile directive

tcp_nopush directive

open_file_cache directive
一度オープンしたファイルの情報を一定期間保存する

ngx.sharedとngx.ctx の違い
ワーカプロセス間でデータを共有できるので音メモリKVS的に利用できる
get, set が使える

ngx_lua ではノンブロッキング処置のサポートがされている
ngx.location.capture()
nginx の別のロケーションに対して内部的なHTTPリクエストを発行してレスポンスを取得する。
この処理がノンブロッキングなので便利

