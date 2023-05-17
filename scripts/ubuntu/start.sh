#!/bin/bash

# Navigate to hdfs script dir
cd ~/hadoop/sbin

# Start hdfs services
./start-dfs.sh && ./start-yarn.sh

