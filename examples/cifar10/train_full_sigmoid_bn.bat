REM going to the caffe root
CD ../../
SET TOOLS=Build/x64/Release
"%TOOLS%/caffe.exe" train --solver=examples/cifar10/cifar10_full_sigmoid_solver_bn.prototxt

