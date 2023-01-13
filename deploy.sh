#!/bin/bash
cd /home/twohearts/two-hearts;
git fetch;
if [ $(git rev-parse HEAD) != $(git rev-parse @{u}) ]; then
        echo "Updating branch";
        git pull --no-edit;
	mvn clean install;
	sudo kill -9 $(jps | grep twohearts | awk '{print $1}');
	nohup java -jar ./target/twohearts.jar;
else
        echo "No updates available";
	if [ -z $(jps | grep twohearts) ]; then
		echo "No application running. Starting application"
		nohup java -jar ./target/twohearts.jar
	fi
fi
