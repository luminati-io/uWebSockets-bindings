set vspath="%VS140COMNTOOLS%..\"
if defined GYP_MSVS_OVERRIDE_PATH (
  set vspath=%GYP_MSVS_OVERRIDE_PATH%
)

call "%vspath%..\vc\vcvarsall.bat" amd64

set v57=v8.1.2
set v59=v9.2.0
set v64=v10.9.0

if not exist targets (
mkdir targets
curl https://nodejs.org/dist/%v57%/node-%v57%-headers.tar.gz | tar xz -C targets
curl https://nodejs.org/dist/%v57%/win-x64/node.lib > targets/node-%v57%/node.lib
curl https://nodejs.org/dist/%v59%/node-%v59%-headers.tar.gz | tar xz -C targets
curl https://nodejs.org/dist/%v59%/win-x64/node.lib > targets/node-%v59%/node.lib
curl https://nodejs.org/dist/%v64%/node-%v64%.tar.gz | tar xz -C targets
curl https://nodejs.org/dist/%v64%/win-x64/node.lib > targets/node-%v64%/node.lib
)

cp README.md dist/README.md
cp ../uWebSockets/LICENSE dist/LICENSE
cp -r ../uWebSockets/src dist/
cp src/addon.cpp dist/src/addon.cpp
cp src/addon.h dist/src/addon.h
cp src/uws.js dist/uws.js

cl /I targets/node-%v57%/include/node /EHsc /Ox /LD /Fedist/uws_win32_57.node dist/src/*.cpp targets/node-%v57%/node.lib
cl /I targets/node-%v59%/include/node /EHsc /Ox /LD /Fedist/uws_win32_59.node dist/src/*.cpp targets/node-%v59%/node.lib
cl /I targets/node-%v64%/src /I targets/node-%v64%/deps/uv/include /I targets/node-%v64%/deps/v8/include /I targets/node-%v64%/deps/openssl/openssl/include /I targets/node-%v64%/deps/zlib /EHsc /Ox /LD /Fedist/uws_win32_64.node dist/src/*.cpp targets/node-%v64%/node.lib

rm *.obj
rm dist/*.exp
rm dist/*.lib
