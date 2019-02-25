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
  println('getComputer: ' + slave.getComputer())
  println('\tcomputer.isAcceptingTasks: ' + slave.getComputer().isAcceptingTasks())
  println('\tcomputer.isLaunchSupported: ' + slave.getComputer().isLaunchSupported())
  println('\tcomputer.getConnectTime: ' + slave.getComputer().getConnectTime())
  println('\tcomputer.getDemandStartMilliseconds: ' + slave.getComputer().getDemandStartMilliseconds())
  println('\tcomputer.isOffline: ' + slave.getComputer().isOffline())
  println('\tcomputer.countBusy: ' + slave.getComputer().countBusy())
  //println('\tcomputer.getLog: ' + slave.getComputer().getLog())
  println('\tcomputer.getBuilds: ' + slave.getComputer().getBuilds())
  println('\n')
}

