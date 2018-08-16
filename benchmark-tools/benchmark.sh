#!/bin/bash

export LANG=en_us.UTF-8

BASE_DIR=$(dirname $0)

#JAVA_HOME
if [ -z $JAVA_HOME ]; then
  JAVA_HOME="/usr/java/jre8"
fi
#JAVA_PATH
JAVA_PATH=$JAVA_HOME/bin/java

export BASE_DIR
export JAVA_PATH

$JAVA_PATH -jar ${BASE_DIR}/arp-benchmark-tools.jar "$@"
