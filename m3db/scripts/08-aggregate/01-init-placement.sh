# Initializing aggregator topology
curl -vvvsSf -H "Cluster-Environment-Name: default_env" -X POST http://localhost:7201/api/v1/services/m3aggregator/placement/init -d '{
    "num_shards": 16,
    "replication_factor": 2,
    "instances": [
        {
            "id": "m3db-dev01-yubo.py",
            "isolation_group": "g1",
            "zone": "embedded",
            "weight": 100,
            "endpoint": "m3db-dev01-yubo.py:6000",
            "hostname": "m3db-dev01-yubo.py",
            "port": 6000
        },
        {
            "id": "m3db-dev02-yubo.py",
            "isolation_group": "g2",
            "zone": "embedded",
            "weight": 100,
            "endpoint": "m3db-dev02-yubo.py:6000",
            "hostname": "m3db-dev02-yubo.py",
            "port": 6000
        }
    ]
}'
