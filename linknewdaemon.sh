#!/bin/sh

daemonizedscript="${1}"
daemonname="${2}"
overwrite="n"

Main(){
_link
}

_link(){
origdir=$(pwd)
chmod +x "${daemonname}.rc"
mkdir -p "/root/customdaemons/"
cd "/root/customdaemons/"
_existscheck
ln -s -f "$origdir" "${daemonname}"

cd "/usr/bin/"
_existscheck
ln -s "$origdir/${daemonizedscript}" "${daemonname}"
cd "/etc/init.d/"
_existscheck
ln -s "/root/customdaemons/${daemonname}/${daemonname}.rc" "${daemonname}"
chown 0 "${daemonname}"
}

_existscheck(){
if [ -e "${daemonname}" ]; then
  >&2 echo "daemon allready exists in $PWD !"
  if [ "$overwrite" = "y" ]; then
    rm -f "${daemonname}"
  else
    echo "overwrite disbled, exiting"
    exit 1
  fi
fi
}

Main
