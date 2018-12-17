#!/usr/bin/expect

spawn ssh user@servercom
expect -re "Password:"
send -- "here\-be\-password\r"
Interact
