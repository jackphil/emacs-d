; <COMPILER: v1.0.47.6>
#NoTrayIcon

EnvSet,HOME,%A_ScriptDir%\HOME

IfNotExist, %A_ScriptDir%\HOME
    FileCreateDir, %A_ScriptDir%\HOME

Run,%A_ScriptDir%\bin\runemacs.exe

ExitApp
