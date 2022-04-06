# Installation:

In order to work with this robot framework repo locally, you need:

**1)** hel-fi environment set up and running in your machine so that you can access drupal web development platform at : https://www.xxxxxx.docker.sh  
      
      For example: hel-platform.docker.sh or helfi.docker.sh
  
**2)** IDE with robot framework support.
     
     For example: RIDE, Eclipse, Pycharm, VSCode or IntellijIdea.
    
**3)**  [Robot Framework](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#installation-instructions) Installed
    
**4)**  [SeleniumLibrary](https://pypi.org/project/robotframework-seleniumlibrary/) Installed. 

    needed for running the testcases

**5)**  [Roboteyes](https://github.com/jz-jess/RobotEyes) Installed.  

    needed for picture compare assertions


            
You can use the latest versions of the libraries, but might need to do some small refactoring if for example same keyword would have become outdated or if some structures like classic if-else pattern is no longer supported.

Currently used (6/2021) versions are:

    Robot Framework 4.0.2
    Seleniumlibrary 5.1.3
    Roboteyes  1.5.0
     
# Usage:
You can run your first testcase by running (in cloned git project folder):

            robot -i GALLERY -A ./environments/local.args -d robotframework-reports .
which will run all tests with GALLERY tag. Other arguments are:
- Argument file for setting up some variables related to local environment (**optional**)
- Report folder for run logs (related to project folder root)  (**optional**)
  
For Full list of commands available run *robot --help* in command prompt
## Run profiles:
Robot Framework Uses argument files to run correct settings in CI and local runs. These settings files can be found from environments -folder

# Docker and CI
You can use Dockerfile to create container for Robot Framework. However Dockerfile should be combined with hel-fi environment in a way that from container you can run tests against helfi web platform.

In github runs also [Pabot](https://github.com/mkorpela/pabot) is used. But it can be used in local envs also. Purpose of it is to speed up running tests by parallel execution.
Current pabot version is  2.1.0



# Useful information:
### For cleaning up logs and such before each run, you can chain commands and remove the robotframework-reports folder altogether before your test run as follows (in windows):
            
            RMDIR /S /Q <full path to reports folder>
and full command example is:            
            
            RMDIR /S /Q C:\TA\helfi_python\robotframework-reports & robot -i DEMO -A ./environments/local.args -d C:\TA\helfi\robotframework-reports .

If you want to clear files from the folder only, do as follows:            


            del /S /Q <full path to reports folder>
and full command example is:

            del /S /Q C:\TA\helfi\robotframework-reports & robot -i DEMO -A ./environments/local.args -d C:\TA\helfi\robotframework-reports .

## Eclipse user tips:
You can use external tools configuration feature to run command prompt command in eclipse directly. Command prompt needs /c argument to run command through it. For example:

      /c del /S /Q C:\TA\helfi_python\robotframework-reports
      
      
You can also configure shortcut key to run tests with one keyboard button press by setting: Preferences -> General -> Keys -> Run last launched external Tool
