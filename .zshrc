# 環境変数
export LANG=ja_JP.UTF-8
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:/usr/local/share/python:$PATH"
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/sight-packages/
export PATH="~/.rbenv/bin:$PATH"

eval "$(rbenv init -)"

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000


autoload -U promptinit; promptinit
prompt  pure

# 補完
autoload -U compinit
compinit -u 

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# lsコマンド時、自動で色がつく
export CLICOLOR=true

#cdr
autoload -Uz add-zsh-hock
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 1000
zstyle ':chpwd:*' recent-dirs-default true
alias cdr=anyframe-widget-cdr


#path設定
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
source "${HOME}/.zgen/zgen.zsh"

#antigen
if [[ -f $HOME/.zsh/antigen/antigen.zsh ]]; then
  source $HOME/.zsh/antigen/antigen.zsh
  antigen bundle mollifier/anyframe # 追加
  antigen apply
fi

#zplugの設定
# Make sure to use double quotes
zplug "zsh-users/zsh-history-substring-search"

# Use the package as a command
# And accept glob patterns (e.g., brace, wildcard, ...)
zplug "Jxck/dotfiles", as:command, use:"bin/{histuniq,color}"

# Can manage everything e.g., other person's zshrc
zplug "tcnksm/docker-alias", use:zshrc

# Disable updates using the "frozen" tag
zplug "k4rthik/git-cal", as:command, frozen:1

# Grab binaries from GitHub Releases
# and rename with the "rename-to:" tag
zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*darwin*amd64*"

# Supports oh-my-zsh plugins and the like
zplug "plugins/git",   from:oh-my-zsh

# Load if "if" tag returns true
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

# Run a command after a plugin is installed/updated
# Provided, it requires to set the variable like the following:
# ZPLUG_SUDO_PASSWORD="********"
zplug "jhawthorn/fzy", \
    as:command, \
    rename-to:fzy, \
    hook-build:"
    {
        make
        sudo make install
    } &>/dev/null
    "

# Supports checking out a specific branch/tag/commit
zplug "b4b4r07/enhancd", at:v1
zplug "mollifier/anyframe", at:4c23cb60
antigen bundle mollifier/anyframe
zgen load mollifier/anyframe

# Can manage gist file just like other packages
zplug "b4b4r07/79ee61f7c140c63d2786", \
    from:gist, \
    as:command, \
    use:get_last_pane_path.sh

# Support bitbucket
zplug "b4b4r07/hello_bitbucket", \
    from:bitbucket, \
    as:command, \
    hook-build:"chmod 755 *.sh", \
    use:"*.sh"

# Group dependencies
# Load "emoji-cli" if "jq" is installed in this example
zplug "stedolan/jq", \
    from:gh-r, \
    as:command, \
    rename-to:jq
zplug "b4b4r07/emoji-cli", \
    on:"stedolan/jq"
# Note: To specify the order in which packages should be loaded, use the nice
#       tag described in the next section

# Set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:2 

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"

# Can manage local plugins
zplug "~/.zsh", from:local

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load 
export PATH="/usr/local/opt/libxslt/bin:$PATH"
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export PATH="/usr/local/opt/libiconv/bin:$PATH"

eval "$(direnv hook zsh)"

