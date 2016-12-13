REM going to the caffe root
CD ../../
SET TOOLS=Build/x64/Release
"%TOOLS%/caffe.exe" train --solver=examples/siamese/mnist_siamese_solver.prototxt

pause