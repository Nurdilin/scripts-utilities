import hudson.model.*

  
def NEW_PART = "NEW_"

(Hudson.instance.items.findAll { job -> job.name =~ "TEST_FANIS2" }).each { job_to_copy -> 
  
  
    def new_job_name = NEW_PART + job_to_copy.name  
  
    println ("Copying job " + job_to_copy.name + " to " + new_job_name)

    def newjob = Hudson.instance.copy(job_to_copy, new_job_name)
  
    newjob.save()

    println("="*80)
  

}  
