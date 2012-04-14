include ../Makefile.inc

all:
	compile.sh
	make tags
	checktodo

check:
	javac ${JFLAGS} -Xlint:unchecked minesweeper/*.java -d ../bin
	javac ${JFLAGS} -Xlint:unchecked minesweeper/server/*.java -d ../bin

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
	rm -f minesweeper/*~
	rm -f minesweeper/server/*~
	rm -f TAGS
