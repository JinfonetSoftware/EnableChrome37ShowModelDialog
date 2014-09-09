;;
;   Enanble Chrome 37 deprecated feature of ShowModalDialog_EffectiveUntil20150430 with Autoit3 Script
;	This is a Jinfonet Software, Inc. software issue under MIT License.
;				version 0.9.0				 Author Jin Zhengyu
;;

#include <MsgBoxConstants.au3>

;MsgBox($MB_SYSTEMMODAL, "OS Type:", @OSType & @OSVersion);

Global $vLang = _GetLanguage(@OSLang)
Global $vLocale = "Unknown"

If $vLang == "English" Then
   $vLocale = "en-US"
ElseIf $vLang == "Chinese" Then
   If @OSLang == "0804" Then
	  $vLocale = "zh-CN"
   EndIf
EndIf

If $vLocale == "en-US" Then
   If @OSVersion == "WIN_XP" Then
	  Global $vWinNameMain = "Group Policy"
   Else
	  Global $vWinNameMain = "Local Group Policy Editor"
   EndIf
   Global $vWinNameAddRemoveTemplates = "Add/Remove Templates"
   Global $vWinNamePolicyTemplates = "Policy Templates"
   Global $vWinNameConfirmFileReplace = "Confirm File Replace"
   Global $vWinNameCopyFile = "Copy File"
   Global $vWinNameEnableDeprecatedWebPlatformFeautresProperties = "Enable deprecated web platform features Properties"
   Global $vItemAdministrativeTemplates = "a"
   Global $vItemClassicAdministrativeTemplate = "c"
ElseIf $vLocale == "zh-CN-NotSupportedYet" Then
   Global $vWinNameMain = String("本地组策略编辑器")
   Global $vWinNameAddRemoveTemplates = "添加/删除模板"
   Global $vWinNamePolicyTemplates = "策略模板"
   Global $vWinNameConfirmFileReplace = "Confirm File Replace"
   Global $vWinNameCopyFile = "复制文件"
   Global $vWinNameEnableDeprecatedWebPlatformFeautresProperties = "Enable deprecated web platform features Properties"
   Global $vItemAdministrativeTemplates = "管"
   Global $vItemClassicAdministrativeTemplate = ""
Else
   MsgBox( 0, "Error", "Unsupported operating system language: " & $vLang & ". Now exiting ...")
   Exit
Endif


;closeAllWindow ($vWinNameMain)
Run(@ComSpec & " /c gpedit.msc", "", @SW_HIDE)
waitWindow($vWinNameMain)
Sleep(250)

; Add Administrative Tempaltes
;MsgBox($MB_SYSTEMMODAL, "Sending Key:", $vItemAdministrativeTemplates);
;Send ("a")
Send ("{ASC 065}")
;emmitChar($vItemAdministrativeTemplates)
Sleep (250)
Send ("!aa")
Exit

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

If $vActiveWinTitle == $vWinNameConfirmFileReplace Then
   Send ("!n")
   Sleep (250)
ElseIf $vActiveWinTitle == $vWinNameCopyFile Then
   Send ("{TAB}")
   Sleep (250)
   Send ("{TAB}")
   Sleep (250)
   Send ("{ENTER}")
   Sleep (250)
EndIf

Send ("!l")
Sleep (750)

;Configure Chrome
Send ("{RIGHT}")
Sleep (250)

;WIN_7 has put itme in to classic ADM
If @OSVersion <> "WIN_XP" Then
   Send ($vItemClassicAdministrativeTemplate)
   Sleep (250)
   Send ("{RIGHT}")
   Sleep (250)
EndIf

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

;WinClose ($vWinNameMain)

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
	    Case "04"
			Return "Chinese"
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

Func closeAllWindow($pWinName)
   Local $vList = WinList($pWinName)
   Local $vMsg = ""

   For $i = 1 To $vList[0][0]
	   MsgBox($MB_SYSTEMMODAL, "", "Title: " & $vList[$i][0] & @CRLF & "Handle: " & $vList[$i][1])
	   MsgBox($MB_SYSTEMMODAL, "Task Status:", WinClose($pWinName));
   Next
EndFunc
