import jenkins.model.*

#Jenkins.instance.items.findAll()

def matchedJobs = Jenkins.instance.items.findAll { job ->
	job.name =~ "my_custom_pattern*"
}
    
matchedJobs.each { job ->
	println job.name
	job.delete()
}


/* */


Jenkins.instance.metaClass.methods*.name
