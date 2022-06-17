#NoEnv
#SingleInstance, force
SendMode, Input
SetWorkingDir, %A_ScriptDir%
Menu, Tray, Tip, AHKlicker
Menu, Tray, Icon, %A_WorkingDir%\resources\icon.ico, 1, 1

; GLOBAL VARIABLES
global resourcesPath := A_WorkingDir "\resources"
global language := Get("config", "GENERAL", "language")
global profile := Get("config", "GENERAL", "profile")

; AUTO-EXECUTE SECTION
ShowMainGui()
return

; FUNCTIONS

; Gets and returns a value from a .ini file
Get(fileName, section, key){
    IniRead, value, %resourcesPath%\%fileName%.ini, %section%, %key%
    return value
}

; Shows the main GUI
ShowMainGui(){
    ; Creating main GUI
    Gui, main:New

    ; "File" menu
    Menu, FileMenu, Add, % Get(language, "FileMenu", "Start"), Start
    Menu, FileMenu, Add,% Get(language, "FileMenu", "Pause"), Pause
    Menu, FileMenu, Add, % Get(language, "FileMenu", "Stop"), Stop
    Menu, FileMenu, Add, % Get(language, "FileMenu", "Reset"), Stop
    Menu, FileMenu, Add, % Get(language, "FileMenu", "Exit"), Exit
    Menu, MainMenuBar, Add, % Get(language, "FileMenu", "File"), :FileMenu

    ; "Add Action" menu

    ; "Mouse" sub-menu
    Menu, MouseSubMenu, Add, % Get(language, "Actions", "RightClick"), RightClickAction
    Menu, MouseSubMenu, Add, % Get(language, "Actions", "RightDrag"), RightDragAction
    Menu, MouseSubMenu, Add, % Get(language, "Actions", "LeftClick"), LeftClickAction
    Menu, MouseSubMenu, Add, % Get(language, "Actions", "LeftDrag"), LeftDragAction
    Menu, MouseSubMenu, Add, % Get(language, "Actions", "MiddleClick"), MiddleClickAction
    Menu, MouseSubMenu, Add, % Get(language, "Actions", "MiddleDrag"), MiddleDragAction
    Menu, MouseSubMenu, Add, % Get(language, "Actions", "ClickOnColor"), ClickOnColorAction
    Menu, ActionsMenu, Add, % Get(language, "Actions", "Mouse"), :MouseSubMenu

    ; "Keyboard" sub-menu
    Menu, KeyboardSubMenu, Add, % Get(language, "Actions", "Write"), WriteTextAction
    Menu, KeyboardSubMenu, Add, % Get(language, "Actions", "PressKey"), PressKeyAction
    Menu, KeyboardSubMenu, Add, % Get(language, "Actions", "SendCommand"), SendCommandAction
    Menu, ActionsMenu, Add, % Get(language, "Actions", "Keyboard"), :KeyboardSubMenu

    ; Other actions
    Menu, ActionsMenu, Add, % Get(language, "Actions", "Wait") , WaitAction
    Menu, ActionsMenu, Add, % Get(language, "Actions", "WaitColor"), WaitAction
    Menu, ActionsMenu, Add, % Get(language, "Actions", "WaitImage"), WaitAction
    Menu, ActionsMenu, Add, % Get(language, "Actions", "Repeat"), RepeatAction

    Menu MainMenuBar, Add, % Get(language, "Actions", "AddAction"), :ActionsMenu

    ; "Profile" menu
    Menu ProfileMenu, Add, % Get(language, "Profile", "Load"), LoadConfigAction
    Menu, ProfileMenu, Add, % Get(language, "Profile", "Save"), SaveConfigAction
    Menu, ProfileMenu, Add, % Get(language, "Profile", "Clear"), CleanConfigAction

    Menu, MainMenuBar, Add, % Get(language, "Profile", "Profile"), :ProfileMenu

    ; "Configuration" menu
    Menu, LangaugeMenu, Add, % Get(language, "Configuration", "en") , LoadConfigAction
    Menu, LangaugeMenu, Add, % Get(language, "Configuration", "es") , LoadConfigAction
    Menu, LangaugeMenu, Check, % Get(language, "Configuration", language)
    Menu, ConfigMenu, Add, % Get(language, "Configuration", "Language"), :LangaugeMenu

    Menu, MainMenuBar, Add, % Get(language, "Configuration", "Configuration"), :ConfigMenu

    ; "Help" menu
    Menu, HelpMenu, Add, % Get(language, "HelpMenu", "About"), AboutAction
    Menu, MainMenuBar, Add, % Get(language, "HelpMenu", "Help"), :HelpMenu

    ; Adding main menu bar to the GUI
    Gui, Menu, MainMenuBar

    Gui, +resize
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
    Gui, Add, Button, w80 x135 y70 gAboutOK, % Get(language, "Dialogs", "OK")
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