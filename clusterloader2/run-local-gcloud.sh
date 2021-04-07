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

MASTER_IP="104.197.146.205"
ETCD_IP="${MASTER_IP}"

ETCD_CERTIFICATE=/etc/kubernetes/pki/etcd/server.crt \
ETCD_KEY=/etc/kubernetes/pki/etcd/server.key \
    go run cmd/clusterloader.go \
    -v=4 \
    --kubeconfig=$HOME/.kube/config \
    --testconfig=${TEST_CONFIG[$test]} \
    --provider=local \
    --nodes=3 \
    --report-dir=report_${test}_local-gcloud-cluster \
    --masterip=${MASTER_IP} \
    --etcdip=${ETCD_IP} \
    --etcd-certificate=/etc/kubernetes/pki/apiserver-etcd-client.crt \
    --etcd-key=/etc/kubernetes/pki/apiserver-etcd-client.key \
    --enable-prometheus-server \
    --tear-down-prometheus-server=false \
    --testoverrides=${ROOT}/testing/overrides/stateless_only.yaml
