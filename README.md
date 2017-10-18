# custom-mvn-plugin
Testing sample mvn plugin using annotations

3 projects :
Customdeploy : contains Mojo, custom maven plugin, and xslt as a resource
parent-project : Maven parent containing configuration for xslt processing, resource mapping
test-customdeploy : Business Project, child of parent-project, containing source xml to be processed by xslt


#To run
mvn clean install on each.

