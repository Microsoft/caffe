set SOLUTION_DIR=%~1%
set OUTPUT_DIR=%~2%

echo MatlabPostBuild.cmd : copy matlab generated scripts to output.

copy /y "%SOLUTION_DIR%..\matlab\+caffe\*.m" "%OUTPUT_DIR%matcaffe\+caffe"
copy /y "%SOLUTION_DIR%..\matlab\+caffe\+test\*.m" "%OUTPUT_DIR%matcaffe\+caffe\+test"
copy /y "%SOLUTION_DIR%..\matlab\+caffe\private\*.m" "%OUTPUT_DIR%matcaffe\+caffe\private"
copy /y "%SOLUTION_DIR%..\matlab\+caffe\imagenet\*.mat" "%OUTPUT_DIR%matcaffe\+caffe\imagenet"
copy /y "%SOLUTION_DIR%..\matlab\demo\*.m" "%OUTPUT_DIR%matcaffe\demo"
copy /y "%SOLUTION_DIR%..\matlab\hdf5creation\*.m" "%OUTPUT_DIR%matcaffe\hdf5creation"
move /y "%OUTPUT_DIR%caffe_.*" "%OUTPUT_DIR%matcaffe\+caffe\private"
copy /y "%OUTPUT_DIR%*.dll" "%OUTPUT_DIR%matcaffe\+caffe\private"