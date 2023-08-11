# Original command: g++ src/*.cpp -std=c++17 -Iinclude -Llib -framework CoreVideo -framework IOKit -framework Cocoa -framework GLUT -framework OpenGL lib/libraylib.a -o bin/build_osx && ./bin/build_osx

# Variables definition

# The C++ compiler to use
CC = g++

# Find all the .cpp files in the src directory
SRCS = $(wildcard src/*.cpp)

# Convert the .cpp file names to .o
OBJS = $(patsubst src/%.cpp, bin/%.o, $(SRCS))

# Find all the .h files in the include directory
HDRS = $(wildcard include/*.h)

# Specify where the compiler can find the header files
INCLUDE_PATHS = -Iinclude

# Specify where the compiler can find the libraries
LIBRARY_PATHS = -Llib

# Specify the frameworks to link against
FRAMEWORKS = -framework CoreVideo -framework IOKit -framework Cocoa -framework GLUT -framework OpenGL

# Specify the libraries to link against
LIBS = lib/libraylib.a

# The output binary file
OUTFILE = bin/build_osx

# The C++ standard to use
FLAGS = -std=c++17

# Default command
all: build run

# This is the rule to compile .cpp files into .o files
# It depends on the corresponding .cpp file and all headers
bin/%.o: src/%.cpp $(HDRS)
	# The command to compile .cpp file into .o file
	$(CC) -c $< -o $@ $(FLAGS) $(INCLUDE_PATHS)

# This is the rule to link all .o files into the final binary
# It depends on all .o files
build: $(OBJS)
# The command to link .o files into the binary
	$(CC) $(OBJS) $(INCLUDE_PATHS) $(LIBRARY_PATHS) $(FRAMEWORKS) $(LIBS) -o $(OUTFILE)

# This is the rule to run the program
run: 
	# The command to run the program
	./$(OUTFILE)

# This is the rule to clean up the compilation products
clean:
	# The command to delete .o files and the binary
	rm -f $(OBJS) $(OUTFILE)

# Specify that these rules do not depend on any file
.PHONY: all build run clean
