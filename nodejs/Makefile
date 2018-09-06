CPP_SHARED := -DUSE_LIBUV -std=c++11 -O3 -I ../uWebSockets/src -shared -fPIC ../uWebSockets/src/Extensions.cpp ../uWebSockets/src/Group.cpp ../uWebSockets/src/Networking.cpp ../uWebSockets/src/Hub.cpp ../uWebSockets/src/Node.cpp ../uWebSockets/src/WebSocket.cpp ../uWebSockets/src/HTTPSocket.cpp ../uWebSockets/src/Socket.cpp ../uWebSockets/src/Epoll.cpp src/addon.cpp
CPP_OSX := -stdlib=libc++ -mmacosx-version-min=10.7 -undefined dynamic_lookup
OS := $(shell uname -s | tr A-Z a-z)

default:
	make targets
	make dist/uws_$(OS)_57.node
	make dist/uws_$(OS)_59.node
	make dist/uws_$(OS)_64.node
	cp README.md dist/README.md
	cp ../uWebSockets/LICENSE dist/LICENSE
	cp -r ../uWebSockets/src dist/
	cp src/addon.cpp dist/src/addon.cpp
	cp src/addon.h dist/src/addon.h
	cp src/uws.js dist/uws.js
	for f in dist/*.node; do chmod +x $$f; done
dist/uws_%_57.node:
	NODE=targets/node-v8.1.2 ABI=57 make $*
dist/uws_%_59.node:
	NODE=targets/node-v9.2.0 ABI=59 make $*
dist/uws_%_64.node:
	NODE=targets/node-v10.9.0 ABI=64 make $*
targets:
	mkdir targets
	curl https://nodejs.org/dist/v8.1.2/node-v8.1.2-headers.tar.gz | tar xz -C targets
	curl https://nodejs.org/dist/v9.2.0/node-v9.2.0-headers.tar.gz | tar xz -C targets
	curl https://nodejs.org/dist/v10.9.0/node-v10.9.0.tar.gz | tar xz -C targets
linux:
	g++ $(CPP_SHARED) -static-libstdc++ -static-libgcc -I $$NODE/include/node -I $$NODE/src -I $$NODE/deps/uv/include -I $$NODE/deps/v8/include -I $$NODE/deps/openssl/openssl/include -s -o dist/uws_linux_$$ABI.node
darwin:
	g++ $(CPP_SHARED) $(CPP_OSX) -I $$NODE/include/node -o dist/uws_darwin_$$ABI.node
.PHONY: clean
clean:
	rm -f dist/README.md
	rm -f dist/LICENSE
	rm -f dist/uws_*.node
	rm -f dist/uws.js
	rm -rf dist/src
	rm -rf targets
