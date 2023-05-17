# Welcome to our Hotel Profitability application 👋

> For this project, we will use MapReduce to find the *most profitable month* for hotel bookings over a period of four years. To do this, we will compute the total revenues recorded every month and arrange them in descending order. This can give us some interesting information like which months of the year show higher revenue for a particular market segment.
>
> However, the problem is that the hotel company decided to change the way they keep their data, so there are two separate datasets with different schemas (but similar information) that we need to use.The goal of this project is to find out which month was most profitable from 2015-2018 using HDFS and MapReduce. The dataset can be found [here](https://drive.google.com/drive/folders/1zTA_71IoOuGWo-xHqPGEaW25v_adcVgr?usp=sharing).

## Author

👤 **Dan Murphy; 862085212; dmurp006@ucr.edu**

* Website: [LinkedIn](https://www.linkedin.com/in/devbydan/)
* GitHub: [@devbydan](https://github.com/devbydan)

## Technologies

- Hadoop 3.3.4
- Open JDK

## Requirements

```bash
# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
# Run these two commands in your terminal to add Homebrew to your PATH
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$USER/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
```
``` bash
# Mac Xcode development/commandline tools
xcode-select –install
# NOTE: if you are running MacOS Big Sur or newer, run the 2 following commands.
sudo rm -rf /Library/Developer/CommandLineTools # Removes old cmd tools
sudo xcode-select --install # Installs updated tools for new MacOS release
```

```bash
# Installing prerequisites on Mac
brew install --cask adoptopenjdk   # or brew install openjdk@11
brew install hadoop # installs HDFS 
```

```bash
# Installing prerequisites on Ubuntu
sudo apt install openjdk-8-jdk -y
sudo apt install openssh-server openssh-client -y
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
ssh localhost
wget https://archive.apache.org/dist/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz
tar xzf hadoop-3.2.1.tar.gz
which javac # provides the path to the Java binary dir
readlink -f /usr/bin/javac # linked and assigned to $JAVA_HOME
sudo apt install maven
```

## Configuration

### MacOS: 

[Installing/Configuring Hadoop on a Mac](https://towardsdatascience.com/installing-hadoop-on-a-mac-ec01c67b003c)

### Ubuntu:

[Installing/Configuring Hadoop & Spark on Ubuntu](https://dev.to/awwsmm/installing-and-running-hadoop-and-spark-on-ubuntu-18-393h)

### Config Hadoop core files

```bash
# Navigate to Homebrew's Hadoop dir ---
cd /opt/homebrew/Cellar/hadoop/3.3.4/libexec/etc/hadoop
```

```bash
# Update hadoop-env ---
nano hadoop-env.sh
# Add this JAVA_HOME path to the hadoop environment file
export JAVA_HOME="/opt/homebrew/Cellar/openjdk@11/11.0.19"
```

```bash
# Update core-site ---
nano core-site.xml
# Use the config below
<configuration>
 <property>
  <name>fs.defaultFS</name>
  <value>hdfs://localhost:9000</value>
 </property>
</configuration>
```

```bash
# Update hdfs-site ---
nano hdfs-site.xml
# Use the config below
<configuration>
  <property>
    <name>dfs.replication</name>
    <value>1</value>
  </property>
</configuration>
```

```bash
# Update mapred-site ---
nano mapred-site.xml
# Use the config below
<configuration>
    <property>
       <name>mapreduce.framework.name</name>
       <value>yarn</value>
    </property>
    <property>
    <name>mapreduce.application.classpath</name>   
  <value>
$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/*:$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/lib/*
  </value>
    </property>
</configuration>
```

```bash
# Update yarn-site ---
nano yarn-site.xml
# Use the config below
<configuration>
  <property>
    <name>yarn.nodemanager.aux-services</name>
    <value>mapreduce_shuffle</value>
  </property>
  <property>
    <name>yarn.nodemanager.env-whitelist</name>  
   <value>
JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PREPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME
  </value>
  </property>
</configuration>
```

## Prime Workspace

### Initialize HDFS

```bash
# Initialize the Hadoop namenode before proceeding
hadoop namenode -format # may also require -force flag (e.g., hadoop namenode -format -force)

# Start HDFS services
start-all.sh

# Verify all services running
jps # should see ResourceManager, NodeManager, NameNode, SecondaryNameNode, DataNode, etc
```

### Upload CSV's

```bash
# Directories within Hadoop
hdfs dfs -mkdir /data # create data directory to hold csv files
hdfs dfs -ls / # verify creation of directories by looking at current dirs within the hadoop file system

# Populate the HDFS data directory with csv file(s)
hdfs dfs -put ~/Downloads/hotel-booking.csv /data
hdfs dfs -put ~/Downloads/customer-reservations.csv /data 
```

## Problem Breakdown
An overall description of how you chose to separate the problem into different
MapReduce jobs, with reasoning.
i. A description of each MapReduce job including:
    1. What the job does
    2. An estimate of runtime for the pass
ii. A description of how you chose to do the join(s)
iii. Code snippets

## Team Contribution
Each team member's detailed contribution.

