#!/bin/bash

while true; do
curl -sS -X POST http://localhost:9003/writetagged -d '{
  "namespace": "test1113_ns",
  "id": "test-id-0",
  "tags": [
    {
      "name": "city",
      "value": "city-0"
    }
  ],
  "datapoint": {
    "timestamp": '"$(date "+%s")"',
    "value": 42.123456789
  }
}
'
sleep 1
date
done

