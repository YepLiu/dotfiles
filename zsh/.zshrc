# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/.local/bin:$PATH"
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# Conda / Miniforge / Miniconda
if [ -x "$HOME/miniforge3/bin/conda" ]; then
    __conda_setup="$("$HOME/miniforge3/bin/conda" shell.zsh hook 2>/dev/null)"
elif [ -x "$HOME/miniconda3/bin/conda" ]; then
    __conda_setup="$("$HOME/miniconda3/bin/conda" shell.zsh hook 2>/dev/null)"
elif [ -x "/opt/homebrew/Caskroom/miniconda/base/bin/conda" ]; then
    __conda_setup="$(/opt/homebrew/Caskroom/miniconda/base/bin/conda shell.zsh hook 2>/dev/null)"
else
    __conda_setup=""
fi

if [ -n "$__conda_setup" ]; then
    eval "$__conda_setup"
fi

unset __conda_setup

# starship
# eval "$(starship init zsh)"

# Powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if command -v kitty >/dev/null 2>&1; then
    alias ssh="kitty +kitten ssh"
fi

export KMK_USER="u0156062"

