## install

#### certs
```
cd certs
vi  config/hosts-etcd
# 这里的ip地址用内网地址(本地网卡上的ip)，用来 etcd-server 之间互联
...

./certs/update-etcd-client-certs.sh
./certs/update-etcd-server-certs.sh
```

#### deploy
拷贝目录到所有节点，分别执行
```
make install
```

#### postcheck
在任一节点执行
```
make test
```
