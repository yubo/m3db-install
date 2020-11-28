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
}'
