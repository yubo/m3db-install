#!/bin/bash
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
