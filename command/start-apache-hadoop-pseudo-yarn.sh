#!/bin/bash

/etc/init.d/ssh start
su hadoop -c "${HADOOP_HOME}/sbin/start-dfs.sh"
su hadoop -c "${HADOOP_HOME}/sbin/start-yarn.sh"
su hadoop -c "${HADOOP_HOME}/sbin/mr-jobhistory-daemon.sh --config ${HADOOP_HOME}/etc/hadoop start historyserver"

su hadoop -c "${HADOOP_HOME}/bin/hdfs dfs -mkdir -p /user/hadoop"
