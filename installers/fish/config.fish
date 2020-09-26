set fish_greeting
set -x JAVA_HOME $HOME/.sdkman/candidates/java/current/
set -x GRADLE_HOME /opt/gradle/gradle-6.5.1
set -x PATH $PATH /home/nao/eclipse/java-2020-03/eclipse
set -x PATH $PATH /mnt/fecb3b9a-af4a-4a09-abdd-3fa633beaaa6/bin
set -x PATH $PATH $GRADLE_HOME/bin
set -x PATH $PATH $JAVA_HOME/bin
set -x GOPATH $HOME/.go

# FZFの古いキーバインドを使わない
# (昔、fishのキーバインドとコンフリクトしたため)
set -U FZF_LEGACY_KEYBINDINGS 0

# Alias
abbr -a -g vi "nvim"
abbr -a -g tmuxg "tmux new-session \; source-file ~/.tmux.session.conf"
abbr -a -g ls "lsd"
abbr -a -g cat "bat"
abbr -a -g android "/opt/android-studio/bin/studio.sh"
