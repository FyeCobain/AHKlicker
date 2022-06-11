#NoEnv
#SingleInstance, force
SendMode, Input
SetWorkingDir, %A_ScriptDir%
Menu, Tray, Tip, AHKlicker
Menu, Tray, Icon, %A_WorkingDir%\resources\icon.ico, 1, 1

; GLOBAL VARIABLES
global resources := A_WorkingDir "\resources"

; AUTO-EXECUTE SECTION
ShowMainGui()
return

; METHODS
; Show main GUI
ShowMainGui(){
    Gui, main:New
    Gui, +resize
    Gui, Add, Text, , Hello World!
    Gui, Show, w500 h200
}
mainGuiClose:
ExitApp
return