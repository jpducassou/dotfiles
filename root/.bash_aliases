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
alias t="tree -Cf | less -R"
alias httpdump="curl --head --location"
if [ $(which memstat &> /dev/null) ]; then
	alias memcstat="watch 'memstat  --servers=127.0.0.1:11211'"
else
	alias memcstat="watch 'memcstat --servers=127.0.0.1:11211'"
fi
alias agl="ag --pager 'less -R'"
alias pp_json="python -mjson.tool"
alias mysql="mysql --pager=uberpager"
alias mirror="wget --mirror --no-parent --page-requisites --adjust-extension --convert-links"
alias mvndoc="mvn dependency:resolve -Dclassifier=javadoc"
alias perltags="ctags --exclude=blib --extra=q --languages=Perl"
alias ff="firefox -private-window 2>/dev/null &"
alias u='aptitude update && aptitude autoclean && aptitude'

xmldiff() {
	vimdiff <(xmllint --format "${1}") <(xmllint --format "${2}")
}

f() {

	local name="${1}"
	local starting_point="${2:-.}"

	local files=$(find "${starting_point}" -type f -iname "${name}*" | head -n 15)

	if [ "${files}" == "" ]; then
		return
	fi

	echo "${files}"

	if [ $(echo "${files}" | wc -l)  == "1" ] ; then
		vim "${files}"
	fi

}

# ============================================================================
# Candidates:
# ============================================================================
# alias cx="cpanm --installdeps --skip-satisfied ."
# alias cx="cpanm --installdeps --skip-satisfied --with-develop ."
# alias c='pygmentize -O style=monokai -f console256 -g'
