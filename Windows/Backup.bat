
@REM #!/bin/bash

@REM # Script Name:                  Windows Batch Scripting
@REM # Author:                       Raphael Chookagian
@REM # Date of latest revision:      04/25/2023
@REM # Purpose:                      Create a bat/batch file to backup users folder/files and set a task to do it every night





@echo off
ROBOCOPY C:\Users\j.thompson\Desktop\My Project Files C:\Users\j.thompson\Desktop\My Project Files /LOG:backuplog.txt /MIR
Shutdown -s -t 30
