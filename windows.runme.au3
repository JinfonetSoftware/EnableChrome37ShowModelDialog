;;
;   Enanble Chrome 37 deprecated feature of ShowModalDialog_EffectiveUntil20150430 with Autoit3 Script
;	This is a Jinfonet Software, Inc. software, issued under MIT License.
;				version 0.9.2				 Author Jin Zhengyu
;				Copyright 2014, Jinfonet Software, Inc. 
;;

#include <MsgBoxConstants.au3>
#include <WinAPILocale.au3>
#include <WinAPISys.au3>
#include <Clipboard.au3>
; This script requires full Administrative rights
#RequireAdmin


Global $vLocale = "Unknown"

$vLocale = getOSLocale(); getThreadLocale()

;MsgBox(0, "Locale", getOSLocale() & ":" & $vLocale)


If $vLocale == "en-US" Then
   If @OSVersion == "WIN_XP" Then
	  Global $vWinNameMain = "Group Policy"
	  Global $vWinNameEnableDeprecatedWebPlatformFeautresProperties = "Enable deprecated web platform features Properties"
   Else
	  Global $vWinNameMain = "Local Group Policy Editor"
	  Global $vWinNameEnableDeprecatedWebPlatformFeautresProperties = "Enable deprecated web platform features"
   EndIf
   Global $vWinNameAddRemoveTemplates = "Add/Remove Templates"
   Global $vWinNamePolicyTemplates = "Policy Templates"

   ;WIN_XP
   Global $vWinNameConfirmFileReplace = "Confirm File Replace"
   ;WIN_7
   Global $vWinNameCopyFile = "Copy File"
   ;WIN_8
   Global $vWinNameReplaceOrSkip = "Replace or Skip Files"

   Global $vWinNameShowContents = "Show Contents"
   Global $vItemAdministrativeTemplates = "a"
   Global $vItemClassicAdministrativeTemplate = "classic"
   Global $vItemEnableDeprecatedWebPlatformFeatures = "enable deprecated web platform features"
ElseIf $vLocale == "zh-CN" Then
   If @OSVersion == "WIN_XP" Then
	  Global $vWinNameMain = "组策略"
	  Global $vWinNameEnableDeprecatedWebPlatformFeautresProperties = "启用已弃用的网络平台功能 属性"
   Else
	  Global $vWinNameMain = String("本地组策略编辑器")
	  Global $vWinNameEnableDeprecatedWebPlatformFeautresProperties = "启用已弃用的网络平台功能"
   EndIf
   Global $vWinNameAddRemoveTemplates = "添加/删除模板"
   Global $vWinNamePolicyTemplates = "策略模板"

   ;WIN_XP
   Global $vWinNameConfirmFileReplace = "确认文件替换"
   ;WIN_7
   Global $vWinNameCopyFile = "复制文件"
   ;WIN_8
   Global $vWinNameReplaceOrSkip = "替换或跳过文件"

   Global $vWinNameShowContents = "显示内容"
   Global $vItemAdministrativeTemplates = "管"
   Global $vItemClassicAdministrativeTemplate = "经"
   Global $vItemEnableDeprecatedWebPlatformFeatures = "启用已弃用的网络平台功能"
Else
   MsgBox( 0, "Error", "Unsupported operating system language: " & $vLocale & ". Now exiting ...")
   Exit
Endif

closeAllWindow ($vWinNameMain)
Run(@ComSpec & " /c gpedit.msc", "", @SW_HIDE)
; ToDo: compares the $vWinNameMain with current active window.
waitWindow($vWinNameMain)
Sleep(250)

; Add Administrative Tempaltes
;MsgBox($MB_SYSTEMMODAL, "Sending Key:", $vItemAdministrativeTemplates);
emitChar($vItemAdministrativeTemplates)
Sleep (250)
Send ("!aa")
Sleep (250)

waitWindow ($vWinNameAddRemoveTemplates)
Sleep (500)
Send ("!a")
Local $vHWndPolicyTemplates = waitWindow ($vWinNamePolicyTemplates)
Sleep (750)

