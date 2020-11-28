## install etcd cluster
[install etcd cluster](./etcd/README.md)

## install m3dbnode
[install m3dbnode cluster](./m3db/README.md)


## Quick Start
config
```
## etcd
vim ./etcd/certs/config/hosts-etcd

./etcd/certs/reinit-root-ca.sh
./etcd/certs/update-etcd-client-certs.sh
./etcd/certs/update-etcd-server-certs.sh

## m3db
vim ./m3db/etc/m3dbnode.yml
```

deployment & install
```
. ./functions.sh

# set hosts
hosts="{node1} {node2} {node3}"

# sync etcd,m3db to hosts
sync

# install
install

# status
status
```
