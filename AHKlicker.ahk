#NoEnv
#SingleInstance, force
SendMode, Input
SetWorkingDir, %A_ScriptDir%
Menu, Tray, Tip, AHKlicker
Menu, Tray, Icon, %A_WorkingDir%\resources\images\icon.ico, 1, 1

; GLOBAL VARIABLES
global title := "AHKlicker"
global okKey := "F9"
global cancelKey := "F10"
global resourcesPath := A_WorkingDir "\resources"
global language := GetConfig("GENERAL", "language")
global profile := GetConfig("GENERAL", "profile")

; Actions objects
global actions := []

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

; Gets and returns a value from the current (or the given) language file
Get(section, key, languageFile := false){
    if(!languageFile)
        languageFile := language
    IniRead, value, %resourcesPath%\languages\%languageFile%.ini, %section%, %key%, [{%key%}]
    return value
}

; Shows the main GUI
global action1
global action2
global action3
global action4
global action5
global action6
global action7
global action8
global action9
global action10
global action11
global action12
global action13
global action14
global action15
global action16
global action17
global action18
global action19
global action20
global action21
global action22
global action23
global action24
global action25
global action26
global action27
global action28
global action29
global action30
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

    ; Adding empty texts to the GUI
    Gui, Font, s11
    x := 2
    y := 2
    Loop, 30{
        Gui, Add, Text, x%x% y%y% w350 vaction%A_Index%
        y += 16
    }

    ; Showing main GUI
    Gui, +resize
    Gui, Show, % "w350 h484 y" A_ScreenHeight / 2 - 242 + 40 , %title%
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
    Gui, Show, w348 h120
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
ConfirmClick(action){
    WinMinimize, %title% ahk_exe AutoHotkey.exe
    tooltipMessage := okKey " = " Get("Actions", action.name) " " Get("Dialogs", "Here") "`n" cancelKey " = Cancel"
    SetTimer, TooltipMessageTimer, 50
    while(!GetKeyState(okKey) && !GetKeyState(cancelKey))
        continue
    confirmed := !GetKeyState(cancelKey)
    SetTimer, TooltipMessageTimer, Delete
    ToolTip
    WinRestore, %title% ahk_exe AutoHotkey.exe
    action.x := 282882
    return confirmed
}

; Mouse actions sub-menu functions
LeftClickAction(){
    action := {name: "LeftClick", saveName: "", displayName: "", process: "explorer.exe", x: 0, y: 0}

    if(!ConfirmClick(action))
        return

    action.displayName := Get("Actions", action.name) " [" action.process " ] ("  action.x ", " action.y ")"
    action.saveName := "{" action.name "}[" action.process "]("  action.x "," action.y ")"

    actions.push(action)
    ShowActions()
}
LeftDragAction(){

}
RightClickAction(){
    action := {name: "RightClick", saveName: "", displayName: "", process: "explorer.exe", x: 0, y: 0}
    
    if(!ConfirmClick(action))
        return

    action.displayName := Get("Actions", action.name) " [" action.process " ] ("  action.x ", " action.y ")"
    action.saveName := "{" action.name "}[" action.process "]("  action.x "," action.y ")"

    actions.push(action)
    ShowActions()
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

    ; Translating actions display names 
    Loop, % actions.Length()
        actions[A_Index].displayName := StrReplace(actions[A_Index].displayName, Get("Actions", actions[A_Index].name), Get("Actions", actions[A_Index].name, newLanguage))
    ShowActions()

    ; Saving language configuration
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

; Show actions list in the GUI
ShowActions(){
    for key, action in actions{
        GuiControl, , action%A_Index%, % A_Index ": " action.displayName
        y += 16
    }
}