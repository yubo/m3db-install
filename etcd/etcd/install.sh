#!/bin/bash -x

CWD=$(cd $(dirname $0)/; pwd)
cd $CWD

systemctl stop etcd.service

mkdir -p /home/etcd
mkdir -p /etc/etcd/certs

cp -a ./usr_bin/* /usr/bin/
cp -af ../certs/output/etcd-*.pem /etc/etcd/certs/
cp -af ../certs/root/ca*.pem /etc/etcd/certs/

cp ../certs/config/hosts-etcd hosts-etcd

sed -i '/127.0.0.1/d' hosts-etcd
sed -i '/^$/d' hosts-etcd

# gen systemd/etcd.service
num=1
arr=()
for line in `cat hosts-etcd`; do
	arr[${#arr[*]}]="node${num}=https://${line}:2380"
	let num++
done
endpoints=`echo "${arr[@]}" | tr ' ' ','`
sed "s#var_endpoints#${endpoints}#g" usr_lib_systemd_system/etcd.service.tpl > usr_lib_systemd_system/etcd.service

cp -f usr_lib_systemd_system/etcd.service /usr/lib/systemd/system/

ip=$(/usr/sbin/ifconfig `/usr/sbin/route|grep '^default'|awk '{print $NF}'`|grep inet|awk '{print $2}'|head -n 1)
sed -i "s/0.0.0.0/${ip}/g" /usr/lib/systemd/system/etcd.service

num=1
for line in `cat hosts-etcd`; do
	if [ "$ip" = "$line" ]; then
		sed -i "s/var_node/node${num}/g" /usr/lib/systemd/system/etcd.service
		return
	fi
	let num++
done

systemctl daemon-reload
systemctl enable etcd.service
systemctl start etcd.service

cat /usr/lib/systemd/system/etcd.service
