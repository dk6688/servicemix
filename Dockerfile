#
# Reffer to installer.sh in github for Features installer. 
#


FROM openjdk:8
MAINTAINER Deepak Kumar <dkj6688@gmail.com>
ENV SERVICEMIX_VERSION_MAJOR=7
ENV SERVICEMIX_VERSION_MINOR=0
ENV SERVICEMIX_VERSION_PATCH=1
ENV SERVICEMIX_VERSION=${SERVICEMIX_VERSION_MAJOR}.${SERVICEMIX_VERSION_MINOR}.${SERVICEMIX_VERSION_PATCH}
RUN mkdir /servicemix
RUN cd /servicemix
RUN wget https://www-us.apache.org/dist/servicemix/servicemix-${SERVICEMIX_VERSION_MAJOR}/${SERVICEMIX_VERSION}/apache-servicemix-${SERVICEMIX_VERSION}.zip; \
    unzip -d /opt apache-servicemix-${SERVICEMIX_VERSION}.zip; \
    rm -f apache-servicemix-${SERVICEMIX_VERSION}.zip; \
    ln -s /opt/apache-servicemix-${SERVICEMIX_VERSION} /opt/servicemix; \
    mkdir /deploy; \
    sed -i 's/^\(felix\.fileinstall\.dir\s*=\s*\).*$/\1\/deploy/' /opt/servicemix/etc/org.apache.felix.fileinstall-deploy.cfg; \
    sed -i 's+http://+https://+g' /opt/servicemix/etc/org.ops4j.pax.url.mvn.cfg; 

WORKDIR ["/deploy"]
EXPOSE 1099 8101 8181 61616 44444
ENTRYPOINT ["/opt/servicemix/bin/servicemix"]