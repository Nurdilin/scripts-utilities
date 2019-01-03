import jenkins.model.*

println("Current number of master executors "+Jenkins.instance.getNumExecutors())

Jenkins.instance.setNumExecutors(0)
println("New number of master executors (should be 0) "+Jenkins.instance.getNumExecutors())

/*
def my_instance = Jenkins.getInstance()
my_instance.getNumExecutors()
*/
