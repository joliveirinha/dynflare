#!/bin/bash

REGEX_IP=^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$
REGEX_NUMBER=^[0-9]+$

# register handler of sig term
signal_handler() {
  echo "terminating..."
  exit 1
}
trap signal_handler TERM

interval=${INTERVAL:-60}

# check if number
if ! [[ "$interval" =~ $REGEX_NUMBER ]] ; then
   echo "error: INTERVAL must be a number" >&2; exit 1
fi

if [ -z "$CF_API_EMAIL" ]; then
    echo "Need to set CF_API_EMAIL"
    exit 1
fi  

if [ -z "$CF_API_KEY" ]; then
    echo "Need to set CF_API_KEY"
    exit 1
fi

if [ -z "$CF_RECORD_ID" ]; then
    echo "Need to set CF_RECORD_ID"
    exit 1
fi

if [ -z "$CF_ZONE_NAME" ]; then
    echo "Need to set CF_ZONE_NAME"
    exit 1
fi

while true; do

  ip=$(curl -s https://api.ipify.org)
  
  # check if valid ip if not pass
  echo "My public IP address is: $ip"
  
  if [[ $ip =~ $REGEX_IP ]] ; then
    eval flarectl d u --zone ${CF_ZONE_NAME} --id="${CF_RECORD_ID}" --content="$ip"
  else 
    echo "Current IP ($ip) is not valid. Skipping..."
  fi

  echo "Sleeping for $interval seconds..."
  sleep $interval
done

