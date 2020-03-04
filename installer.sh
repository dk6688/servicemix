# Use this install file at the root of your project and mention it in your prject docker file while creating image. 
# Servicemix home is available at /opt/servicemix
# Servicemix deployment folder is at /deploy
# See this example given below:

# FROM dk6688/servicemix
# MAINTAINER Deepak Kumar <dkj6688@gmail.com>
# COPY installer.sh /opt/
# RUN chmod +x /opt/installer.sh
# RUN /opt/./installer.sh


# Installer script starts from here:

# start in background
/opt/servicemix/bin/./start

# run your commands 
echo "Install all the required features ..."
sleep 3s

/opt/servicemix/bin/./client "feature:install activemq-broker jndi camel-ftp camel-mail cxf-rs-security-oauth2; shutdown -f"
while [ "$?" != "0" ]; do
	sleep 5s
	/opt/servicemix/bin/./client "feature:install activemq-broker jndi camel-ftp camel-mail cxf-rs-security-oauth2; shutdown -f"
done

echo "done"
exit 0
