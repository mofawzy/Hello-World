FROM hub.docker.hpecorp.net/daimler/masterpl-java:v5

LABEL maintainer="Daimler P10 AMS" app="mpl-backend" app_version=${Version} 

ADD masterpl.jar /opt/

RUN \
mkdir -p /opt/masterpl/pl_files &&\
mkdir -p /opt/tomcat-mpl &&\
mv /opt/masterpl.jar /opt/tomcat-mpl/ &&\
useradd -ms /bin/bash -u 10001 webpl &&\
chown  webpl /opt &&\
chown  webpl /opt/masterpl &&\
chown -R webpl /opt/masterpl/pl_files &&\
chown -R webpl /opt/tomcat-mpl &&\
chown -R webpl /opt/jdk1.8.0_144

ENV CATALINA_HOME /opt/tomcat-mpl

# Set the locale
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

 EXPOSE 8080 8081 8009 10250 10251
 USER webpl

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

 WORKDIR /opt

CMD ["java","-jar","/opt/tomcat-mpl/masterpl.jar"]
