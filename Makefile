# -*- Makefile -*-

CXX=clang++
CXXFLAGS=-std=c++11 $(CFLAGS) $(LDSOFLAGS) -Wall -Wextra
PLPATHS=-p library=prolog -p foreign="$(PACKSODIR)"

.PHONY: all check clean distclean install

all: $(PACKSODIR)/rocksdb.$(SOEXT)

$(PACKSODIR)/rocksdb.$(SOEXT): cpp/rocksdb.cpp
	mkdir -p $(PACKSODIR)
	$(CXX) $(CXXFLAGS) -shared -o $@ cpp/rocksdb.cpp -lrocksdb $(SWISOLIB)

check::
	swipl $(PLPATHS) -g test_rocksdb,halt -t 'halt(1)' test/test_rocksdb.pl

clean:
	$(RM) *~

distclean: clean
	$(RM) $(PACKSODIR)/rocksdb.$(SOEXT) -r lib/

install::
