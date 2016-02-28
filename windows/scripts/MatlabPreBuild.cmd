set SOLUTION_DIR=%~1%
set OUTPUT_DIR=%~2%

echo MatlabPreBuild.cmd : Create output directories for matlab scripts.

if not exist "%OUTPUT_DIR%\matcaffe" mkdir "%OUTPUT_DIR%\matcaffe"
if not exist "%OUTPUT_DIR%\matcaffe\demo" mkdir "%OUTPUT_DIR%\matcaffe\demo"
if not exist "%OUTPUT_DIR%\matcaffe\hdf5creation" mkdir "%OUTPUT_DIR%\matcaffe\hdf5creation"
if not exist "%OUTPUT_DIR%\matcaffe\+caffe" mkdir "%OUTPUT_DIR%\matcaffe\+caffe"
if not exist "%OUTPUT_DIR%\matcaffe\+caffe\+test" mkdir "%OUTPUT_DIR%\matcaffe\+caffe\+test"
if not exist "%OUTPUT_DIR%\matcaffe\+caffe\private" mkdir "%OUTPUT_DIR%\matcaffe\+caffe\private"
if not exist "%OUTPUT_DIR%\matcaffe\+caffe\imagenet" mkdir "%OUTPUT_DIR%\matcaffe\+caffe\imagenet"