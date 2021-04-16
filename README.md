Telegraf TH Metriccs
=========================================

Supported versions: 3.4 and 3.5

Ansible role to install Telegraf and configure the needed scripts on a TH cluster (both Master and Workers) to get the metrics from the Kafka Manager, TH API, arcsight NS pod resources(RAM and Milicore). This role will also scrape the size of the following topics on each worker node:
1. th-cef
2. th-arcsight-avro
3. th-binary_esm
4. mf-event-avro-esmfiltered
5. mf-event-avro-enriched

This roles includes the telegraf and xidel packages so there is no need to download them.

Requirements
------------
1. CentOS-7/RHEL-7
2. Ansible 2.9.2+ (It might work on Ansible 2.10. but we haven't tested), once Ansible is installed, make sure the parameter ```"host_key_checking = False"``` **is uncomment** on the ```/etc/ansible/ansible.cfg```, this is necessary if you don't want to distribuite the ssh public key to all your target servers)
3. An InfluxDB with a database (created before running this role) where the metrics collected by telegraf will be stored.
4. A Grafana 7.x instance connected to InfluxDB to plot collected metrics.

Role Variables
--------------
The following variables are used in this role, the user should fill each variable with its respective value on the ```main_static.yml``` file (or provide them when using ```main_dynamic.yml```) :
1. "th_version" - > could be 3.4 ot 3.5
2. "interval", -> how often telegraf collects the metrics
3. "influxdb_ip" -> InfluxDB ip
4. "database_name" -> InfluxDB's database
5. "db_username" -> InfluxDB's username, leave empty if no user is needed.
6. "db_username_pass" -> InfluxDB's username password, leave empty if no user is needed.
7. "proxyk" -> proxy hostnama/ip, e.g http://my_proxy.local:8185, leave empty if no proxy is needed

Dependencies
------------
none

Instructions
---------------------------
1. Download this project to your ansible instance
2. Open the ```th_cluster_inventory.ini``` file and add 1 master(only 1 master is needed) and the workers running on your TH cluster
3. Open the ```main_static.yml``` file and fill the variables with the apropriate information.
4. Run the playbook by running the command below:
```sh
time sudo ansible-playbook -i th_cluster_inventory.ini main_static.yml -k --ssh-extra-args="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
```
  Alternatively, you can run the following command to enter the variables values through command prompt:

```sh
time sudo ansible-playbook -i th_cluster_inventory.ini main_dynamic.yml -k --ssh-extra-args="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
```

The ```--ssh-extra-args="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"``` part is to avoid adding the target's ECDSA key to the ~/.ssh/known_hosts file, this is for testing servers that are constantly getting their OS redeployed.

License
-------
BSD

Author Information
------------------
Arcsight System-Test team
