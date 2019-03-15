#!/bin/bash

echo "Enter Password"
stty -echo
read password
stty echo
echo "echoing pass: $password"
