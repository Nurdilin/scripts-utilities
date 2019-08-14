def smt = hudson.model.Hudson.instance
smt.getItems(hudson.model.Job).each {job ->
  println("Name:\t\t" +job.displayName)
  //println(job.isDisabled())
  try {println("Workspace:\t"+ job.workspace)} catch(Exception e1) {println("It's a PipeLine.")}
  println("\n")
}
