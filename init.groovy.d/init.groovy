#!groovy

import jenkins.model.*

def instance = jenkins.model.Jenkins.getInstance()
def hudsonRealm = new hudson.security.HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("admin","password")
instance.setSecurityRealm(hudsonRealm)
instance.setInstallState(jenkins.install.InstallState.INITIAL_SETUP_COMPLETED)
instance.save()

// instance.restart()
