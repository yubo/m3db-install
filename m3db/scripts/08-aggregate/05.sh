# Initializing m3coordinator topology
curl -vvvsSf \
	-H "Cluster-Environment-Name: default_env" \
	-X POST http://localhost:7201/api/v1/services/m3coordinator/placement/init \
	-d '{
    "instances": [
        {
            "id": "m3db-dev01-yubo.py",
            "zone": "embedded",
            "endpoint": "m3db-dev01-yubo.py:7507",
            "hostname": "m3db-dev01-yubo.py",
            "port": 7507
        }
    ]
}'
