#!/usr/bin/env bash

# update
sudo yum update -y

# jdk
sudo yum remove -y java-1.7.0-openjdk
sudo yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel

# maven
curl -L "http://apache.tt.co.kr/maven/maven-3/3.6.2/binaries/apache-maven-3.6.2-bin.tar.gz" | tar xz
sudo mv -f apache-maven-3.6.2 /usr/local/
sudo ln -sf /usr/local/apache-maven-3.6.2/bin/mvn /usr/local/bin/mvn

# tomcat
sudo yum install -y tomcat8

# jenkins
curl -o jenkins.war "http://mirrors.jenkins.io/war-stable/latest/jenkins.war"
mv jenkins.war /var/lib/tomcat8/webapps/ROOT.war

# start
service tomcat8 start
