# qtVersioning
Automate the process of app versioning via header files through qmake / batch as part of the development of your Qt application.

### Requirements
- [Qt Application](https://www.qt.io/developers/)
- Windows OS
- Text Editor [ [Sublime](https://www.sublimetext.com/) | [Visual Studio Code](https://code.visualstudio.com/) | [Atom](https://atom.io/) ]

### Language(s) Assocated:
- C++
- Batch Scripting

# Description
Originally used in conjunction with Qt and called via the **application.pro** file. Creates the definitions for name, company, and automatic MAJOR, MINOR, MICRO, BUILD preprocessor macros.

# Installation
## QT
Open your Qt **application.pro** file and include the following:

```c
build_nr.commands = build.bat
build_nr.depends = FORCE
QMAKE_EXTRA_TARGETS += build_nr
PRE_TARGETDEPS += build_nr
```

On the left side of your opened project, ensure **Projects** is selected in your dropdown, so that you can view the entire file structure of your project. Then right click and select **Add New** to open the **New File** Dialog.

Under **Choose a Template** to the left, select the category **C++** and on the right set of options, select **C++ Header File**. Name the new header file **build.h**.

Download the **build.bat** file from this repo and place it in the **project directory** of your application being developed.

# Usage
Every time you build your application in Qt, the **build.bat** script will execute, thus overwriting the existing **build.h** file you have in your project with new information. Each build ran will also auto-increment **#define APP_BUILD** by **+1**.

# Customization
All information to be included in your **header.h** file will come from the **build.bat** script. You may open that script in a text editor and adjust whatever parameters you wish. Once saved, go back to Qt and do another build so that the changes will take affect.

# Definitions (C++ app)
The following macros can be used inside your application once your first build has been ran.

Macro | Description
------------ | -------------
APP_TITLE | Title of your application
APP_COMPANY | Company which manages the app
APP_COPYRIGHT | Copyright information
APP_MAJOR | Version major [manually defined by user in .bat]
APP_MINOR | Version minor [manually defined by user in .bat]
APP_MICRO | Build number of app (auto-increments +1 per Qt build)
APP_BUILD | Generated based on year project started and the number of days into the year.

# Configs (build.bat)
The batch file comes with settings at the top which you can adjust based on how you need the header file created.

### Macro Settings
Setting | Default | Description
------------ | ------------- | -------------
cfg_app_title | nil | Title of your application
cfg_app_company | nil | Company which manages the app
cfg_app_copyright | nil | Copyright information
cfg_app_author | nil | Developer(s) involved with app
cfg_app_vmajor | 1 | Major version of app
cfg_app_vminor | 0 | Minor version of app
cfg_app_vbyear | 2018 | Year app started (used in calculating VERSION BUILD)

### Build Files and Paths

Setting | Default | Description
------------ | ------------- | -------------
cfg_pathbuild_fol | C:\Users\%USERNAME%\Documents\app | Path to C++ app being built
cfg_pathbuild_run | build.bat | Batch file to be ran on qmake
cfg_pathbuild_src | build.h | C++ app header file to build info in
cfg_pathbuild_txt | build.txt | Text file to store VERSION BUILD val to (+1 increments)

### Build Behaviors

Setting | Default | Description
------------ | ------------- | -------------
cfg_inc_micro | y | Includes a VERSION MICRO macro in your header file for use
cfg_inc_build | y | Includes a VERSION BUILD macro in your header file for use

# Notes

## Manual adjustments
While using this, if you make any manual changes to your **build.h** file, those changes will be overwritten on the next build. If you wish to apply additional code to your build.h file, it's best to add the changes to your batch file and let it automate the process vs remembering to add the additional information after a build is complete. There will be a risk of forgetting to re-add the information after the build and possibly cause issues.

## Versioning Format
The way you version your software really depends on personal preference. This script gives you a 4-segment version number based on the following format:

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
  <dd>Used in this script to represent the build integer (increased by +1 on each qmake performed) In the above sample, the micro <b>218</b> means that the app has been built 218 times since initial development started (adding features later to reset this number based on MAJOR/MINOR value changes)
  <dt>Build:</dt>
  <dd>Represented in this script as the date of the app being built. An example would be <b>1192</b> which would mean (Built year 1 of development on the 192nd day of the year)
</dd>
</dl>

Since the format of versioning is highly debated by developers, you have control in the **build.bat** to determine what the MICRO and BUILD should represent. Should you wish to assign these numbers manually, you may do so.
