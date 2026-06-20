# Clement Task Tracker

A collaborative task tracking application built with Java Servlets, JSP, and Apache Tomcat.

## Features

✅ **Create Tasks** - Add tasks with name, description, due date, and assignee  
📊 **Track Status** - Monitor task progress with automatic status updates based on due dates  
🔄 **Update & Delete** - Modify or remove tasks easily  
🔍 **Filter & Sort** - Organize tasks by status, assignee, or due date  
💾 **Persistent Storage** - Tasks are saved to file storage across sessions  
👥 **Team Collaboration** - Assign tasks and track team member responsibilities  

## Task Status Options

- **Pending** - Default status for new tasks
- **In Progress** - Task is actively being worked on
- **Completed** - Task is finished
- **On Hold** - Task is paused temporarily
- **Due Next Week** - Automatically assigned when due date is within 7 days
- **Late** - Automatically assigned when due date has passed

## Technical Stack

- **Java 11** - Core application language
- **JSP (JavaServer Pages)** - Server-side templating
- **Servlets** - HTTP request handling
- **Apache Tomcat** - Servlet container
- **Maven** - Build tool
- **Jackson** - JSON serialization/deserialization
- **Session Management** - User session-based task storage

## Project Structure

```
Clement/
├── src/main/java/com/clement/
│   ├── model/
│   │   └── Task.java                 # Task entity class
│   ├── servlet/
│   │   ├── TaskServlet.java          # Display tasks with filtering/sorting
│   │   ├── CreateTaskServlet.java    # Handle task creation
│   │   ├── UpdateTaskServlet.java    # Handle task updates
│   │   └── DeleteTaskServlet.java    # Handle task deletion
│   └── service/
│       ├── TaskService.java          # Business logic & session management
│       └── TaskFileStorage.java      # File persistence layer
├── src/main/webapp/
│   ├── index.jsp                     # Home/welcome page
│   ├── task-form.jsp                 # Task creation form
│   ├── task-list.jsp                 # Task list with filters
│   └── WEB-INF/
│       └── web.xml                   # Deployment descriptor
├── pom.xml                           # Maven configuration
└── target/
    └── Clement.war                   # Compiled WAR package
```

## Building the Application

### Prerequisites
- Java 11 or higher
- Maven 3.6+

### Build Steps

```bash
# Navigate to the project directory
cd /workspaces/T-ches_Collaboratif

# Clean and build the WAR file
mvn clean package -DskipTests

# Output: target/Clement.war
```

## Deployment to Apache Tomcat

### Manual Deployment

1. **Copy WAR file to Tomcat**
   ```bash
   cp target/Clement.war $CATALINA_HOME/webapps/
   ```
   Where `$CATALINA_HOME` is your Tomcat installation directory (e.g., `/usr/local/tomcat`)

2. **Start Tomcat**
   ```bash
   $CATALINA_HOME/bin/startup.sh   # Unix/Linux/macOS
   # or
   %CATALINA_HOME%\bin\startup.bat # Windows
   ```

3. **Access the application**
   - Local: `http://localhost:8080/Clement`
   - AWS EC2: `http://ec2-35-180-71-137.eu-west-3.compute.amazonaws.com/Clement`

### Using Maven Plugin

Deploy directly from Maven:
```bash
mvn tomcat7:deploy
# or
mvn tomcat7:redeploy  # If already deployed
```

*Note: Requires Tomcat manager configuration in `~/.m2/settings.xml`*

## Configuration

### File Storage Location

Tasks are persisted to: `~/.clement-tasks/tasks.json`

This directory is automatically created on first run. To back up your tasks:
```bash
cp ~/.clement-tasks/tasks.json backup/
```

### Session Management

- Session timeout: 30 minutes (configurable in web.xml)
- Tasks are loaded from disk on session initialization
- Changes are immediately persisted to disk

## Usage

### Creating a Task

1. Click **"+ Create Task"** button
2. Fill in task details:
   - **Task Name** (required)
   - Description (optional)
   - Due Date (optional)
   - Assignee (required)
3. Click **"Create Task"**

### Managing Tasks

- **View All Tasks**: Click "View Tasks" or access `/tasks`
- **Edit Task**: Click "Edit" on any task card and modify details
- **Delete Task**: Click "Delete" on any task card (with confirmation)
- **Filter by Status**: Select status from dropdown and click "Apply Filters"
- **Filter by Assignee**: Select assignee from dropdown and click "Apply Filters"
- **Sort Tasks**: Choose sort option (Due Date, Creation Date, Status)

### Task Status Auto-Update

Task statuses automatically update based on due dates:
- If today > due date → **Late**
- If today is within 7 days before due date → **Due Next Week**
- Otherwise → **Pending** (or manually set status)

## Development

### Local Testing

1. Build the project:
   ```bash
   mvn clean package -DskipTests
   ```

2. Deploy to local Tomcat and access at:
   ```
   http://localhost:8080/Clement
   ```

3. Check logs for any issues:
   ```bash
   tail -f $CATALINA_HOME/logs/catalina.out
   ```

### Modifying the Code

The project uses standard Maven structure. After making changes:

1. **Recompile**:
   ```bash
   mvn compile
   ```

2. **Rebuild WAR**:
   ```bash
   mvn clean package -DskipTests
   ```

3. **Redeploy**:
   ```bash
   cp target/Clement.war $CATALINA_HOME/webapps/
   # Tomcat will auto-deploy the new WAR file
   ```

## Troubleshooting

### Tasks Not Persisting
- Check that `~/.clement-tasks/` directory is writable
- Check Tomcat logs for file I/O errors
- Verify JSON file format at `~/.clement-tasks/tasks.json`

### Session Issues
- Clear browser cookies and restart Tomcat
- Check session timeout settings in `web.xml`
- Verify `CATALINA_HOME` environment variable is set

### Port Already in Use
If port 8080 is already in use, configure Tomcat to use a different port in `$CATALINA_HOME/conf/server.xml`:
```xml
<Connector port="8081" protocol="HTTP/1.1" />
```

## Future Enhancements

- Database integration (MySQL/PostgreSQL)
- User authentication and authorization
- Task comments and activity log
- Email notifications for due dates
- Task attachments
- Recurring tasks
- Team/project management
- REST API

## License

MIT License - Feel free to use and modify

## Support

For issues or questions, please check:
1. Tomcat logs: `$CATALINA_HOME/logs/`
2. Browser console for JavaScript errors
3. Task file at `~/.clement-tasks/tasks.json`

## to start server

```
chmod +x apache-tomcat-9.0.56/bin/*.sh
./apache-tomcat-9.0.56/bin/startup.sh
```