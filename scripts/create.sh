#!/bin/bash
############################################################################################################################
# Daniel Murphy - CS236
# Runs MapReduce with prior subroutines
# Source: https://hadoop.apache.org/docs/stable/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html
############################################################################################################################

# Create data directory to hold csv's
hdfs dfs -mkdir /data

# Put csv's into data dir
hdfs dfs -put /home/dan/Downloads/hotel-booking.csv /data
hdfs dfs -put /home/dan/Downloads/customer-reservations.csv /data

# Create a result directory to hold the output of MapReduce
hdfs dfs -mkdir /result
