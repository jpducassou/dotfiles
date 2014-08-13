alias ..="cd .."
alias ...="cd ../.."
alias cd..="cd .."
alias l="ls -lhA --color=auto"
alias lg="ls -lAh --color=auto | g"
alias cls="clear"
alias vi="vim"
alias df="df -h"
alias ps="ps -ef"
alias dux="du -chx --max-depth=1"
alias rank="du -cmx --max-depth=1 | sort -nr | head -20"
alias home='cd ~'
alias g="grep --color=auto"
alias pt="perltidy -i=2 -et=2 -ce -wls=\"= + - / * > <\" -wrs=\"= + - / * > <\" "
alias valgrind="valgrind -v --leak-check=full --track-origins=yes --log-file=/tmp/valgrind.out"
alias pb=perlbrew
alias vg=vagrant
alias httpdump="curl --head --location"
if [ $(which memstat &> /dev/null) ]; then
	alias memcstat="watch 'memstat  --servers=127.0.0.1:11211'"
else
	alias memcstat="watch 'memcstat --servers=127.0.0.1:11211'"
fi
