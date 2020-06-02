#!/bin/bash

set -e

# Exec the specified command or fall back on bash
if [ $# -eq 0 ]; then
    cmd=( "bash" )
else
    cmd=( "$@" )
fi

echo $MLFLOW_EXTRA_OPS
echo "Waiting for MySQL Server"
sleep 30s

echo "Waiting for database"
python /tmp/wait-for-mysql.py

echo "Start tracking server"
mlflow server --host 0.0.0.0 $MLFLOW_EXTRA_OPS
