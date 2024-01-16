DISABLE_AUTO_TITLE="true"

# setup brew
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/nikhilkumar/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# setup pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# bun
[ -s "/Users/nikhilkumar/.bun/_bun" ] && source "/Users/nikhilkumar/.bun/_bun"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH=/Users/nikhilkumar/.local/bin:$PATH

# VIM
export VISUAL=neovide
export EDITOR="$VISUAL"

# pnpm
export PNPM_HOME="/Users/nikhilkumar/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

alias vim="nvim"
alias c="clear"
alias ls="ls -AGltr"
alias ll="ls -a --color=auto"
alias grep='grep --colour=auto' # color
alias egrep='egrep --colour=auto' # color
alias fgrep='fgrep --colour=auto' # color
alias .="cd .."
alias ..="cd ../../"
alias ...="cd ../../../"
alias ols="ls -la --color | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'"
alias cdb="cd $OLDPWD"
alias ptest="python -m pytest --cov-report html"
alias brewup="brew update && brew upgrade && brew cleanup"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push origin"
alias gpl="git pull origin"
alias gcl="git clone"
alias pn="pnpm"
alias flex="neofetch"
alias noflex="neofetch --off"
alias chatbot="python /Users/nikhilkumar/Documents/chatbot/openAI.py"
alias chrome="open -a 'Google Chrome'"
alias z="neovide ~/.zshrc"
alias rst="source ~/.zshrc && clear"
alias rss="cd /Users/nikhilkumar/Documents/rss_app && npm run preview"
alias lg="lazygit"
function medir () {
  mkdir $1
  cd $1
  echo "created and entered directory $1"
}
function cgit () {
  git init;
  git remote add origin $1;
  touch README.md;
  git add .;
  git commit -m "initial commit";
  git push -u origin main
}


function gacp () {
  git add .;
  git commit -m $1;
  git push origin -u
}


function update () {
  brew update
  brew upgrade
  brew cleanup
  bun upgrade
  pn add -g pnpm
  pip install --upgrade pip
  pip-review --local --auto
  pip cache purge
}

function v() {
    if [ -n "$1" ]; then
        if [ -f "$1" ]; then
            # If $1 is a file, open the file
            neovide "$1"
        elif [ -d "$1" ]; then
            # If $1 is a directory, cd into it
            cd "$1" || return 1
            # Check if .venv exists and activate if it does
            if [ -f .venv/bin/activate ]; then
                source .venv/bin/activate
            fi
            # Open nvim
          neovide
        else
            echo "Invalid argument: $1 is neither a file nor a directory."
            return 1
        fi
    else
        # No argument passed, check if .venv exists and activate if it does
        if [ -f .venv/bin/activate ]; then
            source .venv/bin/activate
        fi
        # Open nvim
       neovide
    fi
}

function kp () {
  kill -9 $(lsof -t -i:$1)
}
source /Users/nikhilkumar/Documents/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform


export GOPATH=/Users/nikhilkumar/go
export PATH=$PATH:$GOPATH/bin
export PYLINTRC=/Users/nikhilkumar/.config/.pylintrc
export NEOVIDE_SRGB=true
