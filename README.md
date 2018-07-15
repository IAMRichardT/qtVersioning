# qtVersioning

### Requirements
- [Qt Application](https://www.qt.io/developers/)
- Windows OS
- Text Editor [ [Sublime](https://www.sublimetext.com/) | [Visual Studio Code](https://code.visualstudio.com/) | [Atom](https://atom.io/) ]

### Language(s) Associated:
- C++
- Batch Scripting

# Description
Used in conjunction with Qt and called via the **application.pro** file. Creates the C++ macros for name, company, and automatic MAJOR, MINOR, MICRO, BUILD preprocessor macros. Assists with automating the process of building a header file for your application.

# Installation
## QT
**Open -> Qt application.pro** file and include the following:

```c
build_nr.commands = build.bat
build_nr.depends = FORCE
QMAKE_EXTRA_TARGETS += build_nr
PRE_TARGETDEPS += build_nr
```

Within Qt to the left side panels, view the entire file structure of your app and right click to select **Add New** and open the **New File** Dialog.

**Choose a Template** to the left, select the category **C++** and on the right, select **C++ Header File**. 
Name the new header file **build.h**.

Place the downloaded **build.bat** file from this repo in the **project directory** of your app being developed.

# Usage
Each time you build your app in Qt, **build.bat** will execute, thus overwriting data in **build.h** with updated info. Each build ran will also auto-increment **#define APP_BUILD** by **+1** (if enabled -- see settings).

# Customization
All information in your **header.h** file comes from **build.bat** each time you build your app. 
Ensure that you edit **build.bat** with your information before you build the app in Qt.

# Macros (Qt C++)
The following macros can be used inside your app once you build your app.

Macro | Desc
------------ | -------------
APP_TITLE | Title of application
APP_COMPANY | Company managing app
APP_COPYRIGHT | Copyright info
APP_MAJOR | Version major [manually defined by user in .bat]
APP_MINOR | Version minor [manually defined by user in .bat]
APP_MICRO | Build number (auto-increments +1 each time app is built in Qt)
APP_BUILD | Generated based on year project started and the number of days into the year.

# Configs (build.bat)
**build.bat** comes with settings at the top. Ensure you edit these for your app.

### Macro Settings

Setting | Default | Desc
------------ | ------------- | -------------
cfg_app_title | nil | Title of your application
cfg_app_company | nil | Company which manages the app
cfg_app_copyright | nil | Copyright information
cfg_app_author | nil | Developer(s) involved with app
cfg_app_vmajor | 1 | Major version of app
cfg_app_vminor | 0 | Minor version of app
cfg_app_vbyear | 2018 | Year app started (used in calculating VERSION BUILD)

### Build Files and Paths

Setting | Default | Desc
------------ | ------------- | -------------
cfg_path_fol | C:\Users\%USERNAME%\Documents\app | Path to C++ app being built
cfg_path_run | build.bat | Batch file to be ran on qmake
cfg_path_src | build.h | C++ app header file to build info in
cfg_path_txt | build.txt | Text file to store VERSION BUILD val to (+1 increments)
cfg_path_log | build_debug.txt | Text file to store debugging logs

### Build Behaviors

Setting | Default | Desc
------------ | ------------- | -------------
cfg_debug_enabled | true | Enables debug and reports in <b>build_debug.txt</b>
cfg_inc_micro | true | Use VERSION MICRO macro in your header file for use
cfg_inc_build | true | Use VERSION BUILD macro in your header file for use
cfg_automate_micro | true | VERSION MICRO auto-increments +1 every build :: Disable to manually set
cfg_resetmicro | true | If cfg_automate_micro=true, micro will reset every major build change

# Debug
This script includes debugging which is enabled via **cfg_debug_enabled**. Each build will input a new log into the defined **cfg_path_log** file to help you keep track of build dates, times, and versioning. 

# Notes

## Manual adjustments
While using this, if you make any manual changes to your **build.h** file, those changes will be overwritten on the next build. If you wish to apply additional code to your build.h file, it's best to add the changes to your batch file and let it automate the process vs remembering to add the additional information after a build is complete. There will be a risk of forgetting to re-add the information after the build and possibly cause issues.

## Versioning Format
The way you version your software really depends on personal preference. This script gives you a 4-segment version number (by default) based on the following format:

<dl>
  <dt>Template Ex:</dt>
  <dd>[MAJOR].[MINOR].[MICRO].[BUILD]</dd>
  <dt>Sample:</dt>
  <dd>v1.3.218.1192</dd>
</dl>

<dl>
  <dt>Major:</dt>
  <dd>Major revision (new interfaces, major features introduced, conceptual change, etc.)</dd>
  <dt>Minor:</dt>
  <dd>Minor revision (updates that collectively include smaller updates such as simple feature enhancements compiled with bug fixes)
  <dt>Micro:</dt>
  <dd>Used in this script to represent the build integer (increased by +1 on each qmake performed) In the above sample, the micro <b>218</b> means that the app has been built 218 times since initial development started.<br /><br />You have the option to turn this OFF via <b>cfg_automate_micro</b> and use it as a PATCH integer instead.
  <dt>Build:</dt>
  <dd>Represented in this script as the date of the app being built. An example would be <b>1192</b> which would mean (Built year 1 of development on the 192nd day of the year)
</dd>
</dl>

If you choose to turn off **cfg_automate_micro**, you can manually set the integer. 
People tend to use the VERSION MICRO as a PATCH integer (raised each time a strict bug patch is released).

Since the format of versioning is highly debated by developers, you have control in the **build.bat** to determine what the MICRO and BUILD should represent. Should you wish to assign these numbers manually, you may do so.
