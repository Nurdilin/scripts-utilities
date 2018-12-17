
#!/bin/bash
# Git Clone / setting app my Pen test environment
# git clones all repos created by third parties
(git clone https://github.com/jseidl/etter.filter.hrf.git   || echo "failed at etter filter http zap") &&
(git clone https://github.com/evilsocket/bettercap          || echo "failed at bettercap") &&
(git clone https://github.com/trustedsec/social-engineer-toolkit.git ||echo "Failed at social engineering toolkit") &&  
(git clone https://github.com/wpscanteam/wpscan.git         || echo "failed at wpscan" ) && 
(git clone git://git.kali.org/packages/joomscan.git         || echo "failed at joomscan") &&
(git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt --depth=1 ||echo "failed at bash git prompt")
