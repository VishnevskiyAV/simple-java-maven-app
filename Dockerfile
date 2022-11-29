FROM tomcat:9-alpine
ADD target/* /usr/local/tomcat/webapps/
RUN value=`cat conf/server.xml` && echo "${value//8080/8081}" >| conf/server.xml
CMD ["catalina.sh", "run"]