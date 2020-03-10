# How to deploy spring-MVC project on Docker.
This repository contains a basic implementation of CRUD application in spring-mvc, Hibernate and mysql along with a Docker file to build a Docker image out of it.

*To follow up with the steps, you must have all the softwares and tools installed in your matchine.*


## Prerequisits
You are required to have these tools before you start with using the source code
- [JDK 1.8](https://www.oracle.com/java/technologies/javase-downloads.html)
- [MAVEN](https://maven.apache.org/download.cgi)
- [MYSQL](https://docs.oracle.com/cd/E19078-01/mysql/mysql-workbench/wb-installing.html)
- [DOCKER](https://hub.docker.com/editions/community/docker-ce-desktop-windows/)
- [GIT](https://git-scm.com/downloads)
- [IDE (Recommended Intellij Idea)](https://www.jetbrains.com/idea/download/)

**If you are running Windows 10 Home Basics then follow up [this](https://medium.com/@mbyfieldcameron/docker-on-windows-10-home-edition-c186c538dff3) to install DOCKER.**

### Setup code base.

Once you have all the above software setup then follow the below steps to deploy your first application to Docker.

1. **clone this repository.**
```
$ git clone https://github.com/mayankraghuwanshi/how_to_deploy_spring_mvc_project_on_docker.git
```

2. **Move to this newly created directory and install all the dependencies using mvn command.**
```
$ cd /how_to_deploy_spring_mvc_project_on_docker
$ mvn clean install
```
3. **Now we will create a database named schooldb and a table named students with id, first_name, last_name, grade as attributes.**

```
$ mysql -u root -p
$ password *******
$ mysql> CREATE DATABASE schooldb;
$ mysql> USE DATABASE schooldb;
```
```mysql
CREATE TABLE students
(
        id INT PRIMARY KEY AUTO_INCREMENT,
        first_name VARCHAR(13),
        last_name  VARCHAR(13),
        grade INT
);
```

4. **Now its time to create Docker file and perform the following steps.**
- install apache tomcat inside Docker
```dockerfile
FROM tomcat:8.0.51-jre8-alpine
```
- copy SpringMVCCRUDApp.war to webapp directory inside tomcat as ROOT.war 
ROOT.war will set application context to "/"
.
```dockerfile
RUN rm -rf /usr/local/tomcat/webapps/*
COPY ./target/SpringMVCCRUDApp.war /usr/local/tomcat/webapps/ROOT.war
```
- create conf directory and move all resources there.
```dockerfile
RUN mkdir conf
COPY src/main/resources/conf/application.properties /conf/
COPY src/main/resources/conf/messages.properties /conf/
```
- Now to cross check if we have successfully moved files to conf, list files inside the conf directory.
```dockerfile
RUN ls /conf/
```

- copy context.xml file to tomcat directory to provide connection to jdbc:mysql
```dockerfile
RUN rm /usr/local/tomcat/conf/context.xml
COPY ./context.xml /usr/local/tomcat/conf/
```
- Run catalina.sh run command to start the tomcat server.
```dockerfile
CMD ["catalina.sh", "run"]
```
- Finally your file will look like this.
```dockerfile
FROM tomcat:8.0.51-jre8-alpine
RUN rm -rf /usr/local/tomcat/webapps/*
COPY ./target/SpringMVCCRUDApp.war /usr/local/tomcat/webapps/ROOT.war
RUN mkdir conf
COPY src/main/resources/conf/application.properties /conf/
COPY src/main/resources/conf/messages.properties /conf/
RUN ls /conf/
RUN rm /usr/local/tomcat/conf/context.xml
COPY ./context.xml /usr/local/tomcat/conf/

CMD ["catalina.sh","run"]
```
5. **We have successfully written Docker file now Build it to make an image out of it**
```dockerfile
$ docker build -t NAME .
```
After this you will see docker performing all the steps you have written inside Docker file. to run this image we need image id.
```dockerfile
$ docker images
```
|REPOSITORY|TAG| IMAGE ID| CREATED| SIZE  |
|--------------|--------|------------|--------------|-------|
|NAME | latest | IMAGE_ID | 12 hours ago | 122 MB|

6. **Copy the Image id and run the following command to map Docker port 8080 to windows port 8080**
```
$ docker run -p8080:8080 IMAGE_ID
```

7. **BOOM The app is up running on port [8080](http://localhost:8080/) go and check it.**

# SCREEN SHOTS-

![picture](src/main/resources/screenShots/Screenshot%20(60).png)
![picture](src/main/resources/screenShots/Screenshot%20(61).png)
![picture](src/main/resources/screenShots/Screenshot%20(62).png)
![picture](src/main/resources/screenShots/Screenshot%20(63).png)
