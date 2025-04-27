@echo off
setlocal

:: Customize these paths if you want
set PROTOBUF_SOURCE=C:\pkg\protobuf
set PROTOBUF_BUILD=%PROTOBUF_SOURCE%\build-vs2019-cpp20
set PROTOBUF_INSTALL=%PROTOBUF_SOURCE%\install-vs2019-cpp20

echo Building protobuf from %PROTOBUF_SOURCE%
echo Build folder: %PROTOBUF_BUILD%
echo Install folder: %PROTOBUF_INSTALL%

:: Create build directory
if not exist "%PROTOBUF_BUILD%" mkdir "%PROTOBUF_BUILD%"
cd "%PROTOBUF_BUILD%"

:: Run CMake configuration
cmake "%PROTOBUF_SOURCE%" -G "Visual Studio 16 2019" -A x64 ^
    -DCMAKE_CXX_STANDARD=20 ^
	-DCMAKE_CXX_STANDARD_REQUIRED=ON ^
	-DCMAKE_CXX_EXTENSIONS=OFF ^
    -Dprotobuf_BUILD_SHARED_LIBS=ON ^
    -Dprotobuf_BUILD_TESTS=OFF ^
    -Dprotobuf_DISABLE_PTHREADS=ON ^
    -DCMAKE_INSTALL_PREFIX=%PROTOBUF_INSTALL%

if %errorlevel% neq 0 (
    echo CMake configuration failed!
    exit /b 1
)

:: Build Release
cmake --build . --config Release
if %errorlevel% neq 0 (
    echo Release build failed!
    exit /b 1
)

:: Install Release
cmake --install . --config Release
if %errorlevel% neq 0 (
    echo Release install failed!
    exit /b 1
)

:: Build Debug
cmake --build . --config Debug
if %errorlevel% neq 0 (
    echo Debug build failed!
    exit /b 1
)

:: Install Debug
cmake --install . --config Debug
if %errorlevel% neq 0 (
    echo Debug install failed!
    exit /b 1
)

echo Protobuf build and install completed successfully!
pause
