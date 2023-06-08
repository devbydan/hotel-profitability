#!/bin/bash
############################################################################################################################
# Daniel Murphy - CS236
# Runs MapReduce with prior subroutines
# Source: https://hadoop.apache.org/docs/stable/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html
############################################################################################################################

# Compile & create .jar file
hadoop com.sun.tools.javac.Main MaxMonthlyProfits.java
jar cf mmp.jar MaxMonthlyProfits*.class
# ----------------------------------------------------

# Runs MapReduce application instance with specified class name
hadoop jar mmp.jar MaxMonthlyProfits /data /result
# -------------------------------------------------
