package com.clement.servlet;

import com.clement.model.Task;
import com.clement.service.TaskService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class UpdateTaskServlet extends HttpServlet {
    private TaskService taskService = new TaskService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String taskId = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String dueDateStr = request.getParameter("dueDate");
        String assignee = request.getParameter("assignee");
        String status = request.getParameter("status");

        if (taskId == null || taskId.trim().isEmpty() ||
            name == null || name.trim().isEmpty() ||
            assignee == null || assignee.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/tasks?error=Invalid task data");
            return;
        }

        try {
            HttpSession session = request.getSession(true);
            Task existingTask = taskService.getTaskById(session, taskId);

            if (existingTask == null) {
                response.sendRedirect(request.getContextPath() + "/tasks?error=Task not found");
                return;
            }

            existingTask.setName(name.trim());
            existingTask.setDescription(description != null ? description.trim() : "");
            existingTask.setAssignee(assignee.trim());

            if (dueDateStr != null && !dueDateStr.trim().isEmpty()) {
                existingTask.setDueDate(LocalDate.parse(dueDateStr, DateTimeFormatter.ISO_LOCAL_DATE));
            }

            if (status != null && !status.trim().isEmpty()) {
                existingTask.setStatus(status);
            }

            taskService.updateTask(session, taskId, existingTask);
            response.sendRedirect(request.getContextPath() + "/tasks");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/tasks?error=" + 
                                "Error updating task: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/tasks");
    }
}
