#!/bin/bash

nice -n +19 find /logs/company -type d -empty |xargs rmdir > /dev/null 2>&1
