#!/usr/bin/env bash

: "${INIT_SCRIPT:=${INIT_SCRIPT:-none}}"

if [[ "${INIT_SCRIPT}" != "none" ]];
then
  ${INIT_SCRIPT}
fi;

schematool -dbType postgres -validate
if [[ $? -ne 0 ]];
then
  schematool -dbType postgres  -initSchema
fi;

hiveserver2 --service metastore &
hiveserver2

