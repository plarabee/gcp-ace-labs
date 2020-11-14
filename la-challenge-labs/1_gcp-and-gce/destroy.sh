#!/bin/bash

# if PROJECT_ID not already set, find challenge lab 1 from project list
if ! [[ -v PROJECT_ID ]] ; then
	PROJECT_ID=$(gcloud projects list | grep 'challenge-lab-1' | awk '{ print $1 }')
fi

# delete project
gcloud projects delete $PROJECT_ID --quiet
