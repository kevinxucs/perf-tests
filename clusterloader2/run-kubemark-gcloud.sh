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

readonly MASTER_IP="35.226.200.155"

KUBE_SSH_USER=root \
ETCD_CERTIFICATE=/etc/kubernetes/pki/etcd/server.crt \
ETCD_KEY=/etc/kubernetes/pki/etcd/server.key \
    go run cmd/clusterloader.go \
    -v=4 \
    --kubeconfig=$HOME/.kube/km-gcloud-config \
    --testconfig=${TEST_CONFIG[$test]} \
    --provider=kubemark \
    --provider-configs="ROOT_KUBECONFIG=$HOME/.kube/gcloud-config" \
    --nodes=10 \
    --report-dir=report_${test}_kubemark-gcloud-cluster \
    --masterip=${MASTER_IP} \
    --etcd-certificate=/etc/kubernetes/pki/apiserver-etcd-client.crt \
    --etcd-key=/etc/kubernetes/pki/apiserver-etcd-client.key \
    --enable-prometheus-server \
    --tear-down-prometheus-server=false \
    --testoverrides=${ROOT}/testing/overrides/stateless_only.yaml
