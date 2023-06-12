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
- Open JDK 8

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

<!-- Apache Hadoop Tutorial -->

  <property>
      <name>mapreduce.application.classpath</name>
      <value>$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/*:$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/l>
  </property>

  <property>
    <name>yarn.app.mapreduce.am.env</name>
    <value>HADOOP_MAPRED_HOME=/home/dan/hadoop</value>
  </property>

  <property>
    <name>mapreduce.map.env</name>
    <value>HADOOP_MAPRED_HOME=/home/dan/hadoop</value>
  </property>

  <property>
    <name>mapreduce.reduce.env</name>
    <value>HADOOP_MAPRED_HOME=/home/dan/hadoop</value>
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
$ hadoop namenode -format # may also require -force flag (e.g., hadoop namenode -format -force)

# Start HDFS services
$ start-all.sh

# Verify all services running
$ jps # should see ResourceManager, NodeManager, NameNode, SecondaryNameNode, DataNode, etc
```

### Upload CSV's

```bash
# Directories within Hadoop
$ hdfs dfs -mkdir /data # create data directory to hold csv files
$ hdfs dfs -ls / # verify creation of directories by looking at current dirs within the hadoop file system

# Populate the HDFS data directory with csv file(s)
$ hdfs dfs -put ~/Downloads/hotel-booking.csv /data
$ hdfs dfs -put ~/Downloads/customer-reservations.csv /data 
```

### Initialize Project Workspace
```bash
# Starts HDFS services
$ sh start.sh
```
```bash
# Sets path variables for project dir
$ sh prime-env.sh # ~/IdeaProjects/MaxProfit
```
```bash
# Compiles java class, creates jar, runs MapReduce application
$ sh run.sh # also ensures /result dir is removed for smooth operation
```
```bash
# Grabs the output from the /result dir
$ sh get-result.sh # part-r-00000
```
[Optional]
```bash
# Removes /result dir and deletes old jar prior to re-running
$ sh reset-hdfs-jar.sh # ensures updates are made and old jar is not used
```
Once you are done, you can run the stop script to stop all services.
```bash
$ sh stop.sh
```
If you shutdown or hibernate your computer while the services are running, the namenode may operate in safemode, which you will have to remove by using:
```bash
$ hdfs dfsadmin -safemode -leave # forcibly leaves safemode
```

## Code Breakdown

### MaxProfitClass
The MaxProfit parent class configures and runs a MapReduce job to calculate the hotel's revenue based on the two given .csv files:
- hotel-booking.csv
- customer-reservations.csv
This class yields the total revenue for all Month-Year groups. A Python script later sorts these post MapReduce processing.

### MaxProfitMapper
The MaxProfitMapper class implements the former half of a MapReduce job to process each input record and emit the key-value pair which is represented by:
- (KEY) Month-Year
- (VALUE) Total Cost
There are variables that are held within this Map class to hold all important data calculated by helper methods. 

The driving method of this class is map() which receives the two given .csv files for both hotel bookings and customer reservation data. In order to achieve the main goal of this project, the key is set to the Month-Year as this is what we want to associate the hotel's total revenue with (to find the most profitable month). All data is parsed through the comma delimiter, native to the .csv file structure.

### MaxProfitReducer
The MaxProfitReducer class implements the latter half of a MapReduce job to aggregate all individual revenue values associated with each Month-Year key respectively.

### Main
The main test harness initializes the mapper, combiner and reducer classes for the MapReduce jobs. The mapper maps the key-value pairs; the combiner locally reduces congestion by preprocessing the result data prior to feeding it into the reducer class; the reducer class reduces the set of intermediate key-value pairs overall.

## Obstacles & Contingencies
### HDFS Installation
As this was my first time *actually* using Hadoop standalone, I encountered a wide variety of strange issues. Prior to this, I have used Apache Spark where I knew very little about its use and legitimate configuration, so I assumed that it was necessary create a foundation of Hadoop before using Spark. Due to this, there was minimal configuration needed for Hadoop specifically and all of the other configurations were highly dependent on Spark and utilizing Maven. It is crucial to provide the correct, absolute paths to the correct locations when initializing the MapReduce environment. If not, some services will not be able to run correctly or even at all! For example, some services may not have permissions, priority or even know what they are supposed to start service-wise when called upon if not configured correctly.

### MapReduce vs Spark
Regarding the coding differences between MapReduce and Spark is that my previous experience relies heavily on DataFrames or raw SQL queries whereas this project tackled Java code much different syntactically. Because of this, I originally tested my code by minimizing what I had to use code-wise in Java to ensure my map and reduce ideas were fully functional. To do this, I cleaned and merged both of the CSV files into one file and only reduced the data down to two columns: Month-Year and Cost. Once my map and reduce implementations worked, I began to increase the functionality within MapReduce and minimize what had to be done through a Python script. As of now, the MapReduce application performs as intended and yields the appropriate key-value pairs (Month-Year and Cost). Post MapReduce, a Python script runs and sorts the costs in ascending order, providing the result for the most profitable month.



## Team Contribution
Daniel Murphy has designed, debugged, documented and implemented all functionality for this project.

