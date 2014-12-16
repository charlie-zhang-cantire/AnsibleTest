#!/bin/bash
#
# Windows shell provisioner for Ansible playbooks, based on KSid's
# windows-vagrant-ansible: https://github.com/KSid/windows-vagrant-ansible
#
# @todo - Allow proxy configuration to be passed in via Vagrantfile config.
#
# @see README.md
# @author Jeff Geerling, 2014
# @version 1.0
#

# Uncomment if behind a proxy server.
# export {http,https,ftp}_proxy='http://username:password@proxy-host:80'

ANSIBLE_PLAYBOOK=$1
ANSIBLE_CONFIG=$2
TEMP_CONFIG="/tmp/ansible_conf"

if [ ! -f /vagrant/$ANSIBLE_PLAYBOOK ]; then
  echo "Cannot find Ansible playbook."
  exit 1
fi

if [ ! -d /vagrant/$ANSIBLE_CONFIG ]; then
  echo "Cannot find Ansible config."
  exit 2
fi

mkdir -p ${TEMP_CONFIG}
cd ${TEMP_CONFIG}

# Install Ansible and its dependencies if it's not installed already.
if [ ! -f /usr/bin/ansible ]; then
  echo "Installing Ansible dependencies and Git."
  yum install -y git python python-devel wget
  echo "Installing pip via easy_install."
  wget http://peak.telecommunity.com/dist/ez_setup.py
  python ez_setup.py && rm -f ez_setup.py
  easy_install pip
  # Make sure setuptools are installed crrectly.
  pip install setuptools --no-use-wheel --upgrade
  echo "Installing required python modules."
  pip install paramiko pyyaml jinja2 markupsafe
  echo "Installing Ansible."
  pip install ansible
fi

cp -R /vagrant/${ANSIBLE_CONFIG}/* ${TEMP_CONFIG} && chmod -x ${TEMP_CONFIG}/inventory
echo "Running Ansible provisioner defined in Vagrantfile."
ansible-playbook -v /vagrant/${ANSIBLE_PLAYBOOK} -i ${TEMP_CONFIG}/inventory --extra-vars "is_windows=true" --connection=local
rm -rf ${TEMP_CONFIG}
