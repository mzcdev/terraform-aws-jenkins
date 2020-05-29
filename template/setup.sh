#!/bin/bash
set -e -x

DNS_NAME="${DNS_NAME}"
TOKEN="${TOKEN}"

# update
yum update -y

# jdk
yum remove -y java-1.7.0-openjdk
yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel

# jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

yum install -y jenkins

# start
sudo service jenkins start
sudo chkconfig jenkins on

while [ ! -f /var/lib/jenkins/secrets/initialAdminPassword ]; do
    sleep 1
done

PASS=$(sudo bash -c "cat /var/lib/jenkins/secrets/initialAdminPassword")

# slack
if [ "$TOKEN" != "" ]; then
curl -sL opspresso.github.io/tools/slack.sh | bash -s -- \
    --token="$TOKEN" --username="jenkins" \
    --footer_icon='https://jenkins.io/sites/default/files/jenkins_favicon.ico' \
    --footer="<https://$DNS_NAME|jenkins>" \
    --title="Unlock Jenkins" "\`$PASS\`"
fi
