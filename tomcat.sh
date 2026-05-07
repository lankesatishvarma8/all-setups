# Install Java
sudo yum install java-17-amazon-corretto -y

# Go to /opt
cd /opt

# Tomcat Version
VERSION=9.0.82

# Download Tomcat
sudo wget https://archive.apache.org/dist/tomcat/tomcat-9/v$VERSION/bin/apache-tomcat-$VERSION.tar.gz

# Extract
sudo tar -zxvf apache-tomcat-$VERSION.tar.gz

# Rename folder
sudo mv apache-tomcat-$VERSION tomcat

# Add Tomcat users and roles
sudo tee /opt/tomcat/conf/tomcat-users.xml > /dev/null <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<tomcat-users>

<role rolename="manager-gui"/>
<role rolename="manager-script"/>
<role rolename="admin-gui"/>

<user username="tomcat" password="admin@123" roles="manager-gui,manager-script,admin-gui"/>

</tomcat-users>
EOF

# Remove Manager remote access restriction
sudo tee /opt/tomcat/webapps/manager/META-INF/context.xml > /dev/null <<EOF
<Context antiResourceLocking="false" privileged="true">
</Context>
EOF

# Remove Host Manager remote access restriction
sudo tee /opt/tomcat/webapps/host-manager/META-INF/context.xml > /dev/null <<EOF
<Context antiResourceLocking="false" privileged="true">
</Context>
EOF

# Give permissions
sudo chmod +x /opt/tomcat/bin/*.sh

# Start Tomcat
sudo /opt/tomcat/bin/startup.sh

# Check Tomcat
ps -ef | grep tomcat
