#!/bin/bash

KUBE_SSH_USER=root \
    go run cmd/clusterloader.go \
    --kubeconfig=$HOME/.kube/config \
    --testconfig=testing/load/config.yaml \
    --provider=local \
    --nodes=3 \
    --report-dir=loadreport \
    --masterip=k8s-cp-01.intern.kevxu.net,k8s-cp-02.intern.kevxu.net,k8s-cp-03.intern.kevxu.net \
    --etcd-certificate=/etc/kubernetes/pki/apiserver-etcd-client.crt \
    --etcd-key=/etc/kubernetes/pki/apiserver-etcd-client.key
