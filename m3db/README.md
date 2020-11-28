## config
```
cat >> /etc/sysctl.conf <'EOF'
vm.max_map_count = 3000000
vm.swappiness = 1
fs.file-max = 3000000
fs.nr_open = 3000000
EOF
```

## install
```
sudo ./scripts/install.sh
```


## postcheck
```
sudo systemctl status m3dbnode
```


## init database
```
curl -X POST http://localhost:7201/api/v1/database/create -d '{
  "type": "cluster",
  "namespaceName": "default",
  "retentionTime": "2160h",
  "numShards": "64",
  "replicationFactor": "3",
  "hosts": [
        {
            "id": "10-255-0-146",
            "isolationGroup": "group1",
            "zone": "embedded",
            "weight": 100,
            "address": "10.255.0.146",
            "port": 9000
        },
        {
            "id": "10-255-0-129",
            "isolationGroup": "group2",
            "zone": "embedded",
            "weight": 100,
            "address": "10.255.0.129",
            "port": 9000
        },
        {
            "id": "10-255-0-137",
            "isolationGroup": "group3",
            "zone": "embedded",
            "weight": 100,
            "address": "10.255.0.137",
            "port": 9000
        }
    ]
}

```

## add dbnode
```
curl -X POST http://localhost:7201/api/v1/services/m3db/placement -d '{
  "instances": [
    {
      "id": "10-255-0-17",
      "isolationGroup": "group4",
      "zone": "embedded",
      "weight": 100,
      "endpoint": "10.255.0.17 ",
      "hostname": "10-255-0-17",
      "port": 9000
    }
  ]
}'
```
