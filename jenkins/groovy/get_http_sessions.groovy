//
// Install Monitoring plugin first
// Copied from https://wiki.jenkins.io/display/JENKINS/Monitoring+Scripts
// 

import net.bull.javamelody.*;
import net.bull.javamelody.internal.model.*;
import net.bull.javamelody.internal.common.*;
 
println SessionListener.getSessionCount() + " sessions:";
sessions = SessionListener.getAllSessionsInformations();
for (session in sessions) {
    println session;
}
