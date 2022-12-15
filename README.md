# Installation:

In order to work with this robot framework repo locally, you need:

**1)** hel-fi environment set up and running in your machine so that you can access drupal web development platform at : https://www.xxxxxx.docker.so  
      
      For example: helfi-kymp.docker.so or helfi.docker.so
  
**2)** IDE with robot framework support.
     
     For example: PhpStorm, RIDE, Eclipse, Pycharm, VSCode or IntellijIdea.
     Remember to download suitable robot framework -plugin for your IDE. Eases navigation, readability and such a lot.
    
**3)**  [Robot Framework](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#installation-instructions) Installed
      
     After installing robot framework you can check the installed version with command(mac users):  pip3 show robotframework
     IMPORTANT! Make sure python and its site-packages are added into path. Otherwise robot- might not be found as command
    
**4)**  [SeleniumLibrary](https://pypi.org/project/robotframework-seleniumlibrary/) Installed. 

    needed for running the testcases
    After installing you can check the installed version with command(mac users):  pip3 show robotframework-seleniumlibrary
    
**5)**  [Browser Drivers](https://pypi.org/project/robotframework-seleniumlibrary/#browser-drivers) for browsers you are going to run tests with.
    
    Seleniumlibrary uses these drivers to control browser during test run.

**6)**  [Roboteyes](https://github.com/jz-jess/RobotEyes) Installed.  

    needed for picture compare assertions
    After installing you can check the installed version with command(mac users):  pip3 show robotframework-roboteyes



            
You can use the latest versions of the libraries, but might need to do some small refactoring if for example same keyword would have become outdated or if some structures like classic if-else pattern is no longer supported.

Currently used (4/2022) versions are:

    Robot Framework 5.0
    Seleniumlibrary 6.0.0
    Roboteyes  1.6.0

# Setting Up Local environment
You can use following robotframework support at least in kymp/sote environment 
To set up robotframework tests in local environment you need to:

**1)** add following line into .env -file at kymp/sote root folder under COMPOSE_PROJECT_NAME

      COMPOSE_PROFILES=testing
**2)** start environment with command:

      make setup-robo DRUPAL_BUILD_FROM_SCRATCH=true
After instance is up and running robot-framework should be able to log-in and run tests throughly. You can proceed to part [Usage](https://github.com/City-of-Helsinki/helfi-test-automation-python#usage)

## Running local tests in CI -like container
Robot Framework container shell can be opened by running command 

      make robo-shell
in kymp/sote root. To run tests in similar environment than CI instane is.

Testcase runs must be started from test automation folder when using robo-shell.  (app/helfi-test-automation-python)

# Usage:
Before run check *environments/local.args* for BASE_URL -variable and make sure it matches your current instance. Also check PREFIX -variable. *Commented* lines are starting with # -character so you can ignore those.
You can run your first testcase by running (in cloned git project folder):

            robot -i BANNER -e ETUSIVU_SPESIFIC -v images_dir:robotframework-resources/screenshots/headlesschrome -v actual_dir:robotframework-reports -A ./environments/local.args -d robotframework-reports .
which will run all tests with BANNER tag. Other arguments are:
- Argument file for setting up some variables related to local environment (**optional**)
- Report folder for run logs (related to project folder root)  (**optional**)
- **-e ETUSIVU_SPESIFIC** - excludes etusivu_testcases from this run, since it has some content-types which are not supported in kymp/sote.
- **-v images_dir:robotframework-resources/screenshots/headlesschrome** and 
 **-v actual_dir:robotframework-reports** are for picture comparison(RobotEyes) to work succesfully.

For Full list of commands available run *robot --help* in command prompt
## Run profiles:
Robot Framework Uses argument files to run correct settings in CI and local runs. These settings files can be found from environments -folder

**Attention!**
If you run robot testcases in container locally (by running robo-shell mentioned in [Running local tests in CI](https://github.com/City-of-Helsinki/helfi-test-automation-python#running-local-tests-in-ci--like-container) , you must add some additional run variables in order to run tests succesfully.

      Add:
      -v BASE_URL:varnish-helfi-kymp.docker.so       (or if some other instance, modify respectively)
      -v PREFIX:/kaupunkiymparisto-ja-liikenne       (or if some other instance, modify respectively)(if instance-spesific path does not exist just leave prefix empty)
     

      Modify:
      -A ./environments/local.args -> -A ./environments/**ci**.args    (since some browser run arguments are required in container run at least with chrome)

# Docker and CI
You can use Dockerfile to create container for Robot Framework. However Dockerfile should be combined with hel-fi environment in a way that from container you can run tests against helfi web platform.

In github runs also [Pabot](https://github.com/mkorpela/pabot) is used. But it can be used in local envs also. Purpose of it is to speed up running tests by parallel execution.

      Current pabot version is  2.5.2   (4/2022)



# Useful information (For Windows Users):
### For cleaning up logs and such before each run, you can chain commands and remove the robotframework-reports folder altogether before your test run as follows (in windows):
            
            RMDIR /S /Q <full path to reports folder>
and full command example is:            
            
            RMDIR /S /Q C:\TA\helfi_python\robotframework-reports & robot -i BANNER -A ./environments/local.args -d C:\TA\helfi\robotframework-reports .

If you want to clear files from the folder only, do as follows:            


            del /S /Q <full path to reports folder>
and full command example is:

            del /S /Q C:\TA\helfi\robotframework-reports & robot -i BANNER -A ./environments/local.args -d C:\TA\helfi\robotframework-reports .

## Eclipse user tips:
You can use external tools configuration feature to run command prompt command in eclipse directly. Command prompt needs /c argument to run command through it. For example:

      /c del /S /Q C:\TA\helfi_python\robotframework-reports
      
      
You can also configure shortcut key to run tests with one keyboard button press by setting: Preferences -> General -> Keys -> Run last launched external Tool
