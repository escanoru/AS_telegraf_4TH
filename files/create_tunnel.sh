#!/bin/bash
kubectl port-forward -n $(kubectl get namespaces | cut -d ' ' -f 1 |  grep arcsight) deployment/th-kafka-manager 9001:9000 &