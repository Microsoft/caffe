cd ../../
set EXAMPLE=examples/mnist
set DATA=data/mnist
set BUILD=BUILD/x64/Release
set BACKEND=lmdb
echo "Creating %BACKEND%..."
rd /s /q "%EXAMPLE%/mnist_train_%BACKEND%"

rd /s /q "%EXAMPLE%/mnist_test_%BACKEND%"


"%BUILD%/convert_mnist_data.exe" %DATA%/train-images-idx3-ubyte %DATA%/train-labels-idx1-ubyte %EXAMPLE%/mnist_train_%BACKEND% --backend=%BACKEND%
"%BUILD%/convert_mnist_data.exe" %DATA%/t10k-images-idx3-ubyte %DATA%/t10k-labels-idx1-ubyte %EXAMPLE%/mnist_test_%BACKEND% --backend=%BACKEND%


echo "Done."


pause