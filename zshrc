# vim: fdm=marker sw=2 ts=2 sts=2 tw=80 nofoldenable

# 1. Environment & Homebrew
export EDITOR='vim'
export VEDITOR='code'
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export HOMEBREW_PREFIX="/opt/homebrew"

# 2. Load Zgenom
source "$HOME/.zgenom/zgenom.zsh"

# 3. Zgenom Plugin Block
if ! zgenom saved; then
  zgenom ohmyzsh
  zgenom ohmyzsh plugins/git
  zgenom ohmyzsh plugins/ssh-agent
  zgenom ohmyzsh plugins/sudo
  zgenom ohmyzsh --completion plugins/docker-compose
  [[ "$(uname -s)" = Darwin ]] && zgenom ohmyzsh plugins/macos

  zgenom load djui/alias-tips
  zgenom load hlissner/zsh-autopair
  zgenom load rupa/z
  zgenom load urbainvaes/fzf-marks
  zgenom load zsh-users/zsh-completions
  zgenom load zsh-users/zsh-history-substring-search

  # The "Big Two" must be at the end of the load list
  zgenom load zsh-users/zsh-autosuggestions
  zgenom load zsh-users/zsh-syntax-highlighting

  zgenom compdef
  zgenom save
fi

# 4. Lazy Load Node Manager (fnm)
_load_node_tools() {
  unalias node npm npx 2>/dev/null
  eval "$(fnm env --use-on-cd)"
  unset -f _load_node_tools
}
alias node='_load_node_tools && node'
alias npm='_load_node_tools && npm'
alias npx='_load_node_tools && npx'

# 5. Visuals & Tools
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"

# Initialize fzf Key Bindings
if [ -d "/opt/homebrew/opt/fzf" ]; then
  source "/opt/homebrew/opt/fzf/shell/completion.zsh"
  source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
fi

# 6. Paths, just-zsh modules, then machine-local config (loaded last so it wins)
path=(~/.zgenom/bin ~/.local/bin $path)

# ~/.zsh is symlinked to this repo's zsh/ dir by install.sh
if [ -f "$HOME/.zsh/local.plugin.zsh" ]; then
  source "$HOME/.zsh/local.plugin.zsh"
fi

if [ -e "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi

# 7. Syntax Highlighting Styles (set after all plugins & aliases are loaded)
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
