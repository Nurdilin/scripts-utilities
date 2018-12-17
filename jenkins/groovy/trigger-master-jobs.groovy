import jenkins.model.*

import jenkins.model.*
def matchedJobs = Jenkins.instance.items.findAll { job ->
   job.name =~ ".*.master"
}
matchedJobs.each { job ->
   println job.name
   job.scheduleBuild()
}
