# Installation:

In order to work with this robot framework repo locally, you need:

**1)** hel-fi environment set up and running in your machine so that you can access drupal web development platform at : https://www.xxxxxx.docker.sh  
      
      For example: helfi.docker.sh or helsinki-paatokset.docker.sh
  
**2)** IDE with robot framework support.
     
     For example: RIDE, Eclipse, Pycharm, VSCode or IntellijIdea.
    
**3)**  [Robot Framework](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#installation-instructions) Installed
    
**4)**  [SeleniumLibrary](https://pypi.org/project/robotframework-seleniumlibrary/) Installed. 

    needed for running the testcases

**5)**  [DoctestLibrary](https://pypi.org/project/robotframework-doctestlibrary/) Installed.  

    needed for picture compare assertions


            
You can use the latest versions of the libraries, but might need to do some small refactoring if for example same keyword would have become outdated or if some structures like classic if-else pattern is no longer supported.

Currently used (6/2021) versions are:

    Robot Framework 4.0.2
    Seleniumlibrary 5.1.3
    Doctestlibrary  0.1.2
     
# Usage:
You can run your first testcase by running (in cloned git project folder):

            robot -i GALLERY -A ./environments/local.args -d robotframework-reports
which will run all tests with GALLERY tag. Other arguments are:
- Argument file for setting up some variables related to local environment (**optional**)
- Report folder for run logs (related to project folder root)  (**optional**)
  
For Full list of commands available run *robot --help* in command prompt

# Useful information:
## For cleaning up logs and such before each run, you can chain commands and remove the robotframework-reports folder altogether before your test run as follows (in windows):
            
            /c del /S /Q <full path to reports folder>
and full command example is:

            /c del /S /Q C:\TA\helfi\robotframework-reports & robot -i GALLERY -A ./environments/local.args -d robotframework-reports 
           
## For cleaning up reports folder for easier readability you can transfer selenium-screenshots to subfolder by:

            mkdir <reports folder>\screenshots\selenium-screenshots & move /Y <reports folder>\sele*.png <reports folder>\screenshots\selenium-screenshots
            
and full command example is:
            
            robot -i DEMO -A ./environments/local.args -d robotframework-reports  . & mkdir C:\TA\helfi_python\robotframework-reports\screenshots\selenium-screenshots & move             /Y C:\TA\helfi_python\robotframework-reports\sele*.png C:\TA\helfi_python\robotframework-reports\screenshots\selenium-screenshots
            
full command with both reports folder cleaning before run and screenshots relocating after the run example here:
            
            /c del /S /Q C:\TA\helfi_python\robotframework-reports &
            robot -i DEMO -A ./environments/local.args -d robotframework-reports  . & mkdir C:\TA\helfi_python\robotframework-reports\screenshots\selenium-screenshots & move             /Y C:\TA\helfi_python\robotframework-reports\sele*.png C:\TA\helfi_python\robotframework-reports\screenshots\selenium-screenshots

## Eclipse user tips:
You can use external tools configuration feature to run command prompt command in eclipse directly
