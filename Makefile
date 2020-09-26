#  パッケージアップグレード。ほぼ全てのターゲットに対する前処理。
apt:
	@cd installers && ./apt_upgrade

python3: apt ## Python3および関連ライブラリをインストールする。
	@cd installers && ./python3_installer

neovim: apt ## neovimおよびvim設定ファイルをインストールする。
	@cd installers && ./neovim_installer

terminal: apt neovim tmux ## CLIツールをインストールする。
	@cd installers && ./terminal_tool_installer

kernel: apt terminal ## Linux Kernel開発ツールをインストールする。
	@cd installers && ./kernel_tool_installer

fish: apt  ## fish shellおよびfisherプラグインマネージャをインストールする。
	@cd installers && ./fish_installer

tmux: apt ## tmuxおよびtmux設定ファイルをインストールする。
	@cd installers && ./tmux_installer

sdkman: apt ## SDKMAN（Java等のJVM環境設定ツール）をインストールする。
	@cd installers && ./sdkman_installer

.DEFAULT_GOAL := help
.PHONY: help apt python3 neovim kernel terminal fish tmux sdkman

help:  ## 本Makefileの使い方を表示する。
	@echo "本Makefileは、Debian(Linux)の開発環境をセットアップします。"
	@echo "セットアップしたいツールに応じて、以下のターゲットを選択してください。"
	@echo "[e.g.] $ sudo make neovim"
	@echo ""
	@grep -E '^[0-9a-zA-Z_-]+[[:blank:]]*:.*?## .*$$' $(MAKEFILE_LIST) | sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[1;32m%-15s\033[0m %s\n", $$1, $$2}'
