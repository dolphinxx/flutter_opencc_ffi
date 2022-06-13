# [OpenCC](https://github.com/BYVoid/OpenCC) shared library for windows.

Build OpenCC shared library for windows:

```bash
# configure the environment
"C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" x64

cmake -S . -B .\build -DCMAKE_BUILD_TYPE=Release -G "Visual Studio 16 2019"

cmake --build .\build --config Release
```