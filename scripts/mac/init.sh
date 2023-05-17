#!/bin/bash

# Navigate to hdfs script dir
cd /opt/homebrew/Cellar/hadoop/3.3.4/sbin

# Initialize namenode, forcibly format
hadoop namenode -format -force
