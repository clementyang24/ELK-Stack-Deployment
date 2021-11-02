## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Network Diagram](https://github.com/clementyang24/ELK-Stack-Deployment/blob/a5c8dfd26deb1bcfcf1e7354970d095992db8883/Images/Project%201%20Week%2013%20Diagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook file may be used to install only certain pieces of it, such as Filebeat.

- [Ansible Filebeat Playbook](https://github.com/clementyang24/ELK-Stack-Deployment/blob/a5c8dfd26deb1bcfcf1e7354970d095992db8883/Ansible/filebeat-playbook.yml)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.
- Load balancers distribute traffic between servers, ensuring that no one server is being overwhelmed with requests.
- The purpose of the Jump Box Provisioner is to both act as a gateway, as well as holding the Ansible container with which we were able to deploy ansible playbooks; specifically installing the DVWA containers, metricbeat, and filebeat on each DVWA VM, as well as the ELK Stack container on the ELK-Server VM.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the data and system logs.
- Filebeat monitors log files, collects log events, and then passes them on to elasticsearch for indexing purposes.
- Metricbeat collects data and metrics from the system and services running on one's server, and sends them to elasticsearch.

The configuration details of each machine may be found below:

| Name                 | Function                | IP Address | Operating System            |
|----------------------|-------------------------|------------|-----------------------------|
| Jump-Box-Provisioner | Gateway and Provisioner | 10.0.0.4   | UbuntuServer 18.04 LTS Gen1 |
| ELK-Server           | ELK Stack Container     | 10.1.0.4   | UbuntuServer 18.04 LTS Gen1 |
| Web-1                | DVWA Container          | 10.0.0.5   | UbuntuServer 18.04 LTS Gen1 |
| Web-2                | DVWA Container          | 10.0.0.6   | UbuntuServer 18.04 LTS Gen1 |
| Web-3                | DVWA Container          | 10.0.0.7   | UbuntuServer 18.04 LTS Gen1 |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump-Box-Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 96.255.138.250 (home workstation)

Machines within the network can only be accessed by the Jump Box Provisioner.
- The Elk-VM is accessible via SSH from the Jump Box Provisioner, and also from the user's home workstation in order to access the Kibana application via Port 5601.
- The DWVA machines are accessible via HTTP from the user's workstation, but only through the load balancer.

A summary of the access policies in place can be found in the table below.

| Name                 | Publicly Accessible? | Allowed IP Addresses                                   |
|----------------------|----------------------|--------------------------------------------------------|
| Jump-Box-Provisioner | Yes                  | 96.255.138.250                                         |
| Elk-Server           | Yes                  | 96.255.138.250, 10.0.0.4, 10.0.0.5, 10.0.0.6, 10.0.0.7 |
| Web-1                | No                   | 52.188.207.97, 10.0.0.4                                |
| Web-2                | No                   | 52.188.207.97, 10.0.0.4                                |
| Web-3                | No                   | 52.188.207.97, 10.0.0.4                                |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because automating configuration allows more flexibility for future updates, and enables easy reproduction for anyone else who would like to implement the same tasks.

The playbook implements the following tasks:
- Install docker.io
- Install python3-pip
- Install docker module
- Increase the amount of virtual memory and uses that additional memory, by setting the vm.max_map_count to 262144.
- Download and launch the docker elk container
- Uses systemd to enable docker service on boot, so that docker does not require restart every time the machine restarts.

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![Docker PS image](https://github.com/clementyang24/ELK-Stack-Deployment/blob/a5c8dfd26deb1bcfcf1e7354970d095992db8883/Images/Elk_Container.PNG)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.0.0.5 Web-1
- 10.0.0.6 Web-2
- 10.0.0.7 Web-3

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat allows us to collect system logs. For example, Filebeat's auditd module is able to parse logs from Linux's audit daemon, and then ship them on to elasticsearch.
- Metricbeat monitors and collects system metric information. One example of this is Metricbeat's Apache module, which periodically collects metrics from Apache HTTPD servers.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the playbook file to /etc/ansible/roles.
- Update the playbook file to include the latest version of filebeat/metricbeat, and the hosts group you wish to install the beats to.
- Run the playbook, and navigate to your Kibana dashboard to check that the installation worked as expected.

Answer the following questions to fill in the blanks:
- _Which file is the playbook? Where do you copy it?_
	- [Ansible Filebeat Playbook](https://github.com/clementyang24/ELK-Stack-Deployment/blob/a5c8dfd26deb1bcfcf1e7354970d095992db8883/Ansible/filebeat-playbook.yml)
	- [Ansible Metricbeat Playbook](https://github.com/clementyang24/ELK-Stack-Deployment/blob/a5c8dfd26deb1bcfcf1e7354970d095992db8883/Ansible/metricbeat-playbook.yml)
	- Copy these to your /etc/ansible/roles directory within your Ansible container.

- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
	- Update your Ansible hosts file (found at /etc/ansible/hosts) to specify different groups of machines which you would like to run the playbook on. For example, by default there is a webservers group, which should contain the IPs of your DVWA Web-VM containers which you want to install Filebeat and Metricbeat on. Additionally, we also created an [elk] group for the ELK-server, where we used to ELK-server IP in order to specify that we wanted to use the install-elk playbook on the ELK-Server VM.
- _Which URL do you navigate to in order to check that the ELK server is running?_
	-http://[your.ELK-VM.External.IP]:5601/app/kibana
	