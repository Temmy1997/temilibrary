# GRADLE 
* Gradle is an open-source build automation tool use to build almost any type of applicationn.
* Grandles is known to be flexible to build software.
* The building process incluudes compiling, linking, and packaging the code. 
* Gradle makes few assumptions about what you’re trying to build or how to build it. This makes Gradle particularly flexible.
* Java is the primary langiage in Grandle, butgrandle is known to build automastion on many languages like scala, Andriod, C/C+, Groovy. 

## Gradle Installation 
1. Check if java is installed 
   java -version
2. Download Gradle 
   wget https://services.gradle.org/distributions/gradle-3.4.1-bin.zip
3. create a directory for gradle under /opt/ and unzip the gradle package into that newly created gradle directory.
   mkdir /opt/gradle
4. Unzip the gradle packges 
   unzip -d /opt/gradle gradle-3.4.1-bin.zip
5. Configure your PATH environment variable to include the bin directory of the unzipped distribution
   export PATH=$PATH:/opt/gradle/gradle-7.6/bin
6. 