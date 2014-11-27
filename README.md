# README #

### Intro ###

* Automate gpedit.msc UI steps of enableing Chrome 37 ShowModalDialog_EffectiveUntil20150430 with Autoit v3
* Tested on Windows XP en-US, zh-CN / Windows 7 en-US, zh-CN / Windows 8 (8.1) en-US, zh-CH
* Version 0.9.2
* Reference: http://www.cnblogs.com/iter/p/3949203.html

### Known issue ###
* The script tests locale with @OSLang, if user has changed default system locale, @OSLang may not reflect this change, and the script may fail.

### How do I get set up? ###

* Download and install Autoit v3 from http://www.autoitscript.com
* Extract the script into a working directory
* Download and extract chrome policy templates (updated for Chromium 37+) into the script working directroy from http://dl.google.com/dl/edgedl/chrome/policy/policy_templates.zip
* Run it: Run the script with Autoit v3
* Deploy it: Compile the script into exe and distribute the executable to target machine

### Contribution guidelines ###

* The script is issued under MIT license.
* Contact [zhengyu.jin@gmail.com](mailto:zhengyu.jin@gmail.com)
