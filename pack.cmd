@echo off
setlocal

::   Loads file paths and set source and output directories
(
    set /p "projectpath="
)<projectpaths.txt
set "source_dir=%projectpath%\Mod"
set "output_dir=%projectpath%\JARs"

::   Loads version of the mod from fabric.mod.json and put it into a file name
cd /D "%projectpath%\Mod"
(
    set /p "l1="
    set /p "l2="
    set /p "l3="
    set /p "version_unformatted="
)<fabric.mod.json
set "version=%version_unformatted:~15,12%"
set "jar_name=Create-Bits&Bops_%version%.jar"

::   checks if version already exists
if exist "%output_dir%\%jar_name%" goto already_exists

::   Packs up the files
pushd "%source_dir%"
jar cf "%output_dir%\%jar_name%" data fabric.mod.json pack.mcmeta pack.png
popd

::   Shows where the .jar file was created or where already is
:finish
echo.
echo   JAR file created at: "%output_dir%\%jar_name%"
pause >nul
endlocal
exit /b
:already_exists
echo.
echo   JAR file "%jar_name%" already exists in "%output_dir%\".
pause >nul
endlocal
exit /b