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

; Actions objects
global actions := []
global rightClick := Object("name", "RightClick", "x", 1, "y", 2)
global leftClick := Object("name", "LeftClick", "x", -1, "y", -2)

actions.push(rightClick)
actions.push(leftClick)

Loop, % actions.Length()
    For key, value in actions[A_Index]
        MsgBox %key% => %value%

; AUTO-EXECUTE SECTION
ShowMainGui()

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
    Menu, MouseSubMenu, Add, % Get("Actions", "LeftClick"), LeftClickAction
    Menu, MouseSubMenu, Add, % Get("Actions", "LeftDrag"), LeftDragAction
    Menu, MouseSubMenu, Add, % Get("Actions", "RightClick"), RightClickAction
    Menu, MouseSubMenu, Add, % Get("Actions", "RightDrag"), RightDragAction
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
    Menu, WaitSubMenu, Add, % Get("Actions", "Sleep") , SleepAction
    Menu, WaitSubMenu, Add, % Get("Actions", "WaitColor"), WaitColorAction
    Menu, WaitSubMenu, Add, % Get("Actions", "WaitImage"), WaitImageAction
    Menu, ActionsMenu, Add, % Get("Actions", "Wait"), :WaitSubMenu

    Menu, ActionsMenu, Add, % Get("Actions", "Repeat"), RepeatAction
    Menu, ActionsMenu, Add, % Get("Actions", "RunCommand"), RunCommandAction

    Menu, MainMenuBar, Add, % Get("Actions", "AddAction"), :ActionsMenu

    ; "Profile" menu
    Menu, ProfileMenu, Add, % Get("Profile", "Load"), LoadProfileAction
    Menu, ProfileMenu, Add, % Get("Profile", "Save"), SaveProfileAction
    Menu, ProfileMenu, Add, % Get("Profile", "Clear"), CleanProfileAction

    Menu, MainMenuBar, Add, % Get("Profile", "Profile"), :ProfileMenu

    ; "Configuration" menu

    ; "Language" sub-menu
    Menu, LangaugeSubMenu, Add, % Get("Languages", "en"), SetEnglishAction
    Menu, LangaugeSubMenu, Add, % Get("Languages", "spa"), SetSpanishAction
    Menu, LangaugeSubMenu, Check, % Get("Languages", language)
    Menu, ConfigMenu, Add, % Get("Languages", "Language"), :LangaugeSubMenu

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
    Gui, Add, Text, x4 y4, AHKlicker 0.0.4-alpha
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

; Timer for confirmation tooltip message
global tooltipMessage
TooltipMessageTimer(){
    ToolTip, %tooltipMessage%
}

; Wait confirmation or cancelation of adding an action
AddActionConfirmation(confirmationMessage){
    tooltipMessage := confirmationMessage
    SetTimer, TooltipMessageTimer, 50
    while(!GetKeyState("F3") && !GetKeyState("F4"))
        continue
    SetTimer, TooltipMessageTimer, Delete
    ToolTip
    return GetKeyState("F3")
}

; Mouse actions sub-menu functions
LeftClickAction(){
    if(AddActionConfirmation("F3 => Left Click here`nF4 => Cancel"))
        MsgBox, Action added
    else
        MsgBox, Action canceled
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
RunCommandAction(){

}

; Profile menu actions
LoadProfileAction(){

}
SaveProfileAction(){

}
CleanProfileAction(){

}

; Configuration menu actions

SetLanguage(newLanguage){
    if(language == newLanguage)
        return

    ; Getting all sections names in the current language file
    IniRead, sections, %resourcesPath%\languages\%language%.ini
    sections := StrSplit(sections, "`n")

    ; Changing language
    Loop, % sections.Length(){
        ; Getting current language values
        IniRead, sectionCurrentValues, %resourcesPath%\languages\%language%.ini, % sections[A_Index]
        sectionCurrentValues := StrSplit(sectionCurrentValues, "`n")

        ; Getting new language values
        IniRead, sectionNewValues, %resourcesPath%\languages\%newLanguage%.ini, % sections[A_Index]
        sectionNewValues := StrSplit(sectionNewValues, "`n")

        ; Changing values to the new language
        Loop, % sectionCurrentValues.Length(){
            currentValue := RegExReplace(sectionCurrentValues[A_Index], "(^[^=]+=)")
            newValue := RegExReplace(sectionNewValues[A_Index], "(^[^=]+=)")

            ; Changing menu bar items names
            try{
                Menu, MainMenuBar, Rename, %currentValue%, %newValue%
            }
            try{
                Menu, FileMenu, Rename, %currentValue%, %newValue%
            }
            try{
                Menu, ActionsMenu, Rename, %currentValue%, %newValue%
            }
            try{
                Menu, MouseSubMenu, Rename, %currentValue%, %newValue%
            }
            try{
                Menu, KeyboardSubMenu, Rename, %currentValue%, %newValue%
            }
            try{
                Menu, WaitSubMenu, Rename, %currentValue%, %newValue%
            }
            try{
                Menu, ProfileMenu, Rename, %currentValue%, %newValue%
            }
            try{
                Menu, ConfigMenuProfileMenu, Rename, %currentValue%, %newValue%
            }
            try{
                Menu, ConfigMenu, Rename, %currentValue%, %newValue%
            }
            try{
                Menu, LangaugeSubMenu, Uncheck, %currentValue%
                Menu, LangaugeSubMenu, Rename, %currentValue%, %newValue%
            }
            try{
                Menu, HelpMenu, Rename, %currentValue%, %newValue%
            }
            catch{}
        }
    }

    language := newLanguage
    Menu, LangaugeSubMenu, Check, % Get("Languages", language)
    SetConfig("GENERAL", "language", language)
}

SetEnglishAction(){
    SetLanguage("en")
}
SetSpanishAction(){
    SetLanguage("spa")
}