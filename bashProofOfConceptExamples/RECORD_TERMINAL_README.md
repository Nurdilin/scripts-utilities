RECORD
script -t 2> timing.log -a output.session

>type
>type etc
>exit

REPLAY
scriptreplay timing.log output.session


