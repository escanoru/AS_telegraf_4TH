pipeline {
  agent any
  options {
    ansiColor('gnome-terminal')
	buildDiscarder(logRotator(daysToKeepStr: '180'))
  }
  parameters {
        string(
		name: 'Master', 
		description: '<h4>Only 1 master node ip is needed, even if the cluster has multiple masters only provide 1.</h4>'
		)
		string(
		name: 'Workers', 
		description: '<h4>Worker nodes ip separated by comma, e.g 15.214.x.x<span style=\"color:red\";>,</span>15.214.x.x,15.214.x.x<span style=\"color:red\">,</span>15.214.x.x</h4>'
		)
        password(
		name: 'Host_Password', 
		defaultValue: 'arst@dm1n', 
		description: 'Node password where telegraf will be installed'
		)
        string(
		name: 'Interval', 
		defaultValue: '10', 
		description: 'How often(in seconds) the metrics will be scrapped, default is 10 seconds'
		)
        string(
		name: 'InfluxDB', 
		defaultValue: '15.214.128.179', 
		description: 'The InfluxDB server ip/hostname where the metrics will be sent'
		)
        string(
		name: 'Database', 
		defaultValue: 'system_test', 
		description: 'The data base name where the metrics will be stored'
		)
    }
	
            	
  stages { 

	stage('Check inventory.ini') {
      steps {
        sh '''
		   echo -e "[master]\n\n[workers]" >  ${WORKSPACE}/inventory.ini | cat ${WORKSPACE}/inventory.ini
		   echo ${Master} | sed 's/,/\n/g' | while read line ; do sed -i '/\[master\]/a \'"${line}"'' ${WORKSPACE}/inventory.ini ; done
		   echo ${Master} | sed \'s/,/\\n/g\' | while read line ; do sed -i \'/\\[master\\]/a \\\'"${line}"\'\' ${WORKSPACE}/inventory.ini ; done
		   echo ${Workers} | sed \'s/,/\\n/g\' | while read line ; do sed -i \'/\\[workers\\]/a \\\'"${line}"\'\' ${WORKSPACE}/inventory.ini ; done
		   '''
      }
    }

    stage('Running Ansible Role') {
      steps {
        ansiblePlaybook(
        playbook: '${WORKSPACE}/main_for_jenkins.yml',
        inventory: '${WORKSPACE}/inventory.ini',
        colorized: true,
		extras: '--ssh-extra-args="-o StrictHostKeyChecking=no"',
        extraVars: [
		    granularity: '${Interval}',
            influxdb_ip: '${InfluxDB}',
            database_name: '${Database}',
            ansible_password: [value: '${Host_Password}', hidden: true],
        ])
	  }	
    }		
		
    stage('Clean inventory.ini') {
      steps {
        sh '''
		   echo -e "[master]\n\n[workers]" >  ${WORKSPACE}/inventory.ini | cat ${WORKSPACE}/inventory.ini
		   '''
     }
    }
  }
}
def setDescription() { 
  def item = Jenkins.instance.getItemByFullName(env.JOB_NAME) 
  item.setDescription("<h3>This jobs installs Telegraf with the required parameters to scrape metrics from the kafka-manager pod in a given master node, it also scrapes the topic size of the th-cef, th-arcsight-avro and the th-binary_esm topics from the worker nodes</h3> \n<h3>Dashboard: <a href=\"https://15.214.145.90:8083/d/H3TCoAjWz/th-kafka-metrics-single-instance-node-metrics?orgId=5&refresh=1m\">TH Kafka Metrics (Single Instance) + Node Metrics</a></h3>") 
  item.save()
  }
setDescription()
