@ECHO OFF
IF NOT "%~f0" == "~f0" GOTO :WinNT
@"ruby.exe" "C:/Study Material/Ruby in rails/u11_ror/joshi_nirmal/project/code/librarian/rcov/ruby/1.8/bin/flay" %1 %2 %3 %4 %5 %6 %7 %8 %9
GOTO :EOF
:WinNT
@"ruby.exe" "%~dpn0" %*