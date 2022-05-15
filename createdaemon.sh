#!/bin/sh

daemonfile="${1}"
daemonname="${2}"
overwrite="y"

Main(){
writevars
writedaemonfile
sudo ./linknewdaemon.sh "${daemonfile}" "${daemonname}"
}

writevars(){
> "${daemonname}.src"  echo '#!/bin/sh'
>> "${daemonname}.src"  echo ''
>> "${daemonname}.src"  echo 'defvars(){'
>> "${daemonname}.src"  echo '#daemon="$(pwd)/'"${daemonfile}"'"'
>> "${daemonname}.src"  echo 'pidfile="$(pwd)/daemon.pid"'
>> "${daemonname}.src"  echo 'piddir="$(pwd)"'
>> "${daemonname}.src"  echo 'logfile="/var/log/'"${daemonname}"'.log"'
>> "${daemonname}.src"  echo 'errfile="/var/log/'"${daemonname}"'.err"'
>> "${daemonname}.src"  echo '#useuserfile="$(pwd)/user.txt"'
>> "${daemonname}.src"  echo '#user="$(cat $useuserfile)"'
>> "${daemonname}.src"  echo 'user="root:root"'
>> "${daemonname}.src"  echo 'dumask="022"'
>> "${daemonname}.src"  echo 'args="-p ${pidfile} -u ${user} -P -k ${dumask}"'
>> "${daemonname}.src"  echo 'argsstart="-m -b -2 ${errfile} -1 ${logfile} ${args}"'
>> "${daemonname}.src"  echo '}'
>> "${daemonname}.src"  echo 'Main(){'
>> "${daemonname}.src"  echo '  cd "/root/customdaemons/'"${daemonname}"'"'
>> "${daemonname}.src"  echo '  defvars'
>> "${daemonname}.src"  echo '}'
>> "${daemonname}.src"  echo 'Main'

}

writedaemonfile(){
> "${daemonname}.rc"  echo '#!/sbin/openrc-run'
>> "${daemonname}.rc" echo '# Copyright 1999-2021 Gentoo Foundation'
>> "${daemonname}.rc" echo '# Distributed under the terms of the GNU General Public License v2'
>> "${daemonname}.rc" echo ''
>> "${daemonname}.rc" echo 'source "/root/customdaemons/'"${daemonname}"'/'"${daemonname}"'.src"'
>> "${daemonname}.rc" echo 'user="${user}"'
>> "${daemonname}.rc" echo 'start_stop_daemon_args="${args}"'
>> "${daemonname}.rc" echo ''
>> "${daemonname}.rc" echo 'description="'"${daemonname}"'"'
>> "${daemonname}.rc" echo ''
>> "${daemonname}.rc" echo 'command="/usr/bin/'"${daemonname}"'"'
>> "${daemonname}.rc" echo 'command_args=""'
>> "${daemonname}.rc" echo ''
>> "${daemonname}.rc" echo 'start(){'
>> "${daemonname}.rc" echo '    ebegin "Starting '"${daemonname}"'"'
>> "${daemonname}.rc" echo '    start-stop-daemon -S $argsstart $command -- $command_args'
>> "${daemonname}.rc" echo '    eend $?'
>> "${daemonname}.rc" echo '}'
>> "${daemonname}.rc" echo ''
>> "${daemonname}.rc" echo 'stop(){'
>> "${daemonname}.rc" echo '    ebegin "Stopping '"${daemonname}"'"'
>> "${daemonname}.rc" echo '    start-stop-daemon -K $start_stop_daemon_args $command'
>> "${daemonname}.rc" echo '    eend $?'
>> "${daemonname}.rc" echo '}'
>> "${daemonname}.rc" echo ''
>> "${daemonname}.rc" echo 'depend() {'
>> "${daemonname}.rc" echo '    use dns logger netmount'
>> "${daemonname}.rc" echo '}'
>> "${daemonname}.rc" echo ''
>> "${daemonname}.rc" echo 'start_pre() {'
#>> "${daemonname}.rc" echo '  [ -f "${errfile}" ] || ( touch "${errfile}"; chown "$user" "${errfile}" )'
#>> "${daemonname}.rc" echo '  [ -f "${logfile}" ] || ( touch "${logfile}"; chown "$user" "${logfile}" )'
>> "${daemonname}.rc" echo '   if [ ! -e "${errfile}" ]; then'
>> "${daemonname}.rc" echo '     touch "${errfile}"'
>> "${daemonname}.rc" echo '     chown "$user" "${errfile}"'
>> "${daemonname}.rc" echo '     chmod 0666 "${errfile}"'
>> "${daemonname}.rc" echo '   fi'
>> "${daemonname}.rc" echo '   if [ ! -e "${logfile}" ]; then'
>> "${daemonname}.rc" echo '     touch "${logfile}"'
>> "${daemonname}.rc" echo '     chown "$user" "${logfile}"'
>> "${daemonname}.rc" echo '     chmod 0666 "${logfile}"'
>> "${daemonname}.rc" echo '   fi'
>> "${daemonname}.rc" echo '}'
>> "${daemonname}.rc" echo ''
>> "${daemonname}.rc" echo 'stop_post() {'
>> "${daemonname}.rc" echo '    rm -f "${pidfile}"'
>> "${daemonname}.rc" echo '}'
}
Main
