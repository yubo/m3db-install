curl -X POST http://localhost:7201/api/v1/database/namespace/create -d '{
  "namespaceName": "test10y",
  "retentionTime": "87600h"
}'

exit


curl -X POST <M3_COORDINATOR_IP_ADDRESS>:<CONFIGURED_PORT(default 7201)>/api/v1/namespace -d '{
  "name": "default_unaggregated",
  "options": {
    "bootstrapEnabled": true,
    "flushEnabled": true,
    "writesToCommitLog": true,
    "cleanupEnabled": true,
    "snapshotEnabled": true,
    "repairEnabled": false,
    "retentionOptions": {
      "retentionPeriod": "2d",
      "blockSize": "2h",
      "bufferFuture": "10m",
      "bufferPast": "10m",
      "blockDataExpiry": true,
      "blockDataExpiryAfterNotAccessedPeriod": "5m"
    },
    "indexOptions": {
      "enabled": true,
      "blockSize": "2h"
    }
  }
}'
