[Unit]
Description=Etcd Server
After=network.target
After=network-online.target
Wants=network-online.target
Documentation=https://github.com/coreos

[Service]
Type=notify
WorkingDirectory=/home/etcd/
ExecStart=/usr/bin/etcd \
  --data-dir=/home/etcd \
  --name=var_node \
  --cert-file=/etc/etcd/certs/etcd-server.pem \
  --key-file=/etc/etcd/certs/etcd-server-key.pem \
  --trusted-ca-file=/etc/etcd/certs/ca.pem \
  --peer-cert-file=/etc/etcd/certs/etcd-peer.pem \
  --peer-key-file=/etc/etcd/certs/etcd-peer-key.pem \
  --peer-trusted-ca-file=/etc/etcd/certs/ca.pem \
  --peer-client-cert-auth \
  --client-cert-auth \
  --listen-peer-urls=https://0.0.0.0:2380 \
  --initial-advertise-peer-urls=https://0.0.0.0:2380 \
  --listen-client-urls=https://0.0.0.0:2379,https://127.0.0.1:2379 \
  --advertise-client-urls=https://0.0.0.0:2379 \
  --initial-cluster-token=etcd-cluster \
  --initial-cluster=var_endpoints \
  --initial-cluster-state=new
Restart=on-failure
RestartSec=5
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