ClipPut (@WorkingDir & "\policy_templates\windows\adm\" & $vLocale & "\chrome.adm")
Sleep (250)
Send ("^v");
;Send ( @WorkingDir & "\policy_templates\windows\adm\" & $vLocale & "\chrome.adm")
Sleep (250)
Send ("!o")
Sleep (1000)
$vActiveWinTitle = WinGetTitle ("")
Sleep (500)

If $vActiveWinTitle == $vWinNameAddRemoveTemplates Then
   Sleep (250)
ElseIf @OSVersion == "WIN_XP" Then
   waitWindow($vWinNameConfirmFileReplace)
   Sleep (250)
   Send ("!n")
   Sleep (250)
ElseIf @OSVersion == "WIN_VISTA" Or @OSVersion == "WIN_7" Then
   waitWindow($vWinNameCopyFile)
   Sleep (250)
   Send ("{TAB}")
   Sleep (250)
   Send ("{TAB}")
   Sleep (250)
   Send ("{ENTER}")
   Sleep (250)
ElseIf StringLeft(@OSVersion, 5) == "WIN_8" Then
   ;MsgBox($MB_SYSTEMMODAL, "OS Type:", @OSType & @OSVersion);
   waitWindow($vWinNameReplaceOrSkip)
   Sleep (250)
   Send ("!s")
   Sleep (250)
EndIf

waitWindow ($vWinNameAddRemoveTemplates)
Sleep (250)
Send ("!l")
Sleep (2000)


;Configure Chrome
Send ("{RIGHT}")
Sleep (500)

;Since WIN_7 has put itme in to classic ADM
If @OSVersion <> "WIN_XP" Then
   emitChar ($vItemClassicAdministrativeTemplate)
   Sleep (250)
   Send ("{RIGHT}")
   Sleep (250)
EndIf

Send ("g{ENTER}")
Sleep (250)
Send ("{RIGHT}")
Sleep (500)
Send ("g{ENTER}")
Sleep (750)
Send ("{TAB}")
Sleep (750)

;Open "Enable deprecated web platform features"
emitChar (StringLeft($vItemEnableDeprecatedWebPlatformFeatures, 10))
Sleep (250)
Send ("{ENTER}")
Sleep (250)

waitWindow($vWinNameEnableDeprecatedWebPlatformFeautresProperties)
Sleep (500)
Send ("!c")
Sleep (250)
Send ("!a")
Sleep (250)
Send ("!e")
Sleep (250)
Send ("{TAB}")
Sleep (250)
If @OSVersion <> "WIN_XP" Then
   Send ("{TAB}")
   Sleep (250)
Endif
Send ("{SPACE}")
Sleep (500)

;Add item
If @OSVersion == "WIN_XP" Then
   Send ("!a")
   Sleep (500)
   ;Send ("ShowModalDialog_EffectiveUntil20150430")
   ClipPut("ShowModalDialog_EffectiveUntil20150430")
   Send ("{SPACE}{BS}")
   Sleep (250)
   Sleep (250)
   Send ("^v")
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
; ToDo Check all supportd platform / locale ElseIf (StringLeft(@OSVersion, 5) == "WIN_8") Or (@OSVersion == "WIN_7") Then
Else
   waitWindow ($vWinNameShowContents)
   Send ("{TAB}")
   Sleep (250)
   Send ("{TAB}")
   Sleep (250)
   ;Send ("ShowModalDialog_EffectiveUntil20150430")
   ClipPut("ShowModalDialog_EffectiveUntil20150430")
   Send ("{SPACE}{BS}")
   Sleep (250)
   Send ("^v")
   Sleep (250)
   Send ("!o")
   Sleep (250)
   Send ("{TAB}")
   Sleep (250)
   Send ("{TAB}")
   Sleep (250)
   Send ("{ENTER}")
   Sleep (500)
EndIf

WinClose ($vWinNameMain)

;;;;;;;;;;; Utils ;;;;;;;;;
Func emitChar($pString)
   For $vIndex=0 To StringLen($pString)
	  Send (StringMid($pString, $vIndex, 1))
	  Sleep (60)
   Next
EndFunc

Func waitWindow ($pWinName)
   Local $vHWnd
   $vHWnd = WinWait ($pWinName)
   WinActivate ($pWinName)
   WinWaitActive ($pWinName)
   Return $vHWnd
EndFunc

Func closeAllWindow($pWinName)
   Local $vList = WinList($pWinName)
   Local $vMsg = ""

   For $i = 1 To $vList[0][0]
	   WinClose($pWinName);
   Next
EndFunc

Func getThreadLocale()
      Local $vLocaleID = _WinAPI_GetThreadLocale ()
	  Return lcid2localestring($vLocaleID)
EndFunc

Func getOSLocale()
      Local $vLocaleID = Dec(@OSLang)
	  Return lcid2localestring($vLocaleID)
EndFunc

Func lcid2localestring($pLCID)
   Local $vLocaleDefArray[][] = [["LCID_Dec",  "Locale",  "Language"], _
									["4",  "zh-CHS",  "Chinese"], _
									["1025",  "ar-SA",  "Arabic"], _
									["1026",  "bg-BG",  "Bulgarian"], _
									["1027",  "ca-ES",  "Catalan"], _
									["1028",  "zh-TW",  "Chinese"], _
									["1029",  "cs-CZ",  "Czech"], _
									["1030",  "da-DK",  "Danish"], _
									["1031",  "de-DE",  "German"], _
									["1032",  "el-GR",  "Greek"], _
									["1033",  "en-US",  "English"], _
									["1034",  "es-ES_tradnl",  "Spanish"], _
									["1035",  "fi-FI",  "Finnish"], _
									["1036",  "fr-FR",  "French"], _
									["1037",  "he-IL",  "Hebrew"], _
									["1038",  "hu-HU",  "Hungarian"], _
									["1039",  "is-IS",  "Icelandic"], _
									["1040",  "it-IT",  "Italian"], _
									["1041",  "ja-JP",  "Japanese"], _
									["1042",  "ko-KR",  "Korean"], _
									["1043",  "nl-NL",  "Dutch"], _
									["1044",  "nb-NO",  "Norwegian"], _
									["1045",  "pl-PL",  "Polish"], _
									["1046",  "pt-BR",  "Portuguese"], _
									["1047",  "rm-CH",  "Romansh"], _
									["1048",  "ro-RO",  "Romanian"], _
									["1049",  "ru-RU",  "Russian"], _
									["1050",  "hr-HR",  "Croatian"], _
									["1051",  "sk-SK",  "Slovak"], _
									["1052",  "sq-AL",  "Albanian"], _
									["1053",  "sv-SE",  "Swedish"], _
									["1054",  "th-TH",  "Thai"], _
									["1055",  "tr-TR",  "Turkish"], _
									["1056",  "ur-PK",  "Urdu"], _
									["1057",  "id-ID",  "Indonesian"], _
									["1058",  "uk-UA",  "Ukrainian"], _
									["1059",  "be-BY",  "Belarusian"], _
									["1060",  "sl-SI",  "Slovenian"], _
									["1061",  "et-EE",  "Estonian"], _
									["1062",  "lv-LV",  "Latvian"], _
									["1063",  "lt-LT",  "Lithuanian"], _
									["1064",  "tg-Cyrl-TJ",  "Tajik"], _
									["1065",  "fa-IR",  "Persian"], _
									["1066",  "vi-VN",  "Vietnamese"], _
									["1067",  "hy-AM",  "Armenian"], _
									["1068",  "az-Latn-AZ",  "Azeri"], _
									["1069",  "eu-ES",  "Basque"], _
									["1070",  "hsb-DE",  "Upper"], _
									["1071",  "mk-MK",  "Macedonian"], _
									["1074",  "tn-ZA",  "Setswana"], _
									["1076",  "xh-ZA",  "isiXhosa"], _
									["1077",  "zu-ZA",  "isiZulu"], _
									["1078",  "af-ZA",  "Afrikaans"], _
									["1079",  "ka-GE",  "Georgian"], _
									["1080",  "fo-FO",  "Faroese"], _
									["1081",  "hi-IN",  "Hindi"], _
									["1082",  "mt-MT",  "Maltese"], _
									["1083",  "se-NO",  "Sami"], _
									["1086",  "ms-MY",  "Malay"], _
									["1087",  "kk-KZ",  "Kazakh"], _
									["1088",  "ky-KG",  "Kyrgyz"], _
									["1089",  "sw-KE",  "Swahili"], _
									["1090",  "tk-TM",  "Turkmen"], _
									["1091",  "uz-Latn-UZ",  "Uzbek"], _
									["1092",  "tt-RU",  "Tatar"], _
									["1093",  "bn-IN",  "Bangla"], _
									["1094",  "pa-IN",  "Punjabi"], _
									["1095",  "gu-IN",  "Gujarati"], _
									["1096",  "or-IN",  "Oriya"], _
									["1097",  "ta-IN",  "Tamil"], _
									["1098",  "te-IN",  "Telugu"], _
									["1099",  "kn-IN",  "Kannada"], _
									["1100",  "ml-IN",  "Malayalam"], _
									["1101",  "as-IN",  "Assamese"], _
									["1102",  "mr-IN",  "Marathi"], _
									["1103",  "sa-IN",  "Sanskrit"], _
									["1104",  "mn-MN",  "Mongolian"], _
									["1105",  "bo-CN",  "Tibetan"], _
									["1106",  "cy-GB",  "Welsh"], _
									["1107",  "km-KH",  "Khmer"], _
									["1108",  "lo-LA",  "Lao"], _
									["1110",  "gl-ES",  "Galician"], _
									["1111",  "kok-IN",  "Konkani"], _
									["1114",  "syr-SY",  "Syriac"], _
									["1115",  "si-LK",  "Sinhala"], _
									["1116",  "chr-Cher-US",  "Cherokee"], _
									["1117",  "iu-Cans-CA",  "Inuktitut"], _
									["1118",  "am-ET",  "Amharic"], _
									["1121",  "ne-NP",  "Nepali"], _
									["1122",  "fy-NL",  "Frisian"], _
									["1123",  "ps-AF",  "Pashto"], _
									["1124",  "fil-PH",  "Filipino"], _
									["1125",  "dv-MV",  "Divehi"], _
									["1128",  "ha-Latn-NG",  "Hausa"], _
									["1130",  "yo-NG",  "Yoruba"], _
									["1131",  "quz-BO",  "Quechua"], _
									["1132",  "nso-ZA",  "Sesotho"], _
									["1133",  "ba-RU",  "Bashkir"], _
									["1134",  "lb-LU",  "Luxembourgish"], _
									["1135",  "kl-GL",  "Greenlandic"], _
									["1136",  "ig-NG",  "Igbo"], _
									["1139",  "ti-ET",  "Tigrinya"], _
									["1141",  "haw-US",  "Hawiian"], _
									["1144",  "ii-CN",  "Yi"], _
									["1146",  "arn-CL",  "Mapudungun"], _
									["1148",  "moh-CA",  "Mohawk"], _
									["1150",  "br-FR",  "Breton"], _
									["1152",  "ug-CN",  "Uyghur"], _
									["1153",  "mi-NZ",  "Maori"], _
									["1154",  "oc-FR",  "Occitan"], _
									["1155",  "co-FR",  "Corsican"], _
									["1156",  "gsw-FR",  "Alsatian"], _
									["1157",  "sah-RU",  "Sakha"], _
									["1158",  "qut-GT",  "K'iche"], _
									["1159",  "rw-RW",  "Kinyarwanda"], _
									["1160",  "wo-SN",  "Wolof"], _
									["1164",  "prs-AF",  "Dari"], _
									["1169",  "gd-GB",  "Scottish"], _
									["1170",  "ku-Arab-IQ",  "Central"], _
									["2049",  "ar-IQ",  "Arabic"], _
									["2051",  "ca-ES-valencia",  "Valencian"], _
									["2052",  "zh-CN",  "Chinese"], _
									["2055",  "de-CH",  "German"], _
									["2057",  "en-GB",  "English"], _
									["2058",  "es-MX",  "Spanish"], _
									["2060",  "fr-BE",  "French"], _
									["2064",  "it-CH",  "Italian"], _
									["2067",  "nl-BE",  "Dutch"], _
									["2068",  "nn-NO",  "Norwegian"], _
									["2070",  "pt-PT",  "Portuguese"], _
									["2074",  "sr-Latn-CS",  "Serbian"], _
									["2077",  "sv-FI",  "Swedish"], _
									["2080",  "ur-IN",  "Urdu"], _
									["2092",  "az-Cyrl-AZ",  "Azeri"], _
									["2094",  "dsb-DE",  "Lower"], _
									["2098",  "tn-BW",  "Setswana"], _
									["2107",  "se-SE",  "Sami"], _
									["2108",  "ga-IE",  "Irish"], _
									["2110",  "ms-BN",  "Malay"], _
									["2115",  "uz-Cyrl-UZ",  "Uzbek"], _
									["2117",  "bn-BD",  "Bangla"], _
									["2118",  "pa-Arab-PK",  "Punjabi"], _
									["2121",  "ta-LK",  "Tamil"], _
									["2128",  "mn-Mong-CN",  "Mongolian"], _
									["2137",  "sd-Arab-PK",  "Sindhi"], _
									["2141",  "iu-Latn-CA",  "Inuktitut"], _
									["2143",  "tzm-Latn-DZ",  "Tamazight"], _
									["2151",  "ff-Latn-SN",  "Pular"], _
									["2155",  "quz-EC",  "Quechua"], _
									["2163",  "ti-ER",  "(reserved)"], _
									["2163",  "ti-ER",  "Tigrinya"], _
									["3073",  "ar-EG",  "Arabic"], _
									["3076",  "zh-HK",  "Chinese"], _
									["3079",  "de-AT",  "German"], _
									["3081",  "en-AU",  "English"], _
									["3082",  "es-ES",  "Spanish"], _
									["3084",  "fr-CA",  "French"], _
									["3098",  "sr-Cyrl-CS",  "Serbian"], _
									["3131",  "se-FI",  "Sami"], _
									["3179",  "quz-PE",  "Quechua"], _
									["4097",  "ar-LY",  "Arabic"], _
									["4100",  "zh-SG",  "Chinese"], _
									["4103",  "de-LU",  "German"], _
									["4105",  "en-CA",  "English"], _
									["4106",  "es-GT",  "Spanish"], _
									["4108",  "fr-CH",  "French"], _
									["4122",  "hr-BA",  "Croatian"], _
									["4155",  "smj-NO",  "Sami"], _
									["4191",  "tzm-Tfng-MA",  "Central"], _
									["5121",  "ar-DZ",  "Arabic"], _
									["5124",  "zh-MO",  "Chinese"], _
									["5127",  "de-LI",  "German"], _
									["5129",  "en-NZ",  "English"], _
									["5130",  "es-CR",  "Spanish"], _
									["5132",  "fr-LU",  "French"], _
									["5146",  "bs-Latn-BA",  "Bosnian"], _
									["5179",  "smj-SE",  "Sami"], _
									["6145",  "ar-MA",  "Arabic"], _
									["6153",  "en-IE",  "English"], _
									["6154",  "es-PA",  "Spanish"], _
									["6156",  "fr-MC",  "French"], _
									["6170",  "sr-Latn-BA",  "Serbian"], _
									["6203",  "sma-NO",  "Sami"], _
									["7169",  "ar-TN",  "Arabic"], _
									["7177",  "en-ZA",  "English"], _
									["7178",  "es-DO",  "Spanish"], _
									["7194",  "sr-Cyrl-BA",  "Serbian"], _
									["7227",  "sma-SE",  "Sami"], _
									["8193",  "ar-OM",  "Arabic"], _
									["8201",  "en-JM",  "English"], _
									["8202",  "es-VE",  "Spanish"], _
									["8218",  "bs-Cyrl-BA",  "Bosnian"], _
									["8251",  "sms-FI",  "Sami"], _
									["9217",  "ar-YE",  "Arabic"], _
									["9225",  "en-029",  "English"], _
									["9226",  "es-CO",  "Spanish"], _
									["9242", "sr-Latn-RS", "Serbian"], _
									["9275", "smn-FI", "Sami"], _
									["10241", "ar-SY", "Arabic"], _
									["10249", "en-BZ", "English"], _
									["10250", "es-PE", "Spanish"], _
									["10266", "sr-Cyrl-RS", "Serbian"], _
									["11265", "ar-JO", "Arabic"], _
									["11273", "en-TT", "English"], _
									["11274", "es-AR", "Spanish"], _
									["11290", "sr-Latn-ME", "Serbian"], _
									["12289", "ar-LB", "Arabic"], _
									["12297", "en-ZW", "English"], _
									["12298", "es-EC", "Spanish"], _
									["12314", "sr-Cyrl-ME", "Serbian"], _
									["13313", "ar-KW", "Arabic"], _
									["13321", "en-PH", "English"], _
									["13322", "es-CL", "Spanish"], _
									["14337", "ar-AE", "Arabic"], _
									["14346", "es-UY", "Spanish"], _
									["15361", "ar-BH", "Arabic"], _
									["15370", "es-PY", "Spanish"], _
									["16385", "ar-QA", "Arabic"], _
									["16393", "en-IN", "English"], _
									["16394", "es-BO", "Spanish"], _
									["17417", "en-MY", "English"], _
									["17418", "es-SV", "Spanish"], _
									["18441", "en-SG", "English"], _
									["18442", "es-HN", "Spanish"], _
									["19466", "es-NI", "Spanish"], _
									["20490", "es-PR", "Spanish"], _
									["21514", "es-US", "Spanish"], _
									["31748", "zh-CHT", "Chinese"]]

   Local $vLength = UBound($vLocaleDefArray)
   For $i = 0 To $vLength - 1
	  If $pLCID = $vLocaleDefArray[$i][0] Then
		 Return $vLocaleDefArray[$i][1]
	  EndIf
   Next

   Return "Unknown"
EndFunc
