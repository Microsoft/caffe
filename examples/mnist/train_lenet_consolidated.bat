REM going to the caffe root
CD ../../
SET TOOLS=Build/x64/Release
"%TOOLS%/caffe.exe" train --solver=examples/mnist/lenet_consolidated_solver.prototxt
