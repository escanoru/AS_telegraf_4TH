#! /usr/bin/env bash

# Method to scrape kafka manager metrics from TH.

# Topic Metrics
xidel -s --xquery 'for $tr in //tr[position()>=1] return join($tr/td, " ")' "http://127.0.0.1:9001/clusters/transformation-hub/topics" | awk '{gsub(/,/,"",$10); print "exec_Kafka_Manager_Topic_Metrics,attribute=none,Topic="$1" EPS="$9",Offset="$10",Partitions="$2",Brokers_Count="$3",Broker_Skew_%="$5",Brokers_Leader_Skew_%="$6",Under_Replicated_%="$8",Replicas="$7",Brokers_Spread_%="$4}' | tail -n  +3

# Topics' Name -> $1
# Topics'EPS -> $9
# Summed Recent Offsets -> $10
# Partitions Topic -> $2
# Brokers Count -> $3
# Broker Skew % -> $5
# Brokers Leader Skew % -> $6
# Under Replicated % -> $8
# Replicas -> $7
# Brokers Spread % -> $4


# Consumer's coverage %, lag and type:
xidel -s --xquery 'for $tr in //tr[position()>0] return join($tr/td, " ")' "http://127.0.0.1:9001/clusters/transformation-hub/consumers" | awk NF=NF | awk 'NR%2{printf "%s ",$0;next;}1' | awk '{gsub (")","");gsub (":",""); gsub ("[(]","") ; gsub ("[%]","") ;print "exec_Kafka_Manager_Consumer_Metrics,attribute=none,Consumer="$1"--consuming--from--"$3",Type="$2" Coverage_%="$4",LAG="$6}'


# Broker Metrics:
curl -s http://127.0.0.1:9001/clusters/transformation-hub/brokers | egrep -o ">10[0-9][0-9]<" | wc -l | awk '{print "exec_Kafka_Manager_Broker_Metrics,attribute=none Brokers_on_KM="$1}'