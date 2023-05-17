#!/bin/bash

# Navigate to hdfs script dir
cd /opt/homebrew/Cellar/hadoop/3.3.4/sbin

# Stop hdfs services
sh stop-dfs.sh && stop-yarn.sh


