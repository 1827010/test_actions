TARGET = app

SRCS = $(shell find ./src      -type f -name *.cpp)
HEADS = $(shell find ./include -type f -name *.h)
OBJS = $(SRCS:.cpp=.o)
DEPS = Makefile.depend

INCLUDES = -I./include
CXXFLAGS = -02 -wall $(INCLUDES)
LDFLAGS = -lm


all: $(TARGET)

$(TARGET): $(OBJS) $(HEADS)
 $(CXX) $(LDFAGS) -o $@ $(OBJS)
 
 run: all
 @./$(TARGET)
 
 .PHONY: depend clean
 depend:
   $(CXX) $(INCLUDES) -MM $(SRCS) > $(DEPS)
   @sed -i -E "s/^(.+?).0: ([^ ]+?)\1/2\1.o: \2\1/g" $(DEPS)
   
   clean:
   $(RM) $(OBJS) $(TARGET)
   
   -include $(DEPS)
