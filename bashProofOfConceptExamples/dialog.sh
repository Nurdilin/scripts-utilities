#!/bin/bash
if (dialog --title "Message"  --yesno "Are you having fun?" 6 25)
then echo "glad you have fun"
else echo "sad you don't have fun"
fi
