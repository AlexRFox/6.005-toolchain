#! /bin/sh

export CLASSPATH=/usr/share/java/junit4.jar:${HOME}/s12/005/ps4/bin
JFLAGS=-g

mkdir -p ../bin

DIRS=`find . -type d -print | sed 's#\./##g' | grep -v ^\\\.`
for d in ${DIRS}
do
    echo $d/*.java
    javac ${JFLAGS} $d/*.java -d ../bin
done
