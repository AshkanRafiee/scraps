#
# Binds gehoeren hier eigentlich nicht hin
#
# ctrl+left/right arrows:
#bind '"\e\x5b\x31\x3b\x35\x44"':backward-word
#bind '"\e\x5b\x31\x3b\x35\x43"':forward-word

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD##*/} /\007"'
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: bash\007"'

    # Show the currently running command in the terminal title:
    # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
    show_command_in_title_bar()
    {
        case "$BASH_COMMAND" in
            *\033]0*)
                # The command is trying to set the title bar as well;
                # this is most likely the execution of $PROMPT_COMMAND.
                # In any case nested escapes confuse the terminal, so don't
                # output them.
                ;;
            *)
                echo -ne "\033]0;${USER}@${HOSTNAME}: ${BASH_COMMAND%% *}\007"
                ;;
        esac
    }
    trap show_command_in_title_bar DEBUG
    ;;
*)
    ;;
esac

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

# Helper function to quiet chatty GUI programs
function quiet () {
  if [ $# -gt 0 ] ; then
    ($@ &) &>/dev/null
  else
    echo "missing argument"
  fi
}
# Bind `quiet` to [ALT][RETURN]
bind '"\e\C-j":"\e[1~quiet \e[4~\n"'

# serve current directory as web site
function serve {
  port="${1:-3000}"
  ruby -r webrick -e "s = WEBrick::HTTPServer.new(:Port => $port, :DocumentRoot => Dir.pwd); trap('INT') { s.shutdown }; s.start"
}

function calc () {
  echo "$*" | bc -l
}

function rnum () {
  echo $[ ( $RANDOM % $1 )  + 1 ]
}

function discred () {
  name=$(pwgen -0A $[6+$(rnum 4)] 1)$(rnum 100)

  echo 'Name:     '${name}
  echo 'Email:    '${name}'@mailinator.com'
  echo 'Webmail:  http://www.mailinator.com/maildir.jsp?email='${name}
  echo 'Password: '$(pwgen -c -n 12 1)
}

alias functions='compgen -A function'
alias rchar='< /dev/urandom tr -dc A-Z-a-z-0-9 | head -c'
alias e='editor'
alias g='git'
alias mkcd='_(){ mkdir $1; cd $1; }; _'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'