<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.clement.model.Task" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Task - Clement Task Tracker</title>
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
            max-width: 600px;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            color: white;
            margin-bottom: 30px;
        }

        .header h1 {
            font-size: 2em;
            margin-bottom: 5px;
        }

        .card {
            background-color: white;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s;
            font-family: inherit;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-group input[type="date"] {
            cursor: pointer;
        }

        .required {
            color: #e74c3c;
        }

        .button-group {
            display: flex;
            gap: 10px;
            justify-content: space-between;
            margin-top: 30px;
        }

        button, a.btn {
            padding: 12px 25px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        .btn-primary {
            background-color: #4CAF50;
            color: white;
            flex: 1;
        }

        .btn-primary:hover {
            background-color: #45a049;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .btn-secondary {
            background-color: #999;
            color: white;
            flex: 1;
        }

        .btn-secondary:hover {
            background-color: #777;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .error {
            color: #e74c3c;
            background-color: #fadbd8;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #e74c3c;
        }

        .success {
            color: #27ae60;
            background-color: #d5f4e6;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #27ae60;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📝 Create New Task</h1>
            <p>Add a new task to your project</p>
        </div>

        <div class="card">
            <%
                String error = request.getParameter("error");
                String success = request.getParameter("success");
                if (error != null && !error.isEmpty()) {
            %>
                <div class="error">
                    <%= error %>
                </div>
            <%
                }
                if (success != null && !success.isEmpty()) {
            %>
                <div class="success">
                    Task created successfully!
                </div>
            <%
                }
            %>

            <form action="<%= request.getContextPath() %>/create-task" method="POST">
                <div class="form-group">
                    <label for="name">Task Name <span class="required">*</span></label>
                    <input type="text" id="name" name="name" placeholder="Enter task name" required maxlength="100">
                </div>

                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" placeholder="Enter task description (optional)"></textarea>
                </div>

                <div class="form-group">
                    <label for="dueDate">Due Date</label>
                    <input type="date" id="dueDate" name="dueDate">
                </div>

                <div class="form-group">
                    <label for="assignee">Assignee <span class="required">*</span></label>
                    <input type="text" id="assignee" name="assignee" placeholder="Enter assignee name" required maxlength="100">
                </div>

                <div class="button-group">
                    <button type="submit" class="btn-primary">Create Task</button>
                    <a href="<%= request.getContextPath() %>/tasks" class="btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
