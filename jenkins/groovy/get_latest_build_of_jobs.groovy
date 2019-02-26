import jenkins.model.*

def matchedJobs = Jenkins.instance.items.findAll { job ->
	job.name =~ ".*.my-patterb"
}

matchedJobs.each { job ->
	println (job.name + "\t\t" + job.lastSuccessfulBuild.number)
}

