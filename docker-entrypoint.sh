#!/bin/bash

interval=${INTERVAL:-60}

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
  echo "My public IP address is: $ip"

  eval flarectl d u --zone ${CF_ZONE_NAME} --id="${CF_RECORD_ID}" --content="$ip"
 
  echo "Sleeping for $interval seconds..."
  sleep $interval
done

