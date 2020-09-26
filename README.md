## Debian 開発環境構築

本リポジトリは、Debian上に開発環境を構築するためのインストーラ集です。<br>

## 動作環境

Debian 環境では、Debian10 で動作確認済みです。<br>
Debian 派生ディストリビューション（例：Ubuntu）では、動作未確認です。<br>
「パッケージ対応状況」や「パッケージ名の差異」が Debian と派生ディストリとの間であるため、一部のスクリプトが動作しない可能性があります。

## 使い方

make コマンドでインストールしたいツールを指定し、ツールのインストールを行います。

```
$ git clone https://github.com/nao1215/SetupDevelopmentEnvironmentForDebian.git
$ cd SetupDevelopmentEnvironmentForDebian
$ sudo make $(ツール名)

[e.g.]
$ sudo make neovim
```

## インストール可能なツール一覧

| ツール名 | 説明                                                           |
| -------- | -------------------------------------------------------------- |
| fish     | fish shellおよびfisherプラグインマネージャをインストールする。 |
| kernel   | Linux Kernel開発ツールをインストールする。                     |
| neovim   | neovimおよびvim設定ファイルをインストールする。                |
| python3  | Python3および関連ライブラリをインストールする。                |
| terminal | CLIツールをインストールする。                                  |

## ライセンス
本リポジトリは、MITライセンスの下で管理されています。<br>
ライセンスの詳細は、[LICENSE](LICENSE)ファイルを参照してください。
