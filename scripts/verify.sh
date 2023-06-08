#!/bin/bash
############################################################################################################################
# Daniel Murphy - CS236
# Runs MapReduce with prior subroutines
# Source: https://hadoop.apache.org/docs/stable/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html
############################################################################################################################

# Navigate to src dir to run class
#cd  ../src/
# --------------------------------

# Enforce prerequisites
hdfs dfs -rm -r /result
export JAVA_HOME=/usr/java/default
export PATH=${JAVA_HOME}/bin:${PATH}
export HADOOP_CLASSPATH=/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar
# ------------------------------------------------