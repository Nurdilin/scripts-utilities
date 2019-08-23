import hudson.model.*

(Hudson.instance.items.findAll { job -> job.name =~ "PATTERN_TO_SEARCH_FOR" }).each { job_to_rename -> 
    

	def new_job_name = "NEW_" + job_to_update.name  //Append new part to the job name
	println ("We wll rename:" + job_to_rename + "to New name: " + new_job_name)
    
	job_to_rename.renameTo(new_job_name)
    
	println ("Updated name: " + job_to_rename.name)
    	println("="*100)
}  
