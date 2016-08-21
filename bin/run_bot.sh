#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )"
cd $DIR/
if [ "$(whoami)" == "tools.cluebotng" ];
then
    mysql --defaults-file="${HOME}"/replica.my.cnf -h tools.labsdb -A s52585__cb -e 'replace into `cluster_node` values ("'$(hostname -f | sed 's/[^A-Za-z0-9\._\-]+//g')'", "core")'
else
    if [ "$(whoami)" == "tools.cluebot" ];
    then
        mysql --defaults-file="${HOME}"/replica.my.cnf -h tools-db -A s51109__cb -e 'replace into `cluster_node` values ("'$(hostname -f | sed 's/[^A-Za-z0-9\._\-]+//g')'", "core")'
    else
        mysql --defaults-file="${HOME}"/replica.my.cnf -h tools.labsdb -A s53115__cb -e 'replace into `cluster_node` values ("'$(hostname -f | sed 's/[^A-Za-z0-9\._\-]+//g')'", "core")'
    fi
fi
exec /usr/bin/php -f $DIR/bot/cluebot-ng.php
