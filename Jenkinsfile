def setDescription() { 
  def item = Jenkins.instance.getItemByFullName(env.JOB_NAME) 
  item.setDescription("<h3>This job installs Telegraf with the required parameters to scrape metrics from a given connector installed on a Linux node.</h3> \n<h3>Dashboard: <a href=\"https://15.214.145.90:8083/d/ls7wQV6Zz/arcsight-smartconnector-metrics-1?orgId=5\">SmartConnector Metrics 1</a></h3> \n<h3>Dashboard: <a href=\"https://15.214.145.90:8083/d/1cNArl6Wk/arcsight-smartconnector-metrics-2?orgId=5\">SmartConnector Metrics 2</a></h3>") 
  item.save()
  }
setDescription()

pipeline {
  agent any
  options {
    ansiColor('gnome-terminal')
	buildDiscarder(logRotator(daysToKeepStr: '180'))
  }
  parameters {
        string(
		name: 'Target_Host', 
		description: 'Connector host(s) ip separated by comma where Telegraf will be installed, e.g 15.214.x.x<span style="color:red";>,</span>15.214.x.x,15.214.x.x<span style="color:red">,</span>15.214.x.x'
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
		string(
		name: 'Connector_Directory', 
		defaultValue: '/opt/ArcSightSmartConnectors/*', 
		description: 'The directory where the connector was installed, if multiple connectors are located under the same folder then you can pass the parent folder, for instance'
		)
    }
	
            	
  stages { 

	stage('Check inventory.ini') {
      steps {
        sh '''
		   echo -e "[connectors]\\n" >  ${WORKSPACE}/inventory.ini | cat ${WORKSPACE}/inventory.ini
           echo ${Target_Host} | sed \'s/,/\\n/g\' | while read line ; do sed -i \'/\\[connectors\\]/a \\\'"${line}"\'\' ${WORKSPACE}/inventory.ini ; done
		   '''
      }
    }

    stage('Ansible Role') {
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
			connector_path: '${Connector_Directory}',
            ansible_password: [value: '${Host_Password}', hidden: true],
        ])
	  }	
    }		
		
    stage('Clean inventory.ini') {
      steps {
        sh '''
		   echo -e "[connectors]\\n]" >  ${WORKSPACE}/inventory.ini | cat ${WORKSPACE}/inventory.ini
		   '''
     }
    }
  }
}
