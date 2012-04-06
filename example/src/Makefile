include ../Makefile.inc

all:
	javac ${JFLAGS} foo/*.java -d ../bin
	javac ${JFLAGS} foo/bar/*.java -d ../bin
	javac ${JFLAGS} foo/baz/*.java -d ../bin
	make tags
	checktodo

check:
	javac ${JFLAGS} -Xlint:unchecked foo/*.java -d ../bin
	javac ${JFLAGS} -Xlint:unchecked foo/bar/*.java -d ../bin
	javac ${JFLAGS} -Xlint:unchecked foo/baz/*.java -d ../bin

test: all
	massjunit

tags:
	find . -name *.java -print0 | xargs -0 etags

# doc:
# 	echo $(CLASSPATH)
# 	javadoc -d ../doc sound player

clean:
	rm -rf ../bin/*
	rm -f *~
	rm -f foo/*~
	rm -f foo/bar/*~
	rm -f foo/baz/*~
	rm -f TAGS
