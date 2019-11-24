# CharacterAlarm

- アーキテクチャは MVP を採用
  - View にはレイアウトを書く
  - Presenter には View の操作に関する事
  - Model にはロジックを書き、状態を持たせます。


### 設定方法 ###

- Xcodeのインストール
- Bundlerのインストール
- Podのインストール

#### Xcodeのインストール ####

App Store から

#### rbenvのインストール ####

```
brew update
brew install rbenv ruby-build
rbenv install -l
rbenv install 2.6.4  # 最新版をインストール
rbenv versions  # インストール済みのバージョンを表示

cd
atom .bash_profile  # .bash_profile に記述
```

```
eval "$(rbenv init -)"
```

```
rbenv global 2.6.4  # 使用バージョンを設定
ruby -v  # 切り替わっていることを確認
```

#### Bundlerのインストール ####

```
gem install bundler -v 2.0.2
gem list bundler
bundle -v
```

#### Podのインストール ####

```
bundle _2.0.2_ install --path vendor/bundle
```

#### セットアップ ####

```
bundle exec pod install  # 依存パッケージのインストールとプロジェクト生成 (Pod用)
```

#### Podライブラリのアップデート ####

```
bundle exec pod update
```


Xcodeで起動する際は `*.xcodeproj` ではなく `*.xcworkspace` をダブルクリックして起動してください
以下のコマンドでも起動可能です

```
open CharacterAlarm.xcworkspace
```



## 作業の流れ

- issue の内容を確認する。良くわからなければ小野に質問してください。
- feature/作業内容_#issue番号 でブランチを作成し、作業する。
- 小野にプルリクを飛ばす
- マージされたらお支払い