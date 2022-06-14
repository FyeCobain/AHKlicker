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
    ; Creating main GUI
    Gui, main:New

    ; "File" menu
    Menu, FileMenu, Add, Start`tAltGr+I, Start
    Menu, FileMenu, Add, Pause`tAltGr+P, Pause
    Menu, FileMenu, Add, Stop`tAltGr+S, Stop
    Menu, FileMenu, Add, Exit, Exit

    Menu, MainMenuBar, Add, Files, :FileMenu

    ; "Actions" menu

    ; "Mouse" sub-menu
    Menu, MouseSubMenu, Add, Right Click, RightClickAction
    Menu, MouseSubMenu, Add, Left Click, LeftClickAction
    Menu, MouseSubMenu, Add, Middle Button, MiddleClickAction
    Menu, MouseSubMenu, Add, Drag, DragAction
    Menu, MouseSubMenu, Add, Click on color, ClickOnColorAction
    Menu, ActionsMenu, Add, Mouse, :MouseSubMenu

    ; "Keyboard" sub-menu
    Menu, KeyboardSubMenu, Add, Write text, WriteTextAction
    Menu, KeyboardSubMenu, Add, Press Key, PressKeyAction
    Menu, KeyboardSubMenu, Add, Send command, SendCommandAction
    Menu, ActionsMenu, Add, Keyboard, :KeyboardSubMenu

    ; Other actions
    Menu, ActionsMenu, Add, Wait, WaitAction
    Menu, ActionsMenu, Add, Repeat, RepeatAction

    Menu MainMenuBar, Add, Actions, :ActionsMenu

    ; "Configuration" menu
    Menu ConfigMenu, Add, Load, LoadConfigAction
    Menu, ConfigMenu, Add, Save, SaveConfigAction
    Menu, ConfigMenu, Add, Clean, CleanConfigAction

    Menu, MainMenuBar, Add, Configuration, :ConfigMenu

    ; "About" menu
    Menu, MainMenuBar, Add, About, AboutAction

    ; Adding main menu bar to the GUI
    Gui, Menu, MainMenuBar

    Gui, +resize
    Gui, Add, Text, , Hello World!
    Gui, Show, w500 h200
}
mainGuiClose(){
    ExitApp
}

; File menu functions
Start(){
    ExitApp
}
Pause(){
    ExitApp
}
Stop(){
    ExitApp
}
Exit(){
    ExitApp
}

; Actions menu funcitons
MouseActions(){

}

; Mouse actions sub-menu 
LeftClickAction(){

}
RightClickAction(){

}
MiddleClickAction(){

}
DragAction(){

}
ClickOnColorAction(){

}

;Keyboard actions sub-menu
WriteTextAction(){

}
PressKeyAction(){

}
SendCommandAction(){

}

; Other actions
WaitAction(){

}

RepeatAction(){

}

; Configuration menu actions
LoadConfigAction(){

}

SaveConfigAction(){

}

CleanConfigAction(){

}

; About menu functions
AboutAction(){

}