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

; Max number of actions and actions objects array
global maxActions := 35
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
    languageFile := languageFile ? languageFile : language
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
global action31
global action32
global action33
global action34
global action35
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
    ; Click on Color sub sub-menu...
    Menu, ClickOnColorSubSubMenu, Add, % Get("Actions", "AtMousePosition"), ClickOnColorAtMousePositionAction
    Menu, ClickOnColorSubSubMenu, Add, % Get("Actions", "EnterColor"), ClickOnColorEnterColorAction
    Menu, MouseSubMenu, Add, % Get("Actions", "ClickOnColor"), :ClickOnColorSubSubMenu
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

    Menu, ActionsMenu, Add

    Menu, ActionsMenu, Add, % Get("Tools", "ColorPicker"), PickColorAction

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

    ; Gui width and height
    guiWidth := 400
    guiHeight := 16 * maxActions

    ; Adding empty texts to the GUI
    Gui, Font, s11
    y := 0
    Loop, %maxActions%{
        Gui, Add, Text, x2 y%y% w%guiWidth% vaction%A_Index%
        y += 16
    }
    
    ; Showing main GUI
    Gui, +resize
    Gui, Show, % "w" guiWidth " h" guiHeight " y" Floor(A_ScreenHeight / 2 - guiHeight / 2 - maxActions), %title%
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
    Gui, Add, Text, x4 y4, % "AHKlicker " GetConfig("About", "version")
    Gui, Font, c0000FF underline
    Gui, Add, Text, x4 y36 gGoRepository, % GetConfig("About", "repo")
    Gui, Add, Picture, x312 y32 w30 h30 Icon135 gCopyRepository vcopyRepositoryButton, Shell32.dll
    Gui, Font, s12 norm
    Gui, Add, Button, w80 x135 y70 gAboutOK, % Get("Dialogs", "OK")
    Gui, Show, w348 h120
}
GoRepository(){
    Run, % GetConfig("About", "repo")
    AboutOK()
}
CopyRepository(){
    Clipboard := GetConfig("About", "repo")
    GuiControl, , copyRepositoryButton, *icon303 Shell32.dll
}
AboutOK(){
    Gui, about:Destroy
}
; Show actions list in the GUI
ShowActions(actionDeleted := false){
    for key, action in actions
        GuiControl, main:, action%A_Index%, % A_Index ": " action.displayName
    if(actionDeleted)
        Loop, % maxActions - actions.Length()
            GuiControl, main:, % "action" A_Index + actions.Length()
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

; Wait confirmation or cancelation...

; Confirming click
ConfirmClick(actionObject){
    minimize()
    tooltipMessage := okKey " = " Get("Actions", actionObject.name) " " Get("Dialogs", "Here") "`n" cancelKey " = " Get("Dialogs", "Cancel")
    SetTimer, TooltipMessageTimer, 50
    while(!GetKeyState(okKey) && !GetKeyState(cancelKey))
        continue
    SetTimer, TooltipMessageTimer, Delete
    ToolTip
    if(GetKeyState(cancelKey)){
        restore()
        return false
    }
    MouseGetPos, , , winId
    WinActivate, ahk_id %winId%
    MouseGetPos, mX, mY
    restore()
    actionObject.x := mX
    actionObject.y := mY
    WinGet, winExe, ProcessName, ahk_id %winId%
    actionObject.process := winExe
    return true
}

; Confirmig mouse drag
ConfirmDrag(actionObject){
    minimize()
    tooltipMessage := Get("Actions", actionObject.name) "`n" cancelKey " = " Get("Dialogs", "Cancel")
    SetTimer, TooltipMessageTimer, 50
    dragDone := false
    while(!GetKeyState(cancelKey)){
        if(!GetKeyState(actionObject.button))
            continue
        MouseGetPos, mX1, mY1, winId1
        while(GetKeyState(actionObject.button))
            MouseGetPos, mX2, mY2, winId2
        if(mX2 >= 0 && winId1 == winId2)
            if(Abs(mX2 - mX1) >= 5 || Abs(mY2 - mY1) >= 5){
                dragDone := true
                break
            }
        mX2 :=
    }
    SetTimer, TooltipMessageTimer, Delete
    ToolTip
    if(!dragDone){
        restore()
        return false
    }
    MsgBox, % 4 + 32, % Get("Dialogs", "Confirmation"), % Get("Dialogs", "DragConfirmation")
    IfMsgBox Yes
    {
        actionObject.x1 := mX1
        actionObject.y1 := mY1
        actionObject.x2 := mX2
        actionObject.y2 := mY2
        WinGet, winExe, ProcessName, ahk_id %winId1%
        actionObject.process := winExe
        restore()
        return true
    }
    else
        return ConfirmDrag(actionObject)
}

; Confirming color picking
ConfirmColorPick(colorObject){
    minimize()
    SetTimer, TooltipMessageTimer, 50
    while(!GetKeyState(okKey) && !GetKeyState(cancelKey)){
        MouseGetPos, mX, mY, winId
        PixelGetColor, color, %mX%, %mY%, Slow RGB
        tooltipMessage := okKey " = " StrReplace(color, "0x", "#") "`n" cancelKey " = " Get("Dialogs", "Cancel")
    }
    confirmed := !GetKeyState(cancelKey)
    SetTimer, TooltipMessageTimer, Delete
    ToolTip
    restore()
    if(!confirmed)
        return false
    WinGet, winExe, ProcessName, ahk_id %winId%
    colorObject.pixelColor := StrReplace(color, "0x", "#")
    colorObject.process := winExe
    return true
}

; Confirm value input
ConfirmInput(title, prompt:="", hide:="", width:=300, height:=130, x:=-1, y:=-1, timeout:="", default:="", trimValue:=True, requiredPattern:=False){
    if(x == -1)
        x := A_ScreenWidth / 2 - width / 2 ; Centering on X
    if(y == -1)
        y := A_ScreenHeight / 2 - height / 2 ; Centering on Y

    while(True){
        InputBox, value, %title%, %prompt%, %hide%, %width%, %height%, %x%, %y%, Locale, %timeout%, %default%
        if ErrorLevel
            return ""
        if(trimValue)
            value := Trim(value, " `t`r`n")
        if(value == "")
            continue
        if(requiredPattern)
            if(!RegExMatch(value, requiredPattern))
                continue
        return value
    }
}

; Confirm window where the mouse is
ConfirmWindow(){
    minimize()
    tooltipMessage := ""
    SetTimer, TooltipMessageTimer, 50
    while(!GetKeyState(okKey) && !GetKeyState(cancelKey)){
        MouseGetPos, , , winId
        WinGet, winExe, ProcessName, ahk_id %winId%
        tooltipMessage := okKey " = " Get("Dialogs", "ThisWindow") " (" winExe ")`n" cancelKey " = " Get("Dialogs", "Cancel")
        continue
    }
    SetTimer, TooltipMessageTimer, Delete
    ToolTip
    if(GetKeyState(cancelKey)){
        restore()
        return false
    }
    return winExe
}

; Mouse actions sub-menu functions
LeftClickAction(){
    action := {name: "LeftClick"}
    if(!ConfirmClick(action))
        return

    action.saveName := "{" action.name "}[" action.process "]("  action.x "," action.y ")"
    action.displayName := Get("Actions", action.name) " [" action.process " ] ("  action.x ", " action.y ")"

    actions.push(action)
    ShowActions()
}

LeftDragAction(){
    action := {name: "LeftDrag", button: "LButton"}
    if(!ConfirmDrag(action))
        return

    action.saveName := "{" action.name "}[" action.process "]("  action.x1 "," action.y1 ")(" action.x2 "," action.y2 ")"
    action.displayName := Get("Actions", action.name) " [" action.process " ] ("  action.x1 ", " action.y1 ") => (" action.x2 ", " action.y2 ")"

    actions.push(action)
    ShowActions()
}

RightClickAction(){
    action := {name: "RightClick"}
    if(!ConfirmClick(action))
        return

    action.saveName := "{" action.name "}[" action.process "]("  action.x "," action.y ")"
    action.displayName := Get("Actions", action.name) " [" action.process " ] ("  action.x ", " action.y ")"

    actions.push(action)
    ShowActions()
}

RightDragAction(){
    action := {name: "RightDrag", button: "RButton"}
    if(!ConfirmDrag(action))
        return

    action.saveName := "{" action.name "}[" action.process "]("  action.x1 "," action.y1 ")(" action.x2 "," action.y2 ")"
    action.displayName := Get("Actions", action.name) " [" action.process " ] ("  action.x1 ", " action.y1 ") => (" action.x2 ", " action.y2 ")"

    actions.push(action)
    ShowActions()
}

MiddleClickAction(){
    action := {name: "MiddleClick"}
    
    if(!ConfirmClick(action))
        return

    action.saveName := "{" action.name "}[" action.process "]("  action.x "," action.y ")"
    action.displayName := Get("Actions", action.name) " [" action.process " ] ("  action.x ", " action.y ")"

    actions.push(action)
    ShowActions()
}

MiddleDragAction(){
    action := {name: "MiddleDrag", button: "MButton"}
    if(!ConfirmDrag(action))
        return

    action.saveName := "{" action.name "}[" action.process "]("  action.x1 "," action.y1 ")(" action.x2 "," action.y2 ")"
    action.displayName := Get("Actions", action.name) " [" action.process " ] ("  action.x1 ", " action.y1 ") => (" action.x2 ", " action.y2 ")"

    actions.push(action)
    ShowActions()
}

ClickOnColorAtMousePositionAction(){
    action := {name: "ClickOnColor"}
    if(!ConfirmColorPick(action))
       return

    action.saveName := "{" action.name "}[" action.process "](" action.pixelColor ")"
    action.displayName := Get("Actions", action.name) " [" action.process " ] (" action.pixelColor ")"

    actions.push(action)
    ShowActions()
}

ClickOnColorEnterColorAction(){
    windowProcess := ConfirmWindow()
    if(!windowProcess)
        return

    color := ConfirmInput(Get("Dialogs", "EnterAColorValue"), Get("Dialogs", "ColorValue"), , , , , , , , , "^(?:0x|#)?[a-fA-F0-9]{6}$")
    restore()
    if(color == "")
        return
    
    color := "#" RegExReplace(color, "(0x|#)")
    StringUpper, color, color
    
    action := {name: "ClickOnColor", process: windowProcess, pixelColor: color}

    action.saveName := "{" action.name "}[" action.process "](" action.pixelColor ")"
    action.displayName := Get("Actions", action.name) " [" action.process " ] (" action.pixelColor ")"

    actions.push(action)
    ShowActions()
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
PickColorAction(){
    colorObj := {name: "ColorPicker"}
    if(!ConfirmColorPick(colorObj))
       return

    Clipboard := colorObj.pixelColor
    ToolTip, % Get("Tools", "ColorPicked")
    Sleep, 1000
    ToolTip
}

; Profile menu actions
LoadProfileAction(){

}
SaveProfileAction(){

}
CleanProfileAction(){

}

; Minimize the GUI
minimize(){
    WinMinimize, %title% ahk_exe AutoHotkey.exe
    WinMinimize, %title% ahk_exe AutoHotkeyU64.exe
}

; Restore the GUI
restore(){
    WinRestore, %title% ahk_exe AutoHotkey.exe
    WinRestore, %title% ahk_exe AutoHotkeyU64.exe
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
                continue
            }
            try{
                Menu, FileMenu, Rename, %currentValue%, %newValue%
                continue
            }
            try{
                Menu, ActionsMenu, Rename, %currentValue%, %newValue%
                continue
            }
            try{
                Menu, MouseSubMenu, Rename, %currentValue%, %newValue%
                continue
            }
            try{
                Menu, ClickOnColorSubSubMenu, Rename, %currentValue%, %newValue%
                continue
            }
            try{
                Menu, KeyboardSubMenu, Rename, %currentValue%, %newValue%
                continue
            }
            try{
                Menu, WaitSubMenu, Rename, %currentValue%, %newValue%
                continue
            }
            try{
                Menu, ProfileMenu, Rename, %currentValue%, %newValue%
                continue
            }
            try{
                Menu, ConfigMenuProfileMenu, Rename, %currentValue%, %newValue%
                continue
            }
            try{
                Menu, ConfigMenu, Rename, %currentValue%, %newValue%
                continue
            }
            try{
                Menu, LangaugeSubMenu, Uncheck, %currentValue%
                Menu, LangaugeSubMenu, Rename, %currentValue%, %newValue%
                continue
            }
            try{
                Menu, HelpMenu, Rename, %currentValue%, %newValue%
            }
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