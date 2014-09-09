;;
;   Enanble Chrome 37 deprecated feature of ShowModalDialog_EffectiveUntil20150430 with Autoit3 Script
;	This is a Jinfonet Software, Inc. software issue under MIT License.
;				version 0.9.0				 Author Jin Zhengyu
;;

Global $vLang = _GetLanguage(@OSLang)
Global $vLocale = "Unknown"

If $vLang == "English" Then
   $vLocale = "en-US"
EndIf

If $vLocale == "en-US" Then
   Global $vWinNameMain = "Group Policy"
   Global $vWinNameAddRemoveTemplates = "Add/Remove Templates"
   Global $vWinNamePolicyTemplates = "Policy Templates"
   Global $vWinNameEnableDeprecatedWebPlatformFeautresProperties = "Enable deprecated web platform features Properties"
Else
   MsgBox( 0, "Error", "Unsupported operating system language: " & $vLang & ". Now exiting ...")
   Exit
Endif


WinClose ($vWinNameMain)
Run(@ComSpec & " /c gpedit.msc", "", @SW_HIDE)
waitWindow($vWinNameMain)

; Add Administrative Tempaltes
Send ("a")
Sleep (250)
Send ("!aa")
waitWindow ($vWinNameAddRemoveTemplates)
Sleep (500)
Send ("!a")
waitWindow ($vWinNamePolicyTemplates)
Sleep (250)
Send ( @WorkingDir & "\policy_templates\windows\adm\" & $vLocale & "\chrome.adm")
Sleep (250)
Send ("!o")
Sleep (500)
$vActiveWinTitle = WinGetTitle ("")
Sleep (500)

If $vActiveWinTitle <> $vWinNameAddRemoveTemplates Then
   Send ("!n")
   Sleep (250)
EndIf
Send ("!l")
Sleep (750)

;Configure Chrome
Send ("{RIGHT}")
Sleep (250)
Send ("g")
Sleep (250)
Send ("{RIGHT}")
Sleep (250)
Send ("g")
Sleep (250)
Send ("{TAB}")
Sleep (250)

;Open "Enable deprecated web platform features"
emmitChar (StringLeft("enable deprecated web platform features", 10))
Sleep (250)
Send ("{ENTER}")
Sleep (250)
waitWindow($vWinNameEnableDeprecatedWebPlatformFeautresProperties)
Sleep (250)
Send ("!c")
Sleep (250)
Send ("!a")
Sleep (250)
Send ("!e")
Sleep (250)
Send ("{TAB}")
Sleep (250)
Send ("{SPACE}")
Sleep (500)

;Add item
Send ("!a")
Sleep (500)
Send ("ShowModalDialog_EffectiveUntil20150430")
Sleep (250)
Send ("{ENTER}")
Sleep (500)

Send ("{ENTER}")
Sleep (250)
Send ("{TAB}")
Sleep (250)
Send ("{TAB}")
Sleep (250)
Send ("{TAB}")
Sleep (250)
Send ("{ENTER}")
Sleep (500)

WinClose ($vWinNameMain)

;;;;;;;;;;; Utils ;;;;;;;;;
Func emmitChar($pString)
	  For $vIndex=0 To StringLen($pString)
		 Send (StringMid($pString, $vIndex, 1))
		 Sleep (60)
	  Next
EndFunc

Func waitWindow ($pWinName)
   WinWait ($pWinName)
   WinActivate ($pWinName)
   WinWaitActive ($pWinName)
EndFunc

; Retrieve the language of the operating system.
Func _GetLanguage($pLocale)
    ; $pLocale is four characters in length, the first two is the dialect and the remaining two are the language group.
    ; Therefore we only require the language group and therefore select the two right-most characters.
    Switch StringRight($pLocale, 2)
        Case "07"
            Return "German"
        Case "09"
            Return "English"
        Case "0a"
            Return "Spanish"
        Case "0b"
            Return "Finnish"
        Case "0c"
            Return "French"
        Case "10"
            Return "Italian"
        Case "13"
            Return "Dutch"
        Case "14"
            Return "Norwegian"
        Case "15"
            Return "Polish"
        Case "16"
            Return "Portuguese"
        Case "1d"
            Return "Swedish"

        Case Else
            Return "Other (can't determine with @OSLang directly)"

    EndSwitch
EndFunc   ;==>_GetLanguage

