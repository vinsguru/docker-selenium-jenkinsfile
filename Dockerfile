FROM openjdk:8-jre-slim

# Add the project jar & copy dependencies
ADD  target/container-test.jar /usr/share/tag/container-test.jar
ADD  target/libs /usr/share/tag/libs

# Add the suite xmls
ADD suite/order-module.xml /usr/share/tag/order-module.xml
ADD suite/search-module.xml /usr/share/tag/search-module.xml

# Command line to execute the test
# Expects below ennvironment variables
# BROWSER = chrome / firefox
# MODULE  = order-module / search-module
# SELENIUM_HUB = selenium hub hostname / ipaddress

WORKDIR /usr/share/tag

ENTRYPOINT java -cp container-test.jar:libs/* -DseleniumHubHost=$SELENIUM_HUB -Dbrowser=$BROWSER org.testng.TestNG $MODULE
