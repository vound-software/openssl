@echo on
@echo Run this either from visual studio command line or uncomment and fix location of vcvarsXX.bat 
@echo to set upo env properly
@echo =====================================================
@echo  Building openssl as dynamic library
@echo  build win64
@echo =====================================================


FOR %%A IN ("%~dp0.") DO SET ROOT_FOLDER=%%~dpA

set SPATH="C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build"

git checkout OpenSSL_1_1_1
git switch -c OpenSSL_1_1_1

rmdir /s/Q %ROOT_FOLDER%\openssl-1.1.1\win64.libs 
mkdir %ROOT_FOLDER%\openssl-1.1.1\win64.libs

rmdir /s/Q %ROOT_FOLDER%\openssl-1.1.1\win32.libs 
mkdir %ROOT_FOLDER%\openssl-1.1.1\win32.libs

call %SPATH%\vcvars64.bat

perl Configure VC-WIN64A shared --prefix="%ROOT_FOLDER%\openssl-1.1.1\win64.libs" --openssldir="%ROOT_FOLDER%\openssl-1.1.1\win64.libs"

nmake clean install

@echo =====================================================
@echo  build win32
@echo ==================================================

call %SPATH%\vcvars32.bat

perl Configure VC-WIN32 shared --prefix="%ROOT_FOLDER%\openssl-1.1.1\win32.libs" --openssldir="%ROOT_FOLDER%\openssl-1.1.1\win32.libs"

nmake clean install




