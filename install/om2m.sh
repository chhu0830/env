#!/bin/sh

git clone https://git.eclipse.org/r/om2m/org.eclipse.om2m
sudo apt install maven

cd org.eclipse.om2m
mvn clean install
