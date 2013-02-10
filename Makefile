# Adds JUnit and source / compile directories to java path
CLASSPATH=/usr/share/java/junit4.jar:src:bin

# javac flags
JC_FLAGS= -g -cp $(CLASSPATH) -d bin

# javadoc flags
JD_FLAGS= -d doc

#Gathers up .java files
SOURCES := $(shell find src -name "*.java")
# Generates .class file names while preserving subdirectories
CLASSES := $(patsubst %.java, %.class, $(patsubst src/%, bin/%, $(SOURCES)))

# Gathers up unit test files
TEST_FILES :=  $(filter %Test.class, $(CLASSES))
# Class names for unit tests
TESTS := $(subst /,., $(patsubst bin/%.class, %, $(TEST_FILES)))

# Fetches the class that the main function is located in
MAIN_FILE := $(shell grep -l "public static void main" $(SOURCES))
MAIN_CLASS := $(subst /,.,$(patsubst src/%.java,%, $(MAIN_FILE)))

# Default make target
default: tests

# Compile a .class file from a .java file
bin/%.class: src/%.java
	@mkdir -p bin
	javac $(JC_FLAGS) $<

# Compile all .java files to .class
.PHONY:
classes: $(CLASSES)

# Run unit tests
.PHONY:
tests: $(CLASSES)
	@echo "================"
	@echo "Running unit tests..."
	@echo "================"
	@for test in $(TESTS); do \
		echo "Testing $$test...";\
		java -cp $(CLASSPATH) org.junit.runner.JUnitCore $$test;\
	done

# Run main function
.PHONY:
main: $(CLASSES)
	@echo "Running $(MAIN_CLASS) ..."
	@java -cp $(CLASSPATH) $(MAIN_CLASS)

# Generate documentation
.PHONY:
docs:
	@mkdir -p doc
	@echo "Generating documentation..."
	@javadoc $(JD_FLAGS) $(SOURCES)
	@echo "Done generating documentation."

# Generate ctags file
TAGS: $(SOURCES)
	@echo "Generating TAGS file."
	@find . -name *.java -print0 | xargs -0 etags

# Cleanup
clean:
	rm -rf bin/*
	rm -rf doc/*
	rm -rf TAGS
