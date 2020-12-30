## Debian 開発環境構築

本リポジトリは、Debian 上に開発環境を構築するためのインストーラ集です。<br>

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

| ツール名 | 説明                                                              |
| -------- | ----------------------------------------------------------------- |
| c_plusplus       |C++関連ライブラリをインストールする。                        |
| go       | Go言語および関連ツールをインストールする。                        |
| fish     | fish shell および fisher プラグインマネージャをインストールする。 |
| java     | Java および Java 関連ツール(Gradle など)をインストールする。      |
| kernel   | Linux Kernel 開発ツールをインストールする。                       |
| neovim   | neovim および vim 設定ファイルをインストールする。                |
| python3  | Python3 および関連ライブラリをインストールする。                  |
| rust     | Rustをインストールする。                                          |
| sdkman   | SDKMAN（Java 等の JVM 環境設定ツール）をインストールする。        |
| terminal | CLI ツールをインストールする。                                    |
| tmux     | tmux および tmux 設定ファイルをインストールする。                 |

## ライセンス

本リポジトリは、MIT ライセンスの下で管理されています。<br>
ライセンスの詳細は、[LICENSE](LICENSE)ファイルを参照してください。
