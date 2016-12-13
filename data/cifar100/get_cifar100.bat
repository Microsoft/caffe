ECHO OFF
REM This scripts downloads the CIFAR100 (binary version) data and then unzips it.
REM After executing this script, and files being extracted, you need to head to 
REM examples/cifar100 and then execute create_cifar100   
SET currentDirectory=%~dp0
SET ROOT=%currentDirectory:~0,-15%
SET WGET="%ROOT%\tools\3rdparty\bin\wget.exe"
SET TAR="%ROOT%\tools\3rdparty\bin\7za.exe"
SET RM="%ROOT%\tools\3rdparty\bin\rm.exe"

 if not exist "%currentDirectory%cifar-100-binary.tar.gz" (
ECHO "Downloading..."
%WGET% --no-check-certificate https://www.cs.toronto.edu/~kriz/cifar-100-binary.tar.gz
) else (
ECHO File exits, skipping download...
)

ECHO "Unzipping..."
%TAR% e cifar-100-binary.tar.gz && %RM% -f cifar-100-binary.tar.gz
%TAR% e cifar-100-binary.tar && %RM% -f cifar-100-binary.tar && %RM% -r cifar-100-binary

REM Creation is split out because leveldb sometimes causes segfault
REM and needs to be re-created.

ECHO "Done."
pause
