REM go to the caffe root
cd ../../
set BIN=build/x64/Release
"%BIN%/caffe.exe" train --solver=examples/cifar100/cifar100_quick_solver.prototxt
pause
