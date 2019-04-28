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
$ docker build --build-arg HADOOP_VERSION="3.2.0" \
-t kirasoa/apache-hadoop-pseudo-yarn:3.2.0 \
-t kirasoa/apache-hadoop-pseudo-yarn:latest \
-f Dockerfile.pseudo-yarn .
```

## run
You might need >= 4G memory for Docker Engine.
```
$ docker run --name apache-hadoop-pseudo-yarn --rm -d \
-p 9870:9870 -p 8088:8088 \
-v ${PWD}:/workspace kirasoa/apache-hadoop-pseudo-yarn
$ docker exec -ti apache-hadoop-pseudo-yarn bash
root@5074cf069efe:/workspace# jps
1266 Jps
516 SecondaryNameNode
308 DataNode
805 ResourceManager
184 NameNode
927 NodeManager
root@5074cf069efe:/workspace# su hadoop
hadoop@5074cf069efe:/workspace$ hdfs dfs -mkdir input
hadoop@5074cf069efe:/workspace$ hdfs dfs -put /app/hadoop/etc/hadoop/*.xml input
hadoop@5074cf069efe:/workspace$ hadoop jar /app/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.0.jar grep input output 'dfs[a-z.]+'
hadoop@5074cf069efe:/workspace$ hdfs dfs -cat output/*
1	dfsadmin
1	dfs.replication
```
