#!/bin/bash

sudo yum update -y
sudo yum install -y curl               # Install curl command to download files from internet
# Enable the EPEL repository and install the epel-release package
sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm  # Install EPEL repository package
sudo dnf makecache       # Refresh package cache so that the system recognizes the newly added repository
sudo dnf install -y epel-release      # epel-release-9-7.el9.noarch package installed
# Install Jq
sudo yum install -y jq    
# Install aws-cli            
sudo yum remove awscli                # remove pre-installed aws-cli version
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"   #download the installation file using curl command
sudo yum install -y unzip             # Install the unzip command
unzip awscliv2.zip                     # unzip the installer
sudo ./aws/install                     # run the install program
# Install ansible with pip, Python package manager
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --user              # Install pip, wheel
pip install ansible                    # Install ansible
# Install helm from script. Helm now has an installer script that will automatically grab the latest version of Helm and install it locally.
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3     # Fetch the script
chmod 700 get_helm.sh                 # Change the permissions
 ./get_helm.sh                        # Install helm into /usr/local/bin
# Install git
sudo yum install git -y               





