#!/bin/bash


_genPasswd() {
	tr -dc A-Za-z0-9 < /dev/urandom | head -c ${1:-8} | xargs
}

_genPasswd
