#!/bin/bash

hostname "mordor"
sed -i 's/"default"/"mordor"/' /etc/hosts
sed -i 's/"default"/"mordor"/' /etc/hostname

