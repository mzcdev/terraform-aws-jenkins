#!/bin/bash
set -e -x

function waitForJenkins() {
    echo "Waiting jenkins to launch on 8080..."

    while ! nc -z localhost 8080; do
      sleep 0.1 # wait for 1/10 of the second before check again
    done

    echo "Jenkins launched"
}

function waitForPasswordFile() {
    echo "Waiting jenkins to generate password..."

    while [ ! -f /var/lib/jenkins/secrets/initialAdminPassword ]; do
      sleep 2 # wait for 1/10 of the second before check again
    done

    echo "Password created"
}

# update
yum update -y

# jdk
yum remove -y java-1.7.0-openjdk
yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel

# jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

yum install -y jenkins

# init
mkdir -p /var/lib/jenkins/init.groovy.d/

cat <<EOF > /var/lib/jenkins/init.groovy.d/base.groovy
#!groovy
import jenkins.model.*

def instance = jenkins.model.Jenkins.getInstance()
def hudsonRealm = new hudson.security.HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("${USERNAME}","${PASSWORD}")
instance.setSecurityRealm(hudsonRealm)
instance.setInstallState(jenkins.install.InstallState.INITIAL_SETUP_COMPLETED)
instance.save()

# final List<String> REQUIRED_PLUGINS = [
#     "aws-credentials",
#     "copyartifact",
#     "git",
#     "ssh-agent",
#     "tap",
#     "workflow-aggregator",
# ]
# # if (Jenkins.instance.pluginManager.plugins.collect {
# #         it.shortName
# #     }.intersect(REQUIRED_PLUGINS).size() != REQUIRED_PLUGINS.size()) {
#     REQUIRED_PLUGINS.collect {
#         Jenkins.instance.updateCenter.getPlugin(it).deploy()
#     }.each {
#         it.get()
#     }
# #     Jenkins.instance.restart()
# #     println 'Run this script again after restarting to create the jobs!'
# #     throw new RestartRequiredException(null)
# # }

# instance.restart()
EOF

chown jenkins.jenkins -R /var/lib/jenkins

# start
sudo service jenkins start
sudo chkconfig jenkins on

waitForPasswordFile

PASS=$(sudo bash -c "cat /var/lib/jenkins/secrets/initialAdminPassword")

sleep 10

waitForJenkins

# INSTALL CLI
sudo cp /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar /var/lib/jenkins/jenkins-cli.jar

# INSTALL PLUGINS
sudo java -jar /var/lib/jenkins/jenkins-cli.jar -s http://localhost:8080 -auth ${USERNAME}:${PASSWORD} install-plugin ${plugins}

# RESTART JENKINS TO ACTIVATE PLUGINS
sudo java -jar /var/lib/jenkins/jenkins-cli.jar -s http://localhost:8080 -auth ${USERNAME}:${PASSWORD} restart
