alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias l='ls -lhA'
alias ll='ls -lhA --color | less -R'
alias lg='ls -lAh | g'
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
alias pd="perldoc -MPod::Text::Color::Delight"
alias httpdump="curl --head --location"
if [ $(which memstat &> /dev/null) ]; then
	alias memcstat="watch 'memstat  --servers=127.0.0.1:11211'"
else
	alias memcstat="watch 'memcstat --servers=127.0.0.1:11211'"
fi
alias c='pygmentize -O style=monokai -f console256 -g'
alias agl="ag --pager 'less -R'"
alias pp_json="python -mjson.tool"
