# Makefile template

## BEGIN Project specific variables ##

# Compiler and options #
WARN=-Wall -Wpedantic
OPT=#-O2 # no opts for now
STD=-std=c99 -D_POSIX_C_SOURCE=200809L
CFLAGS=$(WARN) $(OPT) $(STD) -g

# project sources #
EXECNAME=bugworld
INCDIR=-I include
SRCDIR=src
SRCEXT=c
OBJEXT=o
BUILDDIR=build
BINDIR=bin

# test sources #
TESTDIR=test
TESTSRC=bugworld_test
TESTOBJ=$(BUILDDIR)/$(TESTSRC).$(OBJEXT)
TESTEXEC=$(BINDIR)/$(TESTSRC)
TESTDEPEND=$(OBJECTSNOMAIN)

# library information #
LMATH=-lm
LNCURSES=-lncurses
#LRT=-lrt
LDFLAGS=$(LNCURSES) $(LMATH) #$(LRT)

# misc #
RM=rm -f
PTHREAD=-pthread # use -pthread instead of -lpthread for proper macros

## END Project specific variables ##

TARGET=$(BINDIR)/$(EXECNAME)
SOURCES=$(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS=$(patsubst $(SRCDIR)/%, $(BUILDDIR)/%, $(SOURCES:.$(SRCEXT)=.o))
OBJECTSNOMAIN=$(filter-out $(BUILDDIR)/main.$(OBJEXT), $(OBJECTS))

$(TARGET): $(OBJECTS)
	@echo "Linking..."
	@mkdir -p $(BINDIR)
	@$(CC) $^ -o $(TARGET) $(LIB) $(LDFLAGS) $(PTHREAD)

$(BUILDDIR)/%.o: $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(BUILDDIR)
	@echo "Compiling ($(CC)) $<..."
	@$(CC) $(CFLAGS) $(PTHREAD) $(INCDIR) -c -o $@ $<

.PHONY: test all clean run runtest
test: $(TARGET)
	@echo "Building tests..."
	@$(CC) $(CFLAGS) $(PTHREAD) -c -o $(TESTOBJ) $(TESTDIR)/$(TESTSRC).$(SRCEXT) $(INCDIR)
	@$(CC) $(CFLAGS) $(PTHREAD) -o $(TESTEXEC) $(TESTDIR)/$(TESTSRC).$(SRCEXT) $(TESTDEPEND) $(INCDIR) $(LDFLAGS)

all: clean $(TARGET) test
	@echo "Done!"

clean:
	@echo "Cleaning...";
	@$(RM) -r $(BUILDDIR) $(BINDIR)

run:
	@echo "Running..."
	@./$(TARGET)

runtest:
	@echo "Running tests..."
	@./$(TESTEXEC)

