import jenkins.model.*

def matchedJobs = Jenkins.instance.items.findAll { job ->
    job.name =~ "(sprt-*).*.master"
}
    
matchedJobs.each { job ->
    println job.name
    job.disable()

}
