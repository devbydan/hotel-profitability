#!/bin/bash

# Navigate to hdfs script dir
cd ~/hadoop/sbin

# Start hdfs services
./stop-dfs.sh && ./stop-yarn.sh

