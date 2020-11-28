# add a node to 
# TODO:
# curl -X POST http://localhost:17201/api/v1/database/create -d '{
  "type": "cluster",
  "namespaceName": "backup",
  "retentionTime": "2400h",
  "numShards": "1",
  "replicationFactor": "1",
  "hosts": [
        {
            "id": "m3db-dev01-yubo.py",
            "isolationGroup": "local",
            "zone": "embedded",
            "weight": 100,
            "address": "10.178.24.87",
            "port": 9000
        }
    ]
}'
