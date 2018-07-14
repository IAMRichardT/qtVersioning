# rBuildHeader
Create header files for C++ applications through qmake / batch

# Description
Originally used in conjunction with Qt and called via the **application.pro** file. Creates the definitions for name, company, and automatic MAJOR, MINOR, MICRO, BUILD preprocessor macros.

# Installation
## QT
Open your Qt **application.pro** file and include the following so that everytime your application is built, it will run the batch file and create the proper **build.h** header

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

**NOTE:** Remember that while using this, if you make any manual changes to your **build.h** file, those changes will be overwritten on the next build.

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

Setting | Default | Description
------------ | ------------- | -------------
cfg_pathbuild_fol | C:\Users\%USERNAME%\Documents\app | Path to C++ app being built
cfg_pathbuild_run | build.bat | Batch file to be ran on qmake
cfg_pathbuild_src | build.h | C++ app header file to build info in
cfg_pathbuild_txt | build.txt | Text file to store VERSION BUILD val to (+1 increments)

Setting | Default | Description
------------ | ------------- | -------------
cfg_inc_micro | y | Includes a VERSION MICRO macro in your header file for use
cfg_inc_build | y | Includes a VERSION BUILD macro in your header file for use
