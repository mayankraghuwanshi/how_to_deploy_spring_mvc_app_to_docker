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