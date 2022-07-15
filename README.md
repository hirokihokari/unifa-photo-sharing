# README

開発ステップ

1. docker-compose up
```
// プロジェクトディレクトリのルートで
$ docker-compose up --build
```

2. DBを設定する
```
$ docker-compose run --rm rails rails db:setup

# seed => ユーザーID: UniTarou / パスワード: password
```
