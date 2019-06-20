# profilePage

## Setup
1. git clone this project
1. cd /path/to/this/app
1. npm i
1. make all

## Software
- [Git for Windows SDK](https://github.com/git-for-windows/build-extra/releases)
- [Docker Toolbox](https://docs.docker.com/toolbox/overview/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Node.js 1](https://nodejs.org/en/)
- [Node.js 2](https://tecadmin.net/install-latest-nodejs-npm-on-ubuntu/)

## TODO
- ログ出力。何をどの程度どのように吐くか。ダウンロードできるようにする？
- 実際にクラウドにぶち上げて確認。HTTPS大丈夫？
- ディレクトリ構成や名前は問題ないか
- 継続的xxxについて調査
- テンプレートエンジン処理やログロジックの分離

## Browsersync
`node node_modules/browser-sync/dist/bin.js start --proxy 192.168.99.100:33301 --files './**/*'`

- URLやファイルは状況に合わせること
- URL等を固定して簡単に実行できるようにしたい場合、うまくやるには多分次のような手段が必要
    1. docker-machineの利用
    1. オーケストレータの導入

## Coding Style
- [Dockerfile](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- [Docker Compose](https://medium.com/@innossh/docker-compose-best-practice-73746ac3f13a)
- [Node](https://popkirby.github.io/contents/nodeguide/style.html)
- [Express](http://expressjs.com/en/advanced/best-practice-performance.html)
