#NoEnv
#SingleInstance, force
SendMode, Input
SetWorkingDir, %A_ScriptDir%
Menu, Tray, Tip, AHKlicker
Menu, Tray, Icon, %A_WorkingDir%\resources\icon.ico, 1, 1

; GLOBAL VARIABLES
global resources := A_WorkingDir "\resources"
global language := GetValue("config", "GENERAL", "language")
global profile := GetValue("config", "GENERAL", "profile")

; AUTO-EXECUTE SECTION
ShowMainGui()
return

; FUNCTIONS

; Get and return a value from a .ini file
GetValue(fileName, section, key){
    IniRead, value, %resources%\%fileName%.ini, %section%, %key%
    return value
}

; Show main GUI
ShowMainGui(){
    ; Creating main GUI
    Gui, main:New

    ; "File" menu
    Menu, FileMenu, Add, Start          AltGr+I, Start
    Menu, FileMenu, Add, Pause        AltGr+P, Pause
    Menu, FileMenu, Add, Stop          AltGr+S, Stop
    Menu, FileMenu, Add, Exit            AltGr+X, Exit

    Menu, MainMenuBar, Add, File, :FileMenu

    ; "Actions" menu

    ; "Mouse" sub-menu
    Menu, MouseSubMenu, Add, Right Click, RightClickAction
    Menu, MouseSubMenu, Add, Right Button Drag, RightDragAction
    Menu, MouseSubMenu, Add, Left Click, LeftClickAction
    Menu, MouseSubMenu, Add, Left Button Drag, LeftDragAction
    Menu, MouseSubMenu, Add, Middle Button, MiddleClickAction
    Menu, MouseSubMenu, Add, Middle Button Drag, MiddleDragAction
    Menu, MouseSubMenu, Add, Click on color, ClickOnColorAction
    Menu, ActionsMenu, Add, Mouse, :MouseSubMenu

    ; "Keyboard" sub-menu
    Menu, KeyboardSubMenu, Add, Write text, WriteTextAction
    Menu, KeyboardSubMenu, Add, Press Key, PressKeyAction
    Menu, KeyboardSubMenu, Add, Send command, SendCommandAction
    Menu, ActionsMenu, Add, Keyboard, :KeyboardSubMenu

    ; Other actions
    Menu, ActionsMenu, Add, Wait, WaitAction
    Menu, ActionsMenu, Add, Wait Color, WaitAction
    Menu, ActionsMenu, Add, Wait Image, WaitAction
    Menu, ActionsMenu, Add, Repeat, RepeatAction

    Menu MainMenuBar, Add, Add Action, :ActionsMenu

    ; "Profile" menu
    Menu ProfileMenu, Add, Load..., LoadConfigAction
    Menu, ProfileMenu, Add, Save, SaveConfigAction
    Menu, ProfileMenu, Add, Clean, CleanConfigAction

    Menu, MainMenuBar, Add, Profile, :ProfileMenu

    ; "Configuration" menu
    Menu, LangaugeMenu, Add, English, LoadConfigAction
    Menu, LangaugeMenu, Check, English
    Menu, LangaugeMenu, Add, Spanish, LoadConfigAction
    Menu, ConfigMenu, Add, Langauge, :LangaugeMenu

    Menu, MainMenuBar, Add, Configuration, :ConfigMenu

    ; "Help" menu
    Menu, HelpMenu, Add, About, AboutAction
    Menu, MainMenuBar, Add, Help, :HelpMenu

    ; Adding main menu bar to the GUI
    Gui, Menu, MainMenuBar

    Gui, +resize
    Gui, Add, Text, , Hello World!
    Gui, Show, w500 h200
}
mainGuiClose(){
    ExitApp
}

; About menu functions
global copyRepositoryButton
AboutAction(){
    Gui, about:New
    Gui, -Caption +ToolWindow +Border +AlwaysOnTop
    Gui, Font, s12
	Gui, Color, e9e9e9
    Gui, Add, Text, x4 y4, AHKlicker 0.0.1-alpha
    Gui, Font, c0000FF underline
	Gui, Add, Text, x4 y36 gGoRepository, https://github.com/FyeCobain/AHKlicker.git
    Gui, Add, Picture, x312 y32 w30 h30 Icon135 gCopyRepository vcopyRepositoryButton, Shell32.dll
    Gui, Font, s12 norm
    Gui, Add, Button, w80 x135 y70 gAboutOK, OK
    Gui, Show, w350 h120
}
GoRepository(){
    Run, https://github.com/FyeCobain/AHKlicker.git
    AboutOK()
}
CopyRepository(){
    Clipboard := "https://github.com/FyeCobain/AHKlicker.git"
    GuiControl, , copyRepositoryButton, *icon303 Shell32.dll
}
AboutOK(){
    Gui, about:Destroy
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
LeftDragAction(){

}
RightClickAction(){

}
RightDragAction(){

}
MiddleClickAction(){

}
MiddleDragAction(){

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