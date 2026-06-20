<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.clement.model.Task" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task List - Clement Task Tracker</title>
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
            margin-bottom: 30px;
        }

        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }

        .nav {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
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

        .filters-card {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            margin-bottom: 20px;
        }

        .filter-group {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 15px;
        }

        .filter-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 5px;
            color: #333;
        }

        .filter-group select {
            width: 100%;
            padding: 10px;
            border: 2px solid #e0e0e0;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
        }

        .filter-group select:focus {
            outline: none;
            border-color: #667eea;
        }

        .filter-buttons {
            display: flex;
            gap: 10px;
        }

        .filter-buttons button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
        }

        .filter-buttons .btn-apply {
            background-color: #4CAF50;
            color: white;
            flex: 1;
        }

        .filter-buttons .btn-apply:hover {
            background-color: #45a049;
            transform: translateY(-2px);
        }

        .filter-buttons .btn-clear {
            background-color: #999;
            color: white;
            flex: 1;
        }

        .filter-buttons .btn-clear:hover {
            background-color: #777;
            transform: translateY(-2px);
        }

        .tasks-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .task-card {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            border-left: 5px solid #667eea;
            transition: all 0.3s;
        }

        .task-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }

        .task-name {
            font-size: 1.3em;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
        }

        .task-description {
            color: #666;
            font-size: 0.95em;
            margin-bottom: 12px;
            line-height: 1.4;
        }

        .task-meta {
            font-size: 0.85em;
            color: #999;
            margin-bottom: 10px;
        }

        .task-status {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
            margin-bottom: 12px;
            font-size: 0.85em;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-in-progress {
            background-color: #cfe2ff;
            color: #084298;
        }

        .status-completed {
            background-color: #d1e7dd;
            color: #0f5132;
        }

        .status-on-hold {
            background-color: #f8d7da;
            color: #842029;
        }

        .status-due-next-week {
            background-color: #ffeaea;
            color: #a82a2a;
        }

        .status-late {
            background-color: #f8d7da;
            color: #842029;
            font-weight: bold;
        }

        .task-assignee {
            font-weight: 600;
            color: #667eea;
            margin-bottom: 12px;
        }

        .task-actions {
            display: flex;
            gap: 8px;
            margin-top: 15px;
        }

        .btn-action {
            flex: 1;
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            font-size: 0.9em;
            transition: all 0.3s;
            text-decoration: none;
            text-align: center;
        }

        .btn-edit {
            background-color: #2196F3;
            color: white;
        }

        .btn-edit:hover {
            background-color: #0b7dda;
            transform: translateY(-2px);
        }

        .btn-delete {
            background-color: #f44336;
            color: white;
        }

        .btn-delete:hover {
            background-color: #da190b;
            transform: translateY(-2px);
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .empty-state h2 {
            color: #999;
            margin-bottom: 10px;
        }

        .empty-state p {
            color: #bbb;
            margin-bottom: 20px;
        }

        .error {
            color: #e74c3c;
            background-color: #fadbd8;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #e74c3c;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal.show {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
            max-width: 600px;
            width: 90%;
        }

        .modal-header {
            font-size: 1.5em;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .modal-body {
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
            color: #333;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 2px solid #e0e0e0;
            border-radius: 5px;
            font-size: 14px;
            font-family: inherit;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
        }

        .modal-buttons {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }

        .modal-buttons button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
        }

        .btn-save {
            background-color: #4CAF50;
            color: white;
        }

        .btn-save:hover {
            background-color: #45a049;
        }

        .btn-cancel {
            background-color: #999;
            color: white;
        }

        .btn-cancel:hover {
            background-color: #777;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📋 Task List</h1>
            <p>Manage and track all your project tasks</p>
        </div>

        <div class="nav">
            <a href="<%= request.getContextPath() %>/index.jsp" class="btn-secondary">Home</a>
            <a href="<%= request.getContextPath() %>/task-form.jsp" class="btn-primary">+ Create Task</a>
        </div>

        <%
            String error = request.getParameter("error");
            if (error != null && !error.isEmpty()) {
        %>
            <div class="error">
                <%= error %>
            </div>
        <%
            }

            @SuppressWarnings("unchecked")
            List<Task> tasks = (List<Task>) request.getAttribute("tasks");
            @SuppressWarnings("unchecked")
            List<String> assignees = (List<String>) request.getAttribute("assignees");
            @SuppressWarnings("unchecked")
            List<String> statuses = (List<String>) request.getAttribute("statuses");
            String currentFilterStatus = (String) request.getAttribute("currentFilterStatus");
            String currentFilterAssignee = (String) request.getAttribute("currentFilterAssignee");
            String currentSort = (String) request.getAttribute("currentSort");
        %>

        <div class="filters-card">
            <h3 style="margin-bottom: 15px;">Filters & Sorting</h3>
            <form method="get" action="<%= request.getContextPath() %>/tasks">
                <div class="filter-group">
                    <div>
                        <label for="status">Filter by Status</label>
                        <select id="status" name="status">
                            <option value="">-- All Statuses --</option>
                            <%
                                if (statuses != null) {
                                    for (String status : statuses) {
                            %>
                                        <option value="<%= status %>" <%= (currentFilterStatus != null && currentFilterStatus.equals(status)) ? "selected" : "" %>>
                                            <%= status %>
                                        </option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div>
                        <label for="assignee">Filter by Assignee</label>
                        <select id="assignee" name="assignee">
                            <option value="">-- All Assignees --</option>
                            <%
                                if (assignees != null) {
                                    for (String assignee : assignees) {
                            %>
                                        <option value="<%= assignee %>" <%= (currentFilterAssignee != null && currentFilterAssignee.equals(assignee)) ? "selected" : "" %>>
                                            <%= assignee %>
                                        </option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div>
                        <label for="sortBy">Sort By</label>
                        <select id="sortBy" name="sortBy">
                            <option value="">-- Default --</option>
                            <option value="dueDate" <%= (currentSort != null && currentSort.equals("dueDate")) ? "selected" : "" %>>Due Date</option>
                            <option value="creationDate" <%= (currentSort != null && currentSort.equals("creationDate")) ? "selected" : "" %>>Creation Date</option>
                            <option value="status" <%= (currentSort != null && currentSort.equals("status")) ? "selected" : "" %>>Status</option>
                        </select>
                    </div>
                </div>

                <div class="filter-buttons">
                    <button type="submit" class="btn-apply">Apply Filters</button>
                    <button type="button" class="btn-clear" onclick="window.location.href='<%= request.getContextPath() %>/tasks'">Clear Filters</button>
                </div>
            </form>
        </div>

        <%
            if (tasks == null || tasks.isEmpty()) {
        %>
            <div class="empty-state">
                <h2>📭 No Tasks Yet</h2>
                <p>Create your first task to get started!</p>
                <a href="<%= request.getContextPath() %>/task-form.jsp" class="btn-primary" style="padding: 12px 25px; border-radius: 5px; text-decoration: none; display: inline-block;">Create First Task</a>
            </div>
        <%
            } else {
        %>
            <div class="tasks-grid">
                <%
                    for (Task task : tasks) {
                        String statusClass = "status-pending";
                        if ("In Progress".equals(task.getStatus())) {
                            statusClass = "status-in-progress";
                        } else if ("Completed".equals(task.getStatus())) {
                            statusClass = "status-completed";
                        } else if ("On Hold".equals(task.getStatus())) {
                            statusClass = "status-on-hold";
                        } else if ("Due Next Week".equals(task.getStatus())) {
                            statusClass = "status-due-next-week";
                        } else if ("Late".equals(task.getStatus())) {
                            statusClass = "status-late";
                        }
                %>
                    <div class="task-card">
                        <div class="task-name"><%= task.getName() %></div>
                        <% if (task.getDescription() != null && !task.getDescription().isEmpty()) { %>
                            <div class="task-description"><%= task.getDescription() %></div>
                        <% } %>
                        <div class="task-assignee">👤 <%= task.getAssignee() %></div>
                        <div class="task-status <%= statusClass %>"><%= task.getStatus() %></div>
                        <div class="task-meta">
                            <div>📅 Created: <%= task.getCreationDate() %></div>
                            <% if (task.getDueDate() != null) { %>
                                <div>⏰ Due: <%= task.getDueDate() %></div>
                            <% } %>
                        </div>
                        <div class="task-actions">
                            <button type="button" class="btn-action btn-edit" onclick="editTask('<%= task.getId() %>', '<%= task.getName().replace("'", "\\'") %>', '<%= task.getDescription() != null ? task.getDescription().replace("'", "\\'") : "" %>', '<%= task.getDueDate() %>', '<%= task.getAssignee().replace("'", "\\'") %>', '<%= task.getStatus() %>')">Edit</button>
                            <form action="<%= request.getContextPath() %>/delete-task" method="POST" style="flex: 1; margin: 0;">
                                <input type="hidden" name="id" value="<%= task.getId() %>">
                                <button type="submit" class="btn-action btn-delete" onclick="return confirm('Are you sure you want to delete this task?');">Delete</button>
                            </form>
                        </div>
                    </div>
                <%
                    }
                %>
            </div>
        <%
            }
        %>
    </div>

    <!-- Edit Task Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">Edit Task</div>
            <form id="editForm" action="<%= request.getContextPath() %>/update-task" method="POST">
                <input type="hidden" id="taskId" name="id">
                <div class="form-group">
                    <label for="editName">Task Name *</label>
                    <input type="text" id="editName" name="name" required>
                </div>
                <div class="form-group">
                    <label for="editDescription">Description</label>
                    <textarea id="editDescription" name="description"></textarea>
                </div>
                <div class="form-group">
                    <label for="editDueDate">Due Date</label>
                    <input type="date" id="editDueDate" name="dueDate">
                </div>
                <div class="form-group">
                    <label for="editAssignee">Assignee *</label>
                    <input type="text" id="editAssignee" name="assignee" required>
                </div>
                <div class="form-group">
                    <label for="editStatus">Status</label>
                    <select id="editStatus" name="status">
                        <option value="">-- Select Status --</option>
                        <option value="Pending">Pending</option>
                        <option value="In Progress">In Progress</option>
                        <option value="Completed">Completed</option>
                        <option value="On Hold">On Hold</option>
                        <option value="Due Next Week">Due Next Week</option>
                        <option value="Late">Late</option>
                    </select>
                </div>
                <div class="modal-buttons">
                    <button type="button" class="btn-cancel" onclick="closeEditModal()">Cancel</button>
                    <button type="submit" class="btn-save">Save Changes</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function editTask(id, name, description, dueDate, assignee, status) {
            document.getElementById('taskId').value = id;
            document.getElementById('editName').value = name;
            document.getElementById('editDescription').value = description;
            document.getElementById('editDueDate').value = dueDate;
            document.getElementById('editAssignee').value = assignee;
            document.getElementById('editStatus').value = status;
            document.getElementById('editModal').classList.add('show');
        }

        function closeEditModal() {
            document.getElementById('editModal').classList.remove('show');
        }

        window.onclick = function(event) {
            var modal = document.getElementById('editModal');
            if (event.target == modal) {
                modal.classList.remove('show');
            }
        }
    </script>
</body>
</html>
