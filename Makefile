os = $(shell uname -s)
machine = $(shell uname -m)
build = $(os)_$(machine)
srcs = main.cpp
objs = $(patsubst %.cpp,$(build)/%.o,$(srcs))
target = polly

cflags= -g -I /usr/local/include -Wl,-L /usr/lib -lfltk -std=c++11
ldflags = -O3 -g -msse2 -L/usr/local/lib -Wl,-L /usr/lib -l aws-cpp-sdk-polly -l aws-cpp-sdk-core -l aws-cpp-sdk-text-to-speech

all: $(build) $(target)

$(target): $(objs)
	g++ -o $@ $^ $(cflags) $(ldflags) 

$(objs): $(build)/%.o : %.cpp
	g++ -c $< $(cflags) -o $@

$(build): 
	mkdir $(build)

clean:
	rm -f $(objs) $(target)
