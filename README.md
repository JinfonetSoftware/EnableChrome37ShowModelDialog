# README #

### Intro ###

* Automate gpedit.msc UI steps of enableing Chrome 37 ShowModalDialog_EffectiveUntil20150430 with Autoit v3
* Tested on Windows XP en-US, zh-CN / Windows 7 en-US, zh-CN / Windows 8 (8.1) zh-CH
* Version 0.9.1
* Reference: http://www.cnblogs.com/iter/p/3949203.html

### Known issue ###
* The script tests locale with @OSLang, if user has changed default system locale, @OSLang will not reflect this change, and the script may fail.
* The script does not test the Input Locale, if the input locale is not english, the script may fail

### How do I get set up? ###

* Download and install Autoit v3 from http://www.autoitscript.com
* Run it: Run the script with Autoit v3
* Deploy it: Compile the script into exe and distribute the executable to target machine

### Contribution guidelines ###

* The script is issued under MIT license.
* Pull request zhengyu.jin@gmail.com