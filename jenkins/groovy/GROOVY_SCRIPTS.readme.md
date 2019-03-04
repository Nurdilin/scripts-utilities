Apache Groovy is a Java-syntax-compatible object-oriented programming language for the Java platform. 
It is both a static and dynamic language with features similar to those of Python, Ruby, Perl, and Smalltalk. 
It can be used as both a programming language and a scripting language for the Java Platform, 
is compiled to Java virtual machine (JVM) bytecode, and interoperates seamlessly with other Java code and libraries. 

Useful links

https://javadoc.jenkins.io/
https://javadoc.jenkins-ci.org/
https://javadoc.jenkins-ci.org/hudson/model/package-tree.html
https://javadoc.jenkins-ci.org/jenkins/model/package-tree.html






//Various notes

Jenkins was previously known as Hudson

import hudson.model.*
for(item in Hudson.instance.items)
for (slave in Hudson.instance.salves)


hudson.model.Hudson.instance.items
hudson.model.Hudson.instance.slaves
jenkins.model.Jenkins.instance.slaves



slave.	name
	getLabelString()
	getNumExecutors()
	getRemoteFS()
	getMode()
	getRootPath()
	getDescriptor()
	getComputer()
	getComputer().isAcceptingTasks()
	getComputer().isLaunchSupported()
	getComputer().getConnectTime()
	getComputer().getDemandStartMilliseconds()
	getComputer().isOffline()
	getComputer().countBusy()
	getComputer().setTemporarilyOffline(true,null)
	getComputer().doDoDelete()
	getComputer().getLog()
	getComputer().getBuilds()

	setLabelString(newLabelName)
