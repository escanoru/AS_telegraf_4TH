#!/bin/bash

#Rquest RSP metrics
sleep 0.1
curl -s --noproxy 127.0.0.1 -k -u  "admin:atlas" https://127.0.0.1:32080/cluster/broker/metric > /opt/TH_SCRAPPER/th_kafka_brokers_metrics.json