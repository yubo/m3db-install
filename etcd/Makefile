.PHONY: clean log status test uninstall install

# https://www.yuque.com/ecmc/manual/nzgpzr
# https://etcd.io/docs/v3.4.0/op-guide/configuration/

clean:
	rm -f ./certs/root/* && \
	rm -f ./certs/output/* && \
	rm -f etcd/hosts-etcd && \
	rm -f etcd/usr_lib_systemd_system/etcd.service

install:
	sudo ./etcd/install

uninstall:
	sudo systemctl stop etcd && \
	sudo systemctl disable etcd

test:
	etcdctl --endpoints=https://127.0.0.1:2379 \
	--ca-file=/etc/etcd/certs/ca.pem \
	--cert-file=/etc/etcd/certs/etcd-client.pem \
	--key-file=/etc/etcd/certs/etcd-client-key.pem \
	member list && \
	etcdctl --endpoints=https://127.0.0.1:2379 \
	--ca-file=/etc/etcd/certs/ca.pem \
	--cert-file=/etc/etcd/certs/etcd-client.pem \
	--key-file=/etc/etcd/certs/etcd-client-key.pem \
	cluster-health

status:
	sudo systemctl status etcd

log:
	sudo journalctl -u etcd -f
