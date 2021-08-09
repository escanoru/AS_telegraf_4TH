#! /usr/bin/env bash

# Kafka - Get topics and consumer metrics
/opt/TH_SCRAPPER/TH_KAKFA_SCRAPPER


# Broker Metrics:
curl -s -k "https://127.0.0.1:9001/th/cmak/clusters/transformation-hub/brokers" | egrep -o ">10[0-9][0-9]<" | wc -l | awk '{print "exec_Kafka_Manager_Broker_Metrics,attribute=none Brokers_on_KM="$1}'