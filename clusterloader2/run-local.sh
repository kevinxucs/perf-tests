#!/bin/bash

KUBE_SSH_USER=root ./clusterloader --kubeconfig=$HOME/.kube/config --testconfig=testing/load/config.yaml --provider=local --nodes=3 --report-dir=loadreport --masterip=k8s-cp-01,k8s-cp-02,k8s-cp-03 --etcd-certificate=/etc/kubernetes/pki/apiserver-etcd-client.crt --etcd-key=/etc/kubernetes/pki/apiserver-etcd-client.ke
