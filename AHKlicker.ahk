#NoEnv
#SingleInstance, force
SendMode, Input
SetWorkingDir, %A_ScriptDir%
Menu, Tray, Tip, AHKlicker
Menu, Tray, Icon, %A_WorkingDir%\resources\images\icon.ico, 1, 1

; GLOBAL VARIABLES
global resourcesPath := A_WorkingDir "\resources"
global language := GetConfig("GENERAL", "language")
global profile := GetConfig("GENERAL", "profile")

; AUTO-EXECUTE SECTION
ShowMainGui()
return

; FUNCTIONS

; Gets and returns a value from the config.ini file
GetConfig(section, key){
    IniRead, value, %resourcesPath%\config.ini, %section%, %key%, [{%key%}]
    return value
}

; Sets a value to the config.ini file
SetConfig(section, key, value){
    IniWrite, %value%,  %resourcesPath%\config.ini, %section%, %key%
}

; Gets and returns a value from the current language file
Get(section, key){
    IniRead, value, %resourcesPath%\languages\%language%.ini, %section%, %key%, [{%key%}]
    return value
}

; Shows the main GUI
ShowMainGui(){
    ; Creating main GUI
    Gui, main:New

    ; "File" menu
    Menu, FileMenu, Add, % Get("FileMenu", "Start"), Start
    Menu, FileMenu, Add, % Get("FileMenu", "Pause"), Pause
    Menu, FileMenu, Add, % Get("FileMenu", "Stop"), Stop
    Menu, FileMenu, Add, % Get("FileMenu", "Restart"), Stop
    Menu, FileMenu, Add
    Menu, FileMenu, Add, % Get("FileMenu", "Exit"), Exit
    Menu, MainMenuBar, Add, % Get("FileMenu", "File"), :FileMenu

    ; "Add Action" menu

    ; "Mouse" sub-menu
    Menu, MouseSubMenu, Add, % Get("Actions", "RightClick"), RightClickAction
    Menu, MouseSubMenu, Add, % Get("Actions", "RightDrag"), RightDragAction
    Menu, MouseSubMenu, Add, % Get("Actions", "LeftClick"), LeftClickAction
    Menu, MouseSubMenu, Add, % Get("Actions", "LeftDrag"), LeftDragAction
    Menu, MouseSubMenu, Add, % Get("Actions", "MiddleClick"), MiddleClickAction
    Menu, MouseSubMenu, Add, % Get("Actions", "MiddleDrag"), MiddleDragAction
    Menu, MouseSubMenu, Add, % Get("Actions", "ClickOnColor"), ClickOnColorAction
    Menu, ActionsMenu, Add, % Get("Actions", "Mouse"), :MouseSubMenu

    ; "Keyboard" sub-menu
    Menu, KeyboardSubMenu, Add, % Get("Actions", "Write"), WriteAction
    Menu, KeyboardSubMenu, Add, % Get("Actions", "PressKey"), PressKeyAction
    Menu, KeyboardSubMenu, Add, % Get("Actions", "SendCommand"), SendCommandAction
    Menu, ActionsMenu, Add, % Get("Actions", "Keyboard"), :KeyboardSubMenu

    ; "Wait" sub-menu
    Menu, WaitMenu, Add, % Get("Actions", "Sleep") , SleepAction
    Menu, WaitMenu, Add, % Get("Actions", "WaitColor"), WaitColorAction
    Menu, WaitMenu, Add, % Get("Actions", "WaitImage"), WaitImageAction
    Menu, ActionsMenu, Add, % Get("Actions", "Wait"), :WaitMenu

    Menu, ActionsMenu, Add, % Get("Actions", "Repeat"), RepeatAction
    Menu, MainMenuBar, Add, % Get("Actions", "AddAction"), :ActionsMenu

    ; "Profile" menu
    Menu, ProfileMenu, Add, % Get("Profile", "Load"), LoadProfileAction
    Menu, ProfileMenu, Add, % Get("Profile", "Save"), SaveProfileAction
    Menu, ProfileMenu, Add, % Get("Profile", "Clear"), CleanProfileAction

    Menu, MainMenuBar, Add, % Get("Profile", "Profile"), :ProfileMenu

    ; "Configuration" menu
    Menu, LangaugeMenu, Add, % Get("Languages", "en"), SetEnglishAction
    Menu, LangaugeMenu, Add, % Get("Languages", "spa"), SetSpanishAction
    Menu, LangaugeMenu, Check, % Get("Languages", language)
    Menu, ConfigMenu, Add, % Get("Languages", "Language"), :LangaugeMenu

    Menu, MainMenuBar, Add, % Get("Configuration", "Configuration"), :ConfigMenu

    ; "Help" menu
    Menu, HelpMenu, Add, % Get("HelpMenu", "About"), AboutAction
    Menu, MainMenuBar, Add, % Get("HelpMenu", "Help"), :HelpMenu

    ; Adding main menu bar to the GUI
    Gui, Menu, MainMenuBar

    ; Showing main GUI
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
    Gui, Add, Button, w80 x135 y70 gAboutOK, % Get("Dialogs", "OK")
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
Restart(){
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

; Keyboard actions sub-menu
WriteAction(){

}
PressKeyAction(){

}
SendCommandAction(){

}

; Other actions
SleepAction(){

}
WaitColorAction(){

}
WaitImageAction(){

}
RepeatAction(){

}

; Profile menu actions
LoadProfileAction(){

}
SaveProfileAction(){

}
CleanProfileAction(){

}

; Configuration menu actions
SetEnglishAction(){
    if(language == "en")
        return
    SetConfig("GENERAL", "language", "en")
    Reload
}
SetSpanishAction(){
    if(language == "spa")
        return
    SetConfig("GENERAL", "language", "spa")
    Reload
}