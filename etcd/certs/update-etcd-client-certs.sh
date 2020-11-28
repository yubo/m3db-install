#! /bin/bash
OLDPATH=`pwd`
ROOT=`cd $(dirname $0); pwd`
cd ${ROOT}
function finish {
    cd ${OLDPATH} 
}
trap finish EXIT
OUTPUT=${ROOT}/output

mkdir -p ${OUTPUT}

# etcd
# etcd client cert/key
bin/cfssl gencert -ca=root/ca.pem -ca-key=root/ca-key.pem \
    -config=config/config-profiles.json \
    -profile=client config/config-etcd-client.json | \
    bin/cfssljson -bare ${OUTPUT}/etcd-client
chmod 0644 ${OUTPUT}/*

type openssl >/dev/null 2>&1 && {
    cat ${OUTPUT}/etcd-client.pem | openssl x509 -noout -text
}
