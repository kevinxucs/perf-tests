#!/bin/bash

ROOT=$(dirname ${BASH_SOURCE[0]})

declare -A TEST_CONFIG
TESTS_CONFIG[load]="${ROOT}/testing/load/config.yaml"
TESTS_CONFIG[density]="${ROOT}/testing/density/config.yaml"

test="$1"
if [[ -z "$tests" ]]; then
    echo "missing test"
    exit 0
fi

KUBE_SSH_USER=root \
ETCD_CERTIFICATE=/etc/kubernetes/pki/etcd/server.crt \
ETCD_KEY=/etc/kubernetes/pki/etcd/server.key \
    go run cmd/clusterloader.go \
    -v=4 \
    --kubeconfig=$HOME/.kube/km-config \
    --testconfig=${TEST_CONFIG[$test]}} \
    --provider=kubemark \
    --nodes=60 \
    --report-dir=report_$test_kubemark-cluster \
    --masterip=k8s-km-01.intern.kevxu.net \
    --etcd-certificate=/etc/kubernetes/pki/apiserver-etcd-client.crt \
    --etcd-key=/etc/kubernetes/pki/apiserver-etcd-client.key \
    --testoverrides=./testing/overrides/stateless_only.yaml
