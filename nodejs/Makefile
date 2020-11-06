CPP_SHARED := -DUSE_LIBUV -std=c++1y -O3 -I ../uWebSockets/src -shared -fPIC ../uWebSockets/src/Extensions.cpp ../uWebSockets/src/Group.cpp ../uWebSockets/src/Networking.cpp ../uWebSockets/src/Hub.cpp ../uWebSockets/src/Node.cpp ../uWebSockets/src/WebSocket.cpp ../uWebSockets/src/HTTPSocket.cpp ../uWebSockets/src/Socket.cpp ../uWebSockets/src/Epoll.cpp src/addon.cpp
CPP_OSX := -stdlib=libc++ -mmacosx-version-min=10.7 -undefined dynamic_lookup
OS := $(shell uname -s | tr A-Z a-z)
src := src/addon.cpp src/addon.h
VER_57 := 8.1.2
VER_59 := 9.2.0
VER_64 := 10.16.3-src
VER_72 := 12.15.0-src
VER_72_2 := 12.18.2-src
VER_83 := 14.15.0-src
NODE_MAJ_VER := $(shell node -v | sed -e 's/v\([0-9]*\)\..*/\1/')
NODE_MIN_VER := $(shell node -v | sed -e 's/v[0-9]*\.\([0-9]*\)\..*/\1/')
NODE_ABI_VER := $(shell if [ "${NODE_MAJ_VER}" -eq "14" ]; then \
	echo "83"; \
    elif [ "${NODE_MAJ_VER}" -eq "12" ]; then \
        if [ "${NODE_MIN_VER}" -eq "16" ]; then \
	    echo "72"; \
	else \
            echo "72_2"; \
	fi \
    elif [ "${NODE_MAJ_VER}" -eq "10" ]; then \
        echo "64"; \
    elif [ "${NODE_MAJ_VER}" -eq "9" ]; then \
        echo "59"; \
    else \
        echo "57"; \
    fi )

default:
	mkdir -p targets
	make dist/uws_$(OS)_$(NODE_ABI_VER).node
	cp README.md dist/README.md
	cp ../uWebSockets/LICENSE dist/LICENSE
	cp -r ../uWebSockets/src dist/
	cp src/addon.cpp dist/src/addon.cpp
	cp src/addon.h dist/src/addon.h
	cp src/uws.js dist/uws.js
	for f in dist/*.node; do chmod +x $$f; done
targets/node-v%-src:
	curl https://nodejs.org/dist/v$*/node-v$*.tar.gz | tar xz -C targets
	mv targets/node-v$* targets/node-v$*-src
targets/node-v%:
	curl https://nodejs.org/dist/v$*/node-v$*-headers.tar.gz | tar xz -C targets
dist/uws_%_57.node: $(src)
	make targets/node-v$(VER_57)
	NODE=targets/node-v$(VER_57) ABI=57 make $*
dist/uws_%_59.node: $(src)
	make targets/node-v$(VER_59)
	NODE=targets/node-v$(VER_59) ABI=59 make $*
dist/uws_%_64.node: $(src)
	make targets/node-v$(VER_64)
	NODE=targets/node-v$(VER_64) ABI=64 make $*
dist/uws_%_72.node: $(src)
	make targets/node-v$(VER_72)
	NODE=targets/node-v$(VER_72) ABI=72 make $*
dist/uws_%_72_2.node: $(src)
	make targets/node-v$(VER_72_2)
	NODE=targets/node-v$(VER_72_2) ABI=72 make $*
dist/uws_%_83.node: $(src)
	make targets/node-v$(VER_83)
	NODE=targets/node-v$(VER_83) ABI=83 make $*
linux:
	g++ $(CPP_SHARED) -static-libstdc++ -static-libgcc -I $$NODE/include/node -I $$NODE/src -I $$NODE/deps/uv/include -I $$NODE/deps/v8/include -I $$NODE/deps/openssl/openssl/include -I $$NODE/deps/zlib -s -o dist/uws_linux_$$ABI.node
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
