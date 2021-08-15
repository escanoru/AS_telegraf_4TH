#!/bin/bash
# for pid in $(ps -ef | grep -E "kubectl port-forward -n arcsight-" | awk '{print $2}')
  # do kill -9 $pid;
# done

for pid in $(ps -ef | grep -E "ssh -i ~/.ssh/localhost_id_rsa -o StrictHostKeyChecking=no .*" | awk '{print $2}')
 do kill -9 $pid;
done

# In one line:
# for pid in $(ps -ef | grep -E "ssh -i ~/.ssh/localhost_id_rsa -o StrictHostKeyChecking=no .*" | awk '{print $2}') ; do kill -9 $pid ; done