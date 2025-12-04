#!/bin/bash
set -e


# This script goes through installing a (very) based setup with ghostty, tmux and neovim (btw), all on MacOS
# Let's start by installing our package manager, brew
echo "[SETUP] Installing brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install and configure our terminal, ghostty
echo "[SETUP] Installing ghostty..."
brew install --cask ghostty

mkdir ~/.config/ghostty/ && cd ~/.config/ghostty/
echo " \
theme = Arthur
background-blur-radius = 20
mouse-hide-while-typing = true
window-decoration = false
macos-option-as-alt = true
background-opacity = 0.7
background-blur-radius = 20" > config

# Enable vi mode on terminal
echo "Enable vi mode on the terminal" >> ~/.zshrc
echo "set -o vi" >> ~/.zshrc
echo ""

# Install useful tools
# git
brew install git

echo "# git config" >> ~/.zshrc
echo '
alias git-work='\''git config user.email "<email>" && git config user.name "<username>"'\''
alias git-personal='\''git config user.email "<email>" && git config user.name "<username>"'\''
alias which-git='\''git config user.email && git config user.name'\''' >> ~/.zshrc

# zsh
brew install zsh
chsh -s $(which zsh)

# tmux
brew install tmux
# mkdir ~/.config/tmux/
# touch ~/.config/tmux/tmux.conf
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# fzf
brew install fzf
echo "# Configure fzf" >> ~/.zshrc
echo "source <(fzf --zsh)" >> ~/.zshrc
echo "" >> ~/.zshrc
echo "# fzf search based on different directories" >> ~/.zshrc
echo '
cdf() {
  local base=~/"${1:-.}"  # use current dir if no argument
  local dir
  dir=$(fd -t d . "$base" | fzf) && cd "$dir"
}' >> ~/.zshrc
echo "" >> ~/.zshrc

echo 'dff() {
  local dir 
  dir=$(fd -t d . ~/Developer | fzf) && cd "$dir"
}' >> ~/.zshrc
echo "" >> ~/.zshrc

echo '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh' >> ~/.zshrc
echo "" >> ~/.zshrc

# Install and configure neovim (Substitute with your repo)
brew install neovim

git clone https://github.com/Arthur-Fetter/nvim-config.git
mkdir ~/.config/nvim/
cp nvim-config/* ~/.config/nvim/
rm -rf ./nvim-config/

# Install starship
echo '# Starship configuration' >> ~/.zshrc
echo 'export STARSHIP_CONFIG=~/.config/starship/starship.toml' >> ~/.zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
mkdir ~/.config/starship/
touch ~/.config/starship/starship.toml

# Aliases
echo '
alias k='\''kubectl'\''
alias ka='\''kubectl get pods -A'\''' >> ~/.zshrc
