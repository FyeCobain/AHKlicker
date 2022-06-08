#NoEnv
SendMode, Input
SetWorkingDir, %A_ScriptDir%
Menu, Tray, Tip, AHKlicker
Menu, Tray, Icon, %A_WorkingDir%\resources\icon.ico, 1, 1

; Global variables
global resources := A_WorkingDir "\resources"

MsgBox, Hello World!