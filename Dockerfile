FROM openjdk:11
#RUN chmod 777 /opt
#RUN mkdir /opt/springboot-medilab-monolith
#WORKDIR /opt/springboot-medilab-monolith
#COPY /target/medilab-morning-preclinic-war-0.0.1-SNAPSHOT.war  ${WORKDIR}
COPY ./target/medilab-morning-preclinic-war-0.0.1-SNAPSHOT.war /usr/app
WORKDIR /usr/app
CMD [ "java","-jar","medilab-morning-preclinic-war-0.0.1-SNAPSHOT.war" ]
 