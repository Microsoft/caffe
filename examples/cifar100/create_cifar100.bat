ECHO OFF
REM This script converts the cifar data into leveldb format.
SET currentDirectory=%~dp0
SET ROOT=%currentDirectory:~0,-19%
SET EXAMPLE=%ROOT%\examples\cifar100
SET DATA=%ROOT%\data\cifar100
SET BUILD=%ROOT%\Build\x64\Release
SET RM="%ROOT%\tools\3rdparty\bin\rm.exe"
SET DBTYPE=leveldb

ECHO "Creating %DBTYPE%..."

%rm% -rf %EXAMPLE%\cifar100_train_%DBTYPE% %EXAMPLE%\cifar100_test_%DBTYPE%

"%BUILD%\convert_cifar100_data.exe" %DATA% %EXAMPLE% %DBTYPE%

ECHO "Computing image mean..."

"%BUILD%\compute_image_mean.exe" -backend=%DBTYPE% %EXAMPLE%\cifar100_train_%DBTYPE% %EXAMPLE%\mean.binaryproto

ECHO "Done."
PAUSE