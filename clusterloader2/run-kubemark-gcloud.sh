#!/bin/bash

ROOT=$(dirname ${BASH_SOURCE[0]})

declare -A TEST_CONFIG
TEST_CONFIG[load]="${ROOT}/testing/load/config.yaml"
TEST_CONFIG[density]="${ROOT}/testing/density/config.yaml"

test="$1"
if [[ -z "$test" ]]; then
    echo "missing test"
    exit 0
fi

ETCD_CERTIFICATE=/etc/kubernetes/pki/etcd/server.crt \
ETCD_KEY=/etc/kubernetes/pki/etcd/server.key \
    go run cmd/clusterloader.go \
    -v=4 \
    --kubeconfig=$HOME/.kube/km-gcloud-config \
    --testconfig=${TEST_CONFIG[$test]} \
    --provider=kubemark \
    --provider-configs="ROOT_KUBECONFIG=$HOME/.kube/gcloud-config" \
    --nodes=10 \
    --report-dir=report_${test}_kubemark-cluster \
    --masterip=34.122.28.250 \
    --etcd-certificate=/etc/kubernetes/pki/apiserver-etcd-client.crt \
    --etcd-key=/etc/kubernetes/pki/apiserver-etcd-client.key \
    --enable-prometheus-server \
    --tear-down-prometheus-server=true \
    --testoverrides=${ROOT}/testing/overrides/stateless_only.yaml
