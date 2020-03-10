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
- IDE (Recommended Intelij Idea)

**If you are running Windows 10 Home Basics then follow up [this](https://medium.com/@mbyfieldcameron/docker-on-windows-10-home-edition-c186c538dff3) to install DOCKER.**

### Setup code base.

Once you have all these software setup then follow the below steps to deploy your first app to Docker.

1. clone this repository.
```
$ git clone https://github.com/mayankraghuwanshi/how_to_deploy_spring_mvc_project_on_docker.git
```

2. Move to this newly created directory and install all the dependencies using mvn command.
```
$ cd /how_to_deploy_spring_mvc_project_on_docker
$ mvn clean install
```
3. Now we will create a database called schooldb and make a table called students with id, first_name, last_name, grade as attributes.

```
$ mysql -u root -p
$ password *******
$ mysql> CREATE DATABASE schooldb;
$ mysql> USE DATABASE schooldb;
$ mysql> CREATE TABLE students(
       > id INT PRIMARY KEY AUTO_INCREMENT,
       > first_name VARCHAR(13),
       > last_name  VARCHAR(13),
       > grade INT);
```

4. Now its time to create Docker file and perform following steps.
- install apache tomcat
- copy SpringMVCCRUDApp.war to webapp directory inside tomcat.
- create directory and copy resource files there in Docker.
- copy context.xml file to tomcat directory to provide connection to jdbc:mysql:localhost


