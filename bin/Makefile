PREFIX ?= /usr/local

all: clean build

clean:
	find -maxdepth 1 -lname '*' -exec rm \{} \;

build:
	docker run -it --rm mve ls -1 bin | dos2unix | parallel --gnu ln -sf mve-docker {}

install:
	find -maxdepth 1 -lname '*' -exec install \{} ${PREFIX}/bin/\{} \;

uninstall:
	find -maxdepth 1 -lname '*' -exec rm ${PREFIX}/bin/\{} \;

.PHONY: all clean build install uninstall
