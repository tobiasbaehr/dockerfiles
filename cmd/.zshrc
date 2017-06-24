export LANG=de_DE.UTF-8
export NVM_DIR="$HOME/.nvm"
export PATH="$PATH:$HOME/.composer/vendor/bin:$HOME/.rbenv/bin"
export ZSH_CACHE_DIR="$HOME/.antigen/bundles/robbyrussell/oh-my-zsh/cache/"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
source ~/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo declared above.
antigen bundles <<EOBUNDLES
git
git-extras
command-not-found
sudo
npm
node
gulp
nvm
# Additional completion definitions for Zsh.
zsh-users/zsh-completions src
webflo/drush_zsh_completion
# Syntax highlighting bundle.
zsh-users/zsh-syntax-highlighting

# ZSH port of Fish shell's history search feature.
zsh-users/zsh-history-substring-search

EOBUNDLES

# Load the theme.
antigen theme gentoo

# Tell antigen that you're done.
antigen apply

alias ll="ls -lah --color=auto"
[ -f "$HOME/.rbenv/bin/rbenv" ] && eval "$(rbenv init -)"
