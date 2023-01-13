#!/bin/bash
local FOLDER="/home/project"
local JAR="project.jar"
local NAME="project"
cd $FOLDER;
git fetch;
if [ $(git rev-parse HEAD) != $(git rev-parse @{u}) ]; then
        echo "Updating branch";
        git pull --no-edit;
	mvn clean install;
	sudo kill -9 $(jps | grep $NAME | awk '{print $1}');
	nohup java -jar ./target/$JAR;
else
        echo "No updates available";
	if [ -z $(jps | grep  $NAME) ]; then
		echo "No application running. Starting application"
		nohup java -jar ./target/$JAR
	fi
fi
