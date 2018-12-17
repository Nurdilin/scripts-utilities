#!/bin/bash

nice -n +19 find $1 -name  '*log*' -type f  -mtime $2  | xargs rm > /dev/null 2>&1
