#!/bin/bash

# ROOT CA
echo "do u know what r u doing?"
# if u know what u r doing now, uncomment the line below and re-run the script
./bin/cfssl gencert -initca config/config-ca.json | ./bin/cfssljson -bare root/ca
