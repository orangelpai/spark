#!/usr/bin/env bash

# Starts the master on the machine this script is executed on.

bin=`dirname "$0"`
bin=`cd "$bin"; pwd`

. "$bin/spark-config.sh"

# Set SPARK_PUBLIC_DNS so the master report the correct webUI address to the slaves
if [ "$SPARK_PUBLIC_DNS" = "" ]; then
    # If we appear to be running on EC2, use the public address by default:
    if [[ `hostname` == *ec2.internal ]]; then
        echo "RUNNING ON EC2"
        export SPARK_PUBLIC_DNS=`wget -q -O - http://instance-data.ec2.internal/latest/meta-data/public-hostname`
    fi
fi

"$bin"/spark-daemon.sh start spark.deploy.master.Master
