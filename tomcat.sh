yum install java-17-amazon-corretto -y

# Use stable version from archive (no 404)
VERSION=9.0.82

wget https://archive.apache.org/dist/tomcat/tomcat-9/v$VERSION/bin/apache-tomcat-$VERSION.tar.gz

tar -zxvf apache-tomcat-$VERSION.tar.gz

# Add roles & user (SAFE way)
sed -i '/<\/tomcat-users>/i \
<role rolename="manager-gui"/>\
<role rolename="manager-script"/>\
<user username="tomcat" password="admin@123" roles="manager-gui,manager-script"/>' apache-tomcat-$VERSION/conf/tomcat-users.xml

# Remove remote access restriction
sed -i 's/<Valve className="org.apache.catalina.valves.RemoteAddrValve".*\/>//' apache-tomcat-$VERSION/webapps/manager/META-INF/context.xml

# Start Tomcat
sh apache-tomcat-$VERSION/bin/startup.sh
