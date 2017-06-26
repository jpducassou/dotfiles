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
alias perltags="ctags --exclude=blib --extra=q --languages=Perl"
alias ff="firefox -private-window 2>/dev/null &"
alias u='aptitude update && aptitude autoclean && aptitude'

xmldiff() {
	vimdiff <(xmllint --format "${1}") <(xmllint --format "${2}")
}

# ============================================================================
# subversion
# ============================================================================
alias 7st='svn status --ignore-externals | grep -v '\''^X'\'' | sed -e '\''s/^\?.*$/[1;34m\0[m/'\'' -e '\''s/^!.*$/[1;31m\0[m/'\'' -e '\''s/^A.*$/[1;32m\0[m/'\'' -e '\''s/^M.*$/[1;33m\0[m/'\'' -e '\''s/^D.*$/[0;31m\0[m/'\'
alias 7up='svn update --ignore-externals'
alias 7log='svn log --diff -r HEAD:{$(date --iso-8601 --date "3 days ago")} | colordiff | less -R'
alias 7lg='svn log -q -v   -r HEAD:{$(date --iso-8601 --date "3 days ago")}'
alias 7show='svn diff -c'
alias 7base='svn log -r0:HEAD --stop-on-copy --limit 1 | grep -Po "^r\d+"'
alias 7branch='svn diff -$(svn log -r0:HEAD --stop-on-copy --limit 1 | grep -Po "^r\d+"):HEAD'
alias 7cr='svn diff -$(svn log -r0:HEAD --stop-on-copy --limit 1 | grep -Po "^r\d+"):HEAD --diff-cmd=diff -x -U100000'
alias 7ci="svn status | grep '^[MAD]' | awk '{print \$2}' | svn ci --targets -"
alias 7re="svn status | grep '^[MD]'  | awk '{print \$2}' | xargs svn revert"
# alias 7diff="svn diff | colordiff | less -R"
7diff () {
	svn diff "${@}" | colordiff | less -R
}

# ============================================================================
# Docker
# ============================================================================
docker-remove-untagged () {
	docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs -r docker rmi
}

docker-remove-dead () {
	docker ps --filter status=dead --filter status=exited -aq | xargs docker rm -v
}

alias docker-clean="docker-remove-untagged; docker-remove-dead"
alias docker-sen="docker run -v /var/run/docker.sock:/run/docker.sock -ti -e TERM tomastomecek/sen"

# stop all containers:
alias docker-killall='docker kill $(docker ps -q)'

# remove all containers
alias docker-purge='docker rm $(docker ps -a -q)'

# remove all docker images
alias docker-purge-images='docker rmi $(docker images -q)'

# ============================================================================
# Candidates:
# ============================================================================
# alias cx="cpanm --installdeps --skip-satisfied ."
# alias cx="cpanm --installdeps --skip-satisfied --with-develop ."
