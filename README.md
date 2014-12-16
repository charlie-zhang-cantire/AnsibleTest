
# Ansible Starter Kit

This starter kit will create a virtual machine that you can run playbooks against. Once the virtual machine is successfully configured by ansible you should be able to hit http://192.168.31.54/ and see a default web page. I haven seen nginx take a minute or two to start and serve pages so be patient.

If network connectivity isn't working after changing network connections you might need to restart the virtualbox, you can do that with `vagrant halt ; vagrant up`.

[Further Reading](http://docs.ansible.com/)

## On Windows

### Requirements
* An internet connection with no http proxy
* Virtualbox 4.3.12
* Vagrant 1.6.5
* [Git-bash](http://git-scm.com/downloads)

### Installation
* open git bash
* `cd path/to/this/code`
* `vagrant up`

### Re-running Ansible

### The easy way with ugly output
* `vagrant provision`

### The hard way with nice output
* open git bash
* `cd path/to/code`
* `vagrant ssh`
* `sudo ansible-playbook -i /vagrant/environments/development/inventory /vagrant/playbook.yml`

### Notes on using ansible on windows

Since ansible doesn't run on windows, if you wanted to run this playbook against a "real" system you could do so from this virtual machine (see the hard way below).

## On Mac/Linux

### Requirements
* An internet connection with no http proxy
* Virtualbox 
* Vagrant 
* Ansible 

### Installation
* `cd path/to/this/code`
* `vagrant up`

### Re-running Ansible

### The easy way
* `vagrant provision`

### The hard way with nice output:
* `ansible-playbook -i environments/development/inventory playbook.yml`
