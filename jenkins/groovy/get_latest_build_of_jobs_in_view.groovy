import hudson.model.*

def view_name = "Example View of master jobs of Sprint 1"  
def view = Hudson.instance.getView(view_name")
 
for(item in view.getItems())
{
  println(item.name + "\t\t" + item.lastSuccessfulBuild.number)
}
  
