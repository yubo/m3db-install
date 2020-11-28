#!/bin/bash
curl -sS -X POST http://localhost:9003/query -d '{
  "namespace": "test1113_ns",
  "query": {
    "regexp": {
      "field": "city",
      "regexp": "city-0"
    }
  },
  "rangeStart": '"$(date -d "10 second ago" "+%s")"',
  "rangeEnd": '"$(date "+%s")"'
}'

