#!/bin/bash

# Update OS
yum update -y

# Set hostname
hostnamectl set-hostname jenkins-server

# Install dependencies
yum install -y git java-17-amazon-corretto wget python3-pip unzip docker bash-completion

# Enable and start Docker
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user
usermod -aG docker jenkins || true

# Jenkins repo
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat/jenkins.io-2023.key

# Install Jenkins
yum install -y jenkins
systemctl enable jenkins
systemctl start jenkins

# Docker Compose
curl -SL https://github.com/docker/compose/releases/download/v2.29.4/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Install Ansible and Boto3
pip3 install ansible boto3 botocore

# Apply git-aware colored PS1 to ec2-user
cat << 'EOF' >> /home/ec2-user/.bashrc
parse_git_branch() {
  git rev-parse --is-inside-work-tree &>/dev/null || return
  git symbolic-ref --short HEAD 2>/dev/null | awk '{print " (" $1 ")"}'
}
export PS1="\[\e[34m\]\u\[\e[32m\]@\h \[\e[33m\]\W\[\e[36m\]\$(parse_git_branch)\[\e[0m\]\$ "
EOF

# Ensure .bashrc is sourced on login
grep -q 'source ~/.bashrc' /home/ec2-user/.bash_profile || echo 'if [ -f ~/.bashrc ]; then . ~/.bashrc; fi' >> /home/ec2-user/.bash_profile

# Set permissions
chown ec2-user:ec2-user /home/ec2-user/.bashrc /home/ec2-user/.bash_profile