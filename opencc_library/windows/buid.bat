@echo off

cd /D "%~dp0"

echo "Setup MSVC env..."
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" x64

if exist .\build rmdir .\build /s /q
mkdir build

echo "Building..."
cmake -S . -B .\build -DCMAKE_BUILD_TYPE=Release -G "Visual Studio 16 2019"

cmake --build .\build --config Release

echo "Press any key to exit . . ."
pause>nul