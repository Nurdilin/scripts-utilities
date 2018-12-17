#!/bin/bash
# Git Clone
# git clones all my repos
(git clone git@github.com:Nurdilin/Batch-Scripts.git            || echo "failed at batch scrips") &&
(git clone git@github.com:Nurdilin/unshadow.git                 || echo "failed at unshadow") &&
(git clone git@github.com:Nurdilin/Print-Binary.git             || echo "failed at binary print") &&
(git clone git@github.com:Nurdilin/wps_guesser.git              || echo "failed at wps guesser") &&
(git clone git@github.com:Nurdilin/Utilities.git                || echo "failed at batch utilities") &&
(git clone git@github.com:Nurdilin/scripts_and_wrappers.git     || echo "failed at scripts and wrappers") &&
(git clone git@github.com:Nurdilin/ettercap-filters.git         || echo "failed at Ettercap Filters") &&
(git clone git@github.com:Nurdilin/Chess.git                    || echo "failed at chess") &&
(git clone git@github.com:Nurdilin/C-Utilities.git              || echo "failed at C-Utilities") &&
(git clone git@github.com:Nurdilin/Bash-Scripting-Utilities.git || echo "failed at Bash Scriptin Utilities") &&
(git clone git@github.com:Nurdilin/portScanner-C.git            || echo "failed at port Scanner C") &&
(git clone git@github.com:Nurdilin/BattleShipCpp.git            || echo "failed at Battle Ship C++") &&
(git clone git@github.com:Nurdilin/KnownPortsC.git              || echo "failed at Known Ports C")
