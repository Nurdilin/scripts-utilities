import hudson.model.*

  
def NEW_PART = "NEW_"
def viewName = "test_view"
def view = Hudson.instance.getView(viewName)

for(job_to_copy in view.getItems()) {
  
  
    def new_job_name = NEW_PART + job_to_copy.name  
  
    println ("Copying job " + job_to_copy.name + " to " + new_job_name)

    def newjob = Hudson.instance.copy(job_to_copy, new_job_name)
  
    newjob.save()

    println("="*80)
  
}  
