REM going to the caffe root
CD ../../
SET TOOLS=Build/x64/Release
"%TOOLS%/caffe.exe" train --solver=examples/mnist/mnist_autoencoder_solver_adadelta.prototxt
