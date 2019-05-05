Apache Hadoop Dockerfiles for a Single Node Cluster

# [standalone](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html#Standalone_Operation)

## build
```
$ docker build --build-arg HADOOP_VERSION="3.2.0" \
-t kirasoa/apache-hadoop-standalone:3.2.0 \
-t kirasoa/apache-hadoop-standalone:latest \
-f Dockerfile.standalone .
```

## run
```
$ docker run --rm -ti kirasoa/apache-hadoop-standalone:latest -v ${PWD}:/workspace bash
```

# [pseudo-distributed](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html#Pseudo-Distributed_Operation)

## build
```
$ docker build --build-arg HADOOP_VERSION="3.2.0" \
-t kirasoa/apache-hadoop-pseudo:3.2.0 \
-t kirasoa/apache-hadoop-pseudo:latest \
-f Dockerfile.pseudo .
```

## run
```
$ docker run --name apache-hadoop-pseudo --rm -d \
-p 9870:9870 \
-v ${PWD}:/workspace kirasoa/apache-hadoop-pseudo
$ docker exec -ti apache-hadoop-pseudo bash
root@7907e460ebac:/workspace# jps
183 NameNode
489 SecondaryNameNode
283 DataNode
507 Jps
root@7907e460ebac:/workspace# su hadoop
hadoop@7907e460ebac:/workspace$ hdfs dfs -mkdir input
hadoop@7907e460ebac:/workspace$ hdfs dfs -put /app/hadoop/etc/hadoop/*.xml input
hadoop@7907e460ebac:/workspace$ hadoop jar /app/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.0.jar grep input output 'dfs[a-z.]+'
hadoop@7907e460ebac:/workspace$ hdfs dfs -cat output/*
1       dfsadmin
1       dfs.replication
```

# [pseudo-distributed-yarn](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html#YARN_on_a_Single_Node)

## build
```
$ docker build --build-arg HADOOP_VERSION="2.9.2" \
-t kirasoa/apache-hadoop-pseudo-yarn:2.9.2 \
-f Dockerfile.pseudo-yarn .
```

## run
You might need >= 4G memory for Docker Engine.
```
$ docker run -h docker-host --name apache-hadoop-pseudo-yarn --rm -d \
-p 50070:50070 -p 9000:9000 \
-p 50010:50010 -p 50075:50075 -p 50020:50020 \
-p 8031:8031 -p 8030:8030 -p 8032:8032 -p 8088:8088 -p 8033:8033 \
-p 8040:8040 -p 13562:13562 -p 8042:8042 \
-p 10020:10020 -p 19888:19888 \
-p 50100-50105:50100-50105 \
-v ${PWD}:/workspace kirasoa/apache-hadoop-pseudo-yarn:2.9.2
$ docker exec -ti apache-hadoop-pseudo-yarn bash
root@docker-host:/workspace# jps
947 JobHistoryServer
275 DataNode
710 NodeManager
1783 Jps
123 NameNode
444 SecondaryNameNode
607 ResourceManager
root@docker-host:/workspace# su hadoop
hadoop@docker-host:/workspace$ hdfs dfs -mkdir input
hadoop@docker-host:/workspace$ hdfs dfs -put /app/hadoop/etc/hadoop/*.xml input
hadoop@docker-host:/workspace$ hadoop jar /app/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar grep input output 'dfs[a-z.]+'
hadoop@docker-host:/workspace$ hdfs dfs -cat output/*
1	dfsadmin
1	dfs.replication
```
