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

#
# USE RUBY GEM FORGERY FOR THIS IN THE FUTURE !
#
#function rnum () {
#  echo $[ ( $RANDOM % $1 )  + 1 ]
#}
#
#function discred () {
#  name=$(pwgen -0A $[6+$(rnum 4)] 1)$(rnum 100)
#
#  echo 'Name:     '${name}
#  echo 'Email:    '${name}'@mailinator.com'
#  echo 'Webmail:  http://www.mailinator.com/maildir.jsp?email='${name}
#  echo 'Password: '$(pwgen -c -n $[8+$(rnum 8)] 1)
#}

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

