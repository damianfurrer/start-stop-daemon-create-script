#!/bin/sh

daemonfile="${1}"
daemonname="${2}"
overwrite="y"

Main(){
_link
}

_link(){
origdir=$(pwd)
chmod +x "${daemonname}.rc"
mkdir -p "/root/customdaemons/"
cd "/root/customdaemons/"
if [ -e "${daemonname}" ]; then
  if [ "$overwrite" = "y" ]; then
    >&2 echo "daemon allready exists in /root/customdaemons/ !"
    #exit 1
  fi
fi
rm -f "${daemonname}"
ln -s -f "$origdir" "${daemonname}"
cd "/usr/bin/"
rm -f "${daemonname}"
#echo "/root/customdaemons/${daemonname}/${daemonfile}"
ln -s "$origdir/${daemonfile}" "${daemonname}"
cd "/etc/init.d/"
rm -f "${daemonname}"
ln -s "/root/customdaemons/${daemonname}/${daemonname}.rc" "${daemonname}"
chown 0 "${daemonname}"
}

Main
