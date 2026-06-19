<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clement - Task Tracker</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            color: white;
            margin-bottom: 40px;
        }

        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .nav {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-bottom: 30px;
        }

        .nav a, .nav button {
            padding: 12px 25px;
            border-radius: 5px;
            text-decoration: none;
            border: none;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s;
            font-weight: 600;
        }

        .nav a.btn-primary, .nav button.btn-primary {
            background-color: #4CAF50;
            color: white;
        }

        .nav a.btn-primary:hover, .nav button.btn-primary:hover {
            background-color: #45a049;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .nav a.btn-secondary, .nav button.btn-secondary {
            background-color: #2196F3;
            color: white;
        }

        .nav a.btn-secondary:hover, .nav button.btn-secondary:hover {
            background-color: #0b7dda;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .card {
            background-color: white;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            margin-bottom: 20px;
        }

        .hero {
            text-align: center;
            padding: 50px 30px;
            color: white;
        }

        .hero h2 {
            font-size: 2em;
            margin-bottom: 15px;
        }

        .hero p {
            font-size: 1.2em;
            margin-bottom: 30px;
            opacity: 0.9;
        }

        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        .feature-card {
            background-color: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 8px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .feature-card h3 {
            color: white;
            margin-bottom: 10px;
        }

        .feature-card p {
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.95em;
        }

        .footer {
            text-align: center;
            color: white;
            padding: 20px;
            opacity: 0.8;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📋 Clement Task Tracker</h1>
            <p>Collaborate and manage project tasks efficiently</p>
        </div>

        <div class="nav">
            <a href="<%= request.getContextPath() %>/tasks" class="btn-secondary">View Tasks</a>
            <a href="<%= request.getContextPath() %>/task-form.jsp" class="btn-primary">Create Task</a>
        </div>

        <div class="card hero">
            <h2>Welcome to Task Tracker</h2>
            <p>Streamline your team's workflow with a simple, intuitive task management system.</p>
            
            <div class="features">
                <div class="feature-card">
                    <h3>✅ Create Tasks</h3>
                    <p>Add tasks with names, descriptions, due dates, and assignees</p>
                </div>
                <div class="feature-card">
                    <h3>📊 Track Status</h3>
                    <p>Monitor task progress with status tracking and automatic due date alerts</p>
                </div>
                <div class="feature-card">
                    <h3>🔄 Update & Delete</h3>
                    <p>Modify task details or remove completed tasks easily</p>
                </div>
                <div class="feature-card">
                    <h3>🔍 Filter & Sort</h3>
                    <p>Organize tasks by status, assignee, or due date</p>
                </div>
                <div class="feature-card">
                    <h3>💾 Persistent Storage</h3>
                    <p>Your tasks are saved across sessions for continuity</p>
                </div>
                <div class="feature-card">
                    <h3>👥 Team Collaboration</h3>
                    <p>Assign tasks and track team member responsibilities</p>
                </div>
            </div>

            <div style="margin-top: 30px;">
                <a href="<%= request.getContextPath() %>/tasks" class="btn-primary" style="padding: 15px 40px; font-size: 1.1em;">Get Started</a>
            </div>
        </div>

        <div class="footer">
            <p>&copy; 2024 Clement Task Tracker. Built with Java, JSP & Servlets.</p>
        </div>
    </div>
</body>
</html>
