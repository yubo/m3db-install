#!/bin/bash

OLDPATH=`pwd`
ROOT=`cd $(dirname $0)/..; pwd`
cd ${ROOT}
function finish {
    cd ${OLDPATH} 
}
trap finish EXIT

systemctl stop m3dbnode

mkdir -p /home/{m3db,m3kv}
mkdir -p /etc/m3db

cp -af ./usr_bin/* /usr/bin/
cp -af ./etc/*.yml /etc/m3db/

sysctl -w vm.max_map_count=3000000
sysctl -w vm.swappiness=1
sysctl -w fs.file-max=3000000
sysctl -w fs.nr_open=3000000
# echo "${USER} hard nofile 3000000" >> /etc/security/limits.conf
# Edit /etc/security/limits.conf file and allow the user under which asterisk runs to modify the ulimit to a higher value.
# <username> hard nofile <number>
ulimit -n 3000000

cat >> /etc/sysctl.conf <<'EOF'
# m3db
vm.max_map_count = 3000000
vm.swappiness = 1
fs.file-max = 3000000
fs.nr_open = 3000000
EOF

sudo cp -a ./systemd/m3dbnode.service /usr/lib/systemd/system/m3dbnode.service
systemctl daemon-reload
systemctl start m3dbnode
systemctl status m3dbnode
