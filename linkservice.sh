#!/bin/sh
origdir=$(pwd)

cd "/root/"
rm -f "test2daemon"
ln -s "$origdir" "test2daemon"
cd "/usr/bin/"
rm -f "test2daemon"
ln -s "/root/test2daemon/test1.sh" "test2daemon"
cd "/etc/init.d/"
rm -f "test2daemon"
ln -s "/root/test2daemon/test3.rc" "test2daemon"

