REM going to the caffe root
CD ../../
SET TOOLS=Build/x64/Release
"%TOOLS%/caffe.exe" train --solver=examples/mnist/lenet_solver_adam.prototxt
