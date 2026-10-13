#!/usr/bin/env zsh

[[ ! -d $(brew --prefix) ]] && echo "homebrew is required" && exit 1

function brew_install() {
  if [[ ! -d $(brew --prefix $1) ]]; then
    echo "Installing $1..."
    brew install $1
  fi
}

function brew_install_cask() {
  if ! brew list --cask $1 &>/dev/null; then
    echo "Installing $1..."
    brew install --cask $1
  fi
}

# symlink a file or directory to home. first argument is required and references the file or directory source, relative to
# the current dir. second argument is optional. if provided it will be the target for linking. if not provided, default
# target is `$HOME/.<first argument>`. When the first argument is a directory and the target already exists, the
# existing directory will be backed up. When the second argument contains a path, the full target
# directory will be created if it does not exist.
function link() {
  if [[ -z $1 ]]; then
    echo "link requires at least one argument"
    return 1
  fi


  local source=$PWD/$1
  local target

  if [[ -z $2 ]]; then
    target=$HOME/.$1
  else
    if [[ $(basename $2) != $2 ]]; then
      local target_dir=$(dirname $2)
      [[ ! -d $HOME/$target_dir ]] && mkdir -p $HOME/$target_dir
    fi
    target=$HOME/$2
  fi

  echo -n "Linking $1 to $target..."

  if [[ -d $source ]]; then
    [[ -d $target && ! ($target -ef $source) ]] && echo -n " $target exists to $target-bak..." && mv $target $target-bak
  fi

  ln -snfh $source $target
  echo " done."
}

if [[ ! -d $HOME/.zgenom ]]; then
  echo "Installing zgenom..."
  git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
fi

# install the things
prereqs=('starship' 'fzf' 'bat' 'gh' 'direnv' 'rg' 'fd' 'eza' 'fnm' 'coreutils')
for prereq in $prereqs; do
  brew_install $prereq
done

# nerd font for eza/starship icons (select it in iTerm: Profiles > Text > Font)
brew_install_cask font-jetbrains-mono-nerd-font

# link the things
link zshrc
link zsh
link starship.toml .config/starship.toml

# machine-local config is copied, not linked, so local edits stay out of git
if [[ ! -f $HOME/.zshrc.local ]]; then
  echo -n "Creating $HOME/.zshrc.local from zshrc.local.base..."
  cp $PWD/zshrc.local.base $HOME/.zshrc.local
  echo " done."
fi

echo ""
echo "... all set. Reload your terminal or open a new tab."
