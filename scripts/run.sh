#!/bin/bash
############################################################################################################################
# Daniel Murphy - CS236
# Runs MapReduce with prior subroutines
# Source: https://hadoop.apache.org/docs/stable/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html
############################################################################################################################

# Navigate to src dir to run class
cd  ../src/
# --------------------------------

# Enforce prerequisites
hdfs dfs -rm -r /result
export JAVA_HOME=/usr/java/default
export PATH=${JAVA_HOME}/bin:${PATH}
export HADOOP_CLASSPATH=${JAVA_HOME}/lib/tools.jar
# ------------------------------------------------

# Compile & create .jar file
hadoop com.sun.tools.javac.Main MaxMonthlyProfits.java
jar cf mmp.jar MaxMonthlyProfits*.class
# ----------------------------------------------------

# Runs MapReduce application instance with specified class name
hadoop jar mmp.jar MaxMonthlyProfits /data /result
# -------------------------------------------------
