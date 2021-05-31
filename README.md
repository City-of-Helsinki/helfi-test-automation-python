# Installation:

In order to work with this robot framework repo locally, you need:
**1)** hel-fi environment set up and running in your machine so that you can access drupal web development platform at : https://www.xxxxxx.docker.sh  
      
      For example: helfi.docker.sh or helsinki-paatokset.docker.sh
  
**2)** IDE with robot framework support.
     
     For example: RIDE, Eclipse, Pycharm, VSCode or IntellijIdea.
    
**3)**  [Robot Framework](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#installation-instructions) Installed
    
**4)**  [DoctestLibrary](https://pypi.org/project/robotframework-doctestlibrary/) Installed.  

    needed for picture compare assertions

**5)**  [SeleniumLibrary](https://pypi.org/project/robotframework-seleniumlibrary/) Installed. 

    needed for running the testcases
            
You can propably use the latest versions of the libraries, but might need to do some small refactoring if for example same keyword would have become outdated or if some structures like classic if-else pattern is no longer supported.

Currently used (6/2021) versions are:

    Robot Framework 4.0.2
    Seleniumlibrary 5.1.3
    Doctestlibrary  0.1.2
     

