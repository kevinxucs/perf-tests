#!/bin/bash

ROOT=$(dirname ${BASH_SOURCE[0]})

declare -A TEST_CONFIG
TESTS_CONFIG[load]="${ROOT}/testing/load/config.yaml"
TESTS_CONFIG[density]="${ROOT}/testing/density/config.yaml"

test="$1"
if [[ -z "$test" ]]; then
    echo "missing test"
    exit 0
fi

KUBE_SSH_USER=root \
ETCD_CERTIFICATE=/etc/kubernetes/pki/etcd/server.crt \
ETCD_KEY=/etc/kubernetes/pki/etcd/server.key \
    go run cmd/clusterloader.go \
    -v=4 \
    --kubeconfig=$HOME/.kube/config \
    --testconfig=${TEST_CONFIG[$test]} \
    --provider=local \
    --nodes=3 \
    --report-dir=report_$test_local-cluster \
    --masterip=k8s-cp-01.intern.kevxu.net,k8s-cp-02.intern.kevxu.net,k8s-cp-03.intern.kevxu.net \
    --etcdip=k8s-etcd-01.intern.kevxu.net,k8s-etcd-02.intern.kevxu.net,k8s-etcd-03.intern.kevxu.net \
    --etcd-certificate=/etc/kubernetes/pki/apiserver-etcd-client.crt \
    --etcd-key=/etc/kubernetes/pki/apiserver-etcd-client.key \
    --enable-prometheus-server \
    --tear-down-prometheus-server=false \
    --testoverrides=./testing/overrides/stateless_only.yaml
