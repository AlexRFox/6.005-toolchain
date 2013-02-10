CLASSPATH=/usr/share/java/junit4.jar:src:bin
JC_FLAGS= -g -cp $(CLASSPATH) -d bin
JD_FLAGS= -d doc

SOURCES := $(shell find src -name "*.java")
CLASSES := $(patsubst %.java, %.class, $(patsubst src/%, bin/%, $(SOURCES)))
TEST_FILES :=  $(filter %Test.class, $(CLASSES))
TESTS := $(subst /,., $(patsubst bin/%.class, %, $(TEST_FILES)))

default: tests

bin/%.class: src/%.java
	javac $(JC_FLAGS) $<

doc/%.html: src/%.java
	javadoc $(JD_FLAGS) $<

.PHONY:
classes: $(CLASSES)

.PHONY:
tests: $(CLASSES)
	@echo "================"
	@echo "Running unit tests..."
	@echo "================"
	@for test in $(TESTS); do \
		echo "Testing $$test...";\
		java -cp $(CLASSPATH) org.junit.runner.JUnitCore $$test;\
	done

.PHONY:
docs:
	@echo "Generating documentation..."
	@javadoc -d doc $(SOURCES)
	@echo "Done generating documentation."

TAGS: $(SOURCES)
	@echo "Generating TAGS file."
	@find . -name *.java -print0 | xargs -0 etags

clean:
	rm -rf bin/*
	rm -rf doc/*
	rm -rf TAGS
