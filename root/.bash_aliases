#!/bin/bash

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
alias psx="ps -ef"
alias dux="du -chx --max-depth=1"
alias rank="du -cmx --max-depth=1 | sort -nr | head -20"
alias home='cd ~'
alias g="grep --color=auto"
alias pt="perltidy -i=2 -et=2 -ce -wls=\"= + - / * > <\" -wrs=\"= + - / * > <\" "
alias valgrind="valgrind -v --leak-check=full --track-origins=yes --log-file=/tmp/valgrind.out"
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
alias mysql="mysql --pager=uberpager"
alias mirror="wget --mirror --no-parent --page-requisites --adjust-extension --convert-links"
alias mvndoc="mvn dependency:resolve -Dclassifier=javadoc"
alias perltags="ctags --exclude=blib --extra=q --languages=Perl --langmap=Perl:+.t"

# subversion
alias 7up="svn update --ignore-externals"
alias 7log="svn log --diff --diff-cmd=svn-diff -l5"
alias 7lg="svn log -l100 | svn-short_log | less"
# alias 7diff="svn diff | colordiff | less -R"
7diff () {
	svn diff "${@}" | colordiff | less -R
}

# Candidates:
# alias cx="cpanm --installdeps --skip-satisfied ."
# alias cx="cpanm --installdeps --skip-satisfied --with-develop ."
