# Quick Deployment Guide

## TL;DR - Get Started in 5 Minutes

### 1. Build the Application
```bash
cd /workspaces/T-ches_Collaboratif
mvn clean package -DskipTests
```
✅ Output: `target/Clement.war` (2.2 MB)

### 2. Deploy to Tomcat
```bash
cp target/Clement.war /path/to/tomcat/webapps/
```

### 3. Start Tomcat
```bash
/path/to/tomcat/bin/startup.sh
```

### 4. Access Application
- **Local**: http://localhost:8080/Clement
- **AWS EC2**: http://ec2-35-180-71-137.eu-west-3.compute.amazonaws.com/Clement

---

## Detailed Deployment Steps

### Prerequisites
- Java 11+ installed and JAVA_HOME set
- Apache Tomcat 8.5+ installed
- Maven 3.6+ installed

### Step 1: Build the Project
```bash
cd /workspaces/T-ches_Collaboratif
mvn clean package -DskipTests
```

Expected output:
```
[INFO] Building war: /workspaces/T-ches_Collaboratif/target/Clement.war
[INFO] BUILD SUCCESS
```

### Step 2: Deploy WAR to Tomcat

#### Option A: Auto-Deploy (Recommended)
Copy the WAR file to Tomcat's webapps directory:
```bash
export CATALINA_HOME=/path/to/apache-tomcat
cp target/Clement.war $CATALINA_HOME/webapps/
```

Tomcat will automatically extract and deploy the application to `/Clement` context path.

#### Option B: Manual Deployment
1. Stop Tomcat: `$CATALINA_HOME/bin/shutdown.sh`
2. Copy WAR file: `cp target/Clement.war $CATALINA_HOME/webapps/`
3. Start Tomcat: `$CATALINA_HOME/bin/startup.sh`

#### Option C: Using Maven (Advanced)
Configure in `~/.m2/settings.xml`:
```xml
<server>
  <id>TomcatServer</id>
  <username>admin</username>
  <password>admin</password>
</server>
```

Then run:
```bash
mvn tomcat7:deploy
```

### Step 3: Verify Deployment

#### Check if Tomcat is Running
```bash
ps aux | grep tomcat
# or
curl -s http://localhost:8080/manager/html
```

#### Check Application Status
```bash
# Check if WAR is deployed
ls -la $CATALINA_HOME/webapps/ | grep Clement

# Check if extracted
ls -la $CATALINA_HOME/webapps/Clement/

# View Tomcat logs
tail -f $CATALINA_HOME/logs/catalina.out
tail -f $CATALINA_HOME/logs/localhost.log
```

#### Access the Application
Open in browser:
- **http://localhost:8080/Clement** (Local)
- **http://ec2-35-180-71-137.eu-west-3.compute.amazonaws.com/Clement** (AWS EC2)

Expected: Beautiful task tracking home page with "View Tasks" and "Create Task" buttons

### Step 4: Verify Data Persistence

1. Create a few test tasks
2. Restart Tomcat:
   ```bash
   $CATALINA_HOME/bin/shutdown.sh
   sleep 5
   $CATALINA_HOME/bin/startup.sh
   ```
3. Check that tasks still appear - data persisted! ✅

---

## File Locations

### WAR File
```
/workspaces/T-ches_Collaboratif/target/Clement.war
```

### Task Storage (After First Run)
```
~/.clement-tasks/tasks.json
```

### Tomcat Logs
```
$CATALINA_HOME/logs/catalina.out
$CATALINA_HOME/logs/localhost.log
```

### Deployed Application
```
$CATALINA_HOME/webapps/Clement/
$CATALINA_HOME/webapps/Clement/task-list.jsp
$CATALINA_HOME/webapps/Clement/task-form.jsp
$CATALINA_HOME/webapps/Clement/index.jsp
```

---

## Troubleshooting

### Issue: "Port 8080 already in use"
Solution: Change Tomcat port in `$CATALINA_HOME/conf/server.xml`:
```xml
<Connector port="8081" protocol="HTTP/1.1" />
```
Then access: `http://localhost:8081/Clement`

### Issue: "Application not deploying"
1. Check Tomcat is running: `ps aux | grep tomcat`
2. Check logs: `tail -100 $CATALINA_HOME/logs/catalina.out`
3. Ensure WAR file is in webapps: `ls -la $CATALINA_HOME/webapps/Clement.war`
4. Check file permissions: `chmod 755 $CATALINA_HOME/webapps/`

### Issue: "Tasks not saving"
1. Verify directory exists: `ls -la ~/.clement-tasks/`
2. Check permissions: `ls -la ~/.clement-tasks/tasks.json`
3. Check Tomcat logs for file I/O errors

### Issue: "Session not persisting between restarts"
Tasks are stored in JSON file, not session. Restart Tomcat:
1. Stop: `$CATALINA_HOME/bin/shutdown.sh`
2. Wait 5 seconds
3. Start: `$CATALINA_HOME/bin/startup.sh`

---

## AWS EC2 Specific Notes

### SSH to EC2 Instance
```bash
ssh -i your-key.pem ec2-user@ec2-35-180-71-137.eu-west-3.compute.amazonaws.com
```

### Install Tomcat on EC2
```bash
# Update system
sudo yum update -y

# Install Java
sudo yum install java-11-openjdk -y

# Download Tomcat
wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.56/bin/apache-tomcat-9.0.56.tar.gz

# Extract
tar -xzf apache-tomcat-9.0.56.tar.gz
sudo mv apache-tomcat-9.0.56 /opt/tomcat

# Set permissions
sudo chown -R ec2-user:ec2-user /opt/tomcat

# Start Tomcat
/opt/tomcat/bin/startup.sh
```

### Deploy to EC2
```bash
# From local machine
scp -i your-key.pem target/Clement.war ec2-user@ec2-35-180-71-137.eu-west-3.compute.amazonaws.com:/opt/tomcat/webapps/

# Then SSH and restart Tomcat (if needed)
```

---

## Performance Tips

1. **Memory**: Increase Tomcat heap for better performance
   ```bash
   export CATALINA_OPTS="-Xms512m -Xmx1024m"
   $CATALINA_HOME/bin/startup.sh
   ```

2. **Session Timeout**: Configure in `WEB-INF/web.xml` (default: 30 min)
   ```xml
   <session-config>
     <cookie-config>
       <secure>false</secure>
       <http-only>true</http-only>
     </cookie-config>
   </session-config>
   ```

3. **Database**: For production, migrate from file storage to MySQL/PostgreSQL (future enhancement)

---

## Support

Questions? Check:
- Application logs: `~/.clement-tasks/tasks.json`
- Tomcat logs: `$CATALINA_HOME/logs/catalina.out`
- Browser console: Press F12 → Console tab
- README.md: Comprehensive documentation in project root
