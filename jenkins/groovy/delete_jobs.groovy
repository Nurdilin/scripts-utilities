import jenkins.model.*

def matchedJobs = Jenkins.instance.items.findAll { job ->
    job.name =~ "my_custom_pattern*"
}
    
matchedJobs.each { job ->
    println job.name
    job.delete()

}
