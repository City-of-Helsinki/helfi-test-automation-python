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

**7)** (optional)  In github runs also [Pabot](https://github.com/mkorpela/pabot) is used. But it can be used in local envs also. Purpose of it is to speed up running tests by parallel execution.

      Current pabot version is  2.5.2   (4/2022)
      Example run command for pabot can be found in run_all_tests.sh -file in root folder of this repository

            
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
## Different ways to run tests
Above we are running the tests with tag

      -i BANNER
which includes only tests with tag BANNER to testrun.

If we want to include multiple tags, we can do as follows.

      -i bannerANDcolumns
Note here that casing is essential. We use lower case for testtags and uppercase for operator AND. This ensures that if tag name has AND/OR , it is not interpreted as an operator instead.

If we want to exclude tests with some tags, we can do for example as follows:

      -i BANNER -e LANDINGPAGE
this exludes LANDINGPAGE tagged testcases when running BANNER testcases.

If we want to run testcase by testcase name, we do:

      -t Testcase_name
and drop the -i BANNER or whatever it is. This way robot only runs testcases with this given name.

If we want to run all the cases without restrictions. We simply leave out **-i -e -t** or others spesifying the testcases.

More information about different ways of running testcases in Robot Framework [User Guide](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#selecting-test-cases)   

# Repository structure
Folders:    

  Environments 
      
      Has argument files for running ci or local testruns. Also contains run order-files for pabot, which is used in CI. Run order had to be done because announcement testcase assertions would have failed otherwise if there were multiple announcement notifications at once in one page. There might have been also some other reasons why running announcements separately was an must.
      
  robotframework-keywords
  
      Contains files common for paragraph-tests and others. Testcases usually call files in this folder as an reference.
      
  robotframework-resources
      
      Contains textfiles, images and picture comparison screenshots which are used by the testcases.
      
  robotframework-tests
  
      Contains testcases sorted by folders:
            - drupal-helfi-etusivu   -contains etusivu-instance spesific testcases
            - drupal-helfi-platform  -contains other testcases at the moment. Also some not really instance spesific cases like cookiecompliance tests.
            
  Root folder files:
  
      -  Dockerfile     - obsolete and not supported. could be deleted :)
      -  run_all_etusivu_tests.sh    - runs all etusivu_spesific testcases. (tagged with ETUSIVU_SPESIFIC)
      -  run_all_tests.sh            - runs all tests. CI process uses this in kymp/sote merge-actions.

## Project Arguments
Arguments used in project are mostly defined in **environment** folder. *local.args* for arguments in local test runs and *ci.args* for arguments in ci-testruns.
Here are the arguments and their explanations:
   BASE_URL
      
      actually meaning domain name. , like helfi-kymp.docker.so
   PREFIX
      
      category -part of the url, like:  /kaupunkiymparisto-ja-liikenne
with PROTOCOL , there two are used to form base of the url path. You should modify these to match your local instance under test respectively
      
   BROWSER  
   
      for example:  chrome   ,for chrome browser (or headlesschrome if you want to run tests silently)
See [Open Browser](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Open%20Browser) at Seleniumlibrary API for more information about different possible values for BROWSER.

   PICCOMPARE
   
      Used to toggle picture comparison support ON/OFF. Plase note that this was never fully developed and it needs comparison pictures to be added under /robotframework-resournces/screenshots/(browser-based-folder)   in order to get this to work. 
      However please note that some Banner testcases are using picture comparison despite of this setting. This is purely developers decision and can be changed for sure.
   CI  
   
      This is false in local testruns.
   CI_LOCALTEST
   
      This was created to set true in case when tests are run from robot-container (started with 'make robo-shell' -command). Does some things differently in code for this case.
   DEBUG  
   
      This creates debug -folder under /robotframework-reports -folder. It is used to make debugging errors easier. It creates html -file of the html page in time of error and also takes two pictures. It is recommended to set this always true.
   USEORIGINALNAME  
   
      This is used with picture comparison. When screenshots of complete page content to be visually compare is created, if this setting is true, the screenshot name structure is same that is used in robotframework-resources/screenshots - where comparison pictures are. Purpose of this argument is solely to make updating comparison pictures easier.
   ADMIN_URL     
      
      Is command to run uli -which gives url -to login as admin. This is however deprecated and not in use in robotframework-code anymore.    

# CI
Testcases are run at the moment only in sote/kymp instances in event when pull request in being merged into master. You can find robot runs from Actions -tab under these instances. *However* while writing this text(12/22) there is an task underway to divide robot tests under kymp,sote, kasko etc. instances instead of this one test-automation repo, thus this information here might be a bit outdated.

# Useful -links
[SeleniumLibrary API](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#library-documentation-top) (latest version)
[Robotframework API](https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#library-documentation-top) (latest version)

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
