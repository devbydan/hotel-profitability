#!/bin/bash

# Navigate to hdfs script dir
cd /opt/homebrew/Cellar/hadoop/3.3.4/sbin

# Start hdfs services
sh start-dfs.sh && start-yarn.sh
