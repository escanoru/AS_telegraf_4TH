#!/bin/bash

#Arcsight System-Test method to scrape kafka manager metrics from TH.

#Topics' metrics, topics' name go first:
xidel -s --xquery 'for $tr in //tr[position()>=1] return join($tr/td, " ")' "http://127.0.0.1:9001/clusters/transformation-hub/topics" | awk '{gsub(/,/,"",$10); print "TP_"$1"="$2, "EPS_"$1"="$9, "TO_"$1"="$10, $1}' | tail -n  +3
#"EPS_"$1"="$9 -> Topics'EPS
#"TO_"$1"="$10 -> Summed Recent Offsets
#"TP_"$1"="$2 -> Partitions Topic
#"BC_"$1"="$3 -> Brokers Count
#"BS%_"$1"="$5 -> Broker Skew %
#"BLS%_"$1"="$6 -> Brokers Leader Skew %
#"UR"$1"="$8 -> Under Replicated %
#"TR_"$1"="$7 -> Replicas
#"BS_"$1"="$4 -> Brokers Spread %

#Consumers' Lag:
xidel -s --xquery 'for $tr in //tr[position()>0] return join($tr/td, " ")' "http://127.0.0.1:9001/clusters/transformation-hub/consumers" | awk NF=NF | awk 'NR%2{printf "%s ",$0;next;}1' | awk '{gsub (")","");gsub (":",""); gsub ("[(]","") ; gsub ("[%]","") ;print $1"__LAG__Consuming_From__"$3"="$6, $1"_Coverage_From_"$3"="$4}'

#Number of available brokers on Kafka Manager:
curl -s http://127.0.0.1:9001/clusters/transformation-hub/brokers | egrep -o ">10[0-9][0-9]<" | wc -l | awk '{print "Brokers_on_KM="$1}'