function extract () {
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2|*.tbz2)  tar xjf "$1"    ;;
      *.tar.gz|*.tgz)    tar xzf "$1"    ;;
      *.bz2)             bunzip2 "$1"    ;;
      *.rar)             rar x "$1"      ;;
      *.gz)              gunzip "$1"     ;;
      *.tar)             tar xf "$1"     ;;
      *.7z)              7zr x "$1"      ;;
      *.zip|*.xpi|*.jar) unzip "$1"      ;;
      *.Z)               uncompress "$1" ;;
      *)                 echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# serve current directory as web site
function serve {
  port="${1:-3000}"
  ruby -r webrick -e "s = WEBrick::HTTPServer.new(:Port => $port, :DocumentRoot => Dir.pwd); trap('INT') { s.shutdown }; s.start"
}

function calc () {
  echo "$*" | bc -l
}

function mkcd {
  if [ ! -n "$1" ]; then
    echo "mkcd: missing operand"
  elif [ -d $1 ]; then
    echo "mkcd: cannot create directory '$1': File exists"
  else
    mkdir $1 && cd $1
  fi
}

alias functions='compgen -A function'
alias rchar='< /dev/urandom tr -dc A-Z-a-z-0-9 | head -c'
alias e='subl'
alias g='git'
alias pu='pushd'
alias po='popd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias xi='xclip -i'
alias xo='xclip -o'

# enable bash completion for aliases
complete -o default -o nospace -F _git g

