import jenkins.model.Jenkins

slavesBusy=1

while (slavesBusy == 1)
{
	slavesBusy=0
	for (slave in Jenkins.instance.slaves)
	{
		println('Name: ' + slave.name)
		println('Busy: ' + slave.getComputer().countBusy())

		if ( slave.getComputer().countBusy()==0) //if slave not busy
		{
			println('Setting Slave' + slave.name + ' to temporarily offline')
			slave.getComputer().setTemporarilyOffline(true,null)
		}
		else
		{
			println('Slave' + slave.name + ' is busy. Will retry in 1 min')
			slavesBusy=1
				
		}

		println('\n')		
	}
	sleep(60*1000);
}


