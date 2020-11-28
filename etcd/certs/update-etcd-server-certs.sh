#! /bin/bash -x
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
# etcd server cert/key
bin/hosts config/config-etcd-server.json config/hosts-etcd | \
bin/cfssl gencert -ca=root/ca.pem -ca-key=root/ca-key.pem \
    -config=config/config-profiles.json \
    -profile=server - | \
    bin/cfssljson -bare ${OUTPUT}/etcd-server

# etcd peer cert/key
bin/hosts config/config-etcd-peer.json config/hosts-etcd | \
bin/cfssl gencert -ca=root/ca.pem -ca-key=root/ca-key.pem \
    -config=config/config-profiles.json \
    -profile=peer - | \
    bin/cfssljson -bare ${OUTPUT}/etcd-peer

chmod 0644 ${OUTPUT}/*

type openssl >/dev/null 2>&1 && {
    cat ${OUTPUT}/etcd-server.pem | openssl x509 -noout -text
    cat ${OUTPUT}/etcd-peer.pem | openssl x509 -noout -text
    echo "check etcd server hosts"
    cat ${OUTPUT}/etcd-server.pem | openssl x509 -noout -text |\
        grep 'X509v3 Subject Alternative Name' -A 1 | \
        tail -n 1 | \
        sed 's/[,]/\n/g' | \
        tr -d ' ' | \
        awk -F':' '{print $2}' | \
        diff -ruN config/hosts-etcd -

    echo "check etcd peer hosts"
    cat ${OUTPUT}/etcd-peer.pem | openssl x509 -noout -text |\
        grep 'X509v3 Subject Alternative Name' -A 1 | \
        tail -n 1 | \
        sed 's/[,]/\n/g' | \
        tr -d ' ' | \
        awk -F':' '{print $2}' | \
        diff -ruN config/hosts-etcd -
}
