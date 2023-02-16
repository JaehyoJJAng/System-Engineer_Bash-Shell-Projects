#!/usr/bin/bash

# Set While Count
WHILE_COUNT=10

# Loop
while [[ ${WHILE_COUNT} > 0 ]]
do
	echo ${WHILE_COUNT}

	# WHILE_COUNT 증감 시키기
	WHILE_COUNT=$(( ${WHILE_COUNT} - 1 ))
done
