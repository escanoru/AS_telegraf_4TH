#! /usr/bin/env bash

# Command to get the kafka pod resource usage
kubectl top po -n $(kubectl get pod --all-namespaces | grep -Eio "arcsight-installer-([0–9a-z|a-z0-9]+)" | head -1) | grep th-kafka-[0-9+] | awk '{ gsub("m","",$2) ; gsub("Mi","",$3) ; print "exec_K8s_Podus,attribute=none POD_CPU_Mili_Cores_Request-"$1"="$2 ",POD_MEM_Usage-"$1"="$3}'