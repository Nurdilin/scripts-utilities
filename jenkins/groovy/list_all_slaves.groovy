import jenkins.model.Jenkins

for (slave in Jenkins.instance.slaves)
{
  println('Name: ' + slave.name)
  println('getLabelString: ' + slave.getLabelString())
  println('getNumExectutors: ' + slave.getNumExecutors())
  println('getRemoteFS: ' + slave.getRemoteFS())
  println('getMode: ' + slave.getMode())
  println('getRootPath: ' + slave.getRootPath())
  println('getDescriptor: ' + slave.getDescriptor())
  println('\n')
}

/*or

Jenkins.instance.slaves.each { slave ->
	println('Name: ' + slave.name)
}
*/
