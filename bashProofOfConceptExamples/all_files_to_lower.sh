#!/bin/bash


for file in *.jpg; do
	mv "$file" "${file,,}"
done
