hosts="12.86.92.17"
user=$(whoami)

sync()
{
	for host in ${hosts}; do
		scp -r ./etcd ${user}@${host}:~/
		scp -r ./m3db ${user}@${host}:~/
	done
}

install()
{
	for host in ${hosts}; do
		ssh ${user}@${host} "sudo ./m3db/scripts/install.sh"
		ssh ${user}@${host} "sudo ./etcd/etcd/install.sh"
	done
}

status()
{
	for host in ${hosts}; do
		ssh ${user}@${host} "sudo systemctl status etcd"
		ssh ${user}@${host} "sudo systemctl status m3dbnode"
	done
}

#sync
#install
