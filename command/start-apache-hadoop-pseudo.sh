#!/bin/bash

/etc/init.d/ssh start
su hadoop -c "${HADOOP_HOME}/sbin/start-dfs.sh"
su hadoop -c "${HADOOP_HOME}/bin/hdfs dfs -mkdir -p /user/hadoop"
