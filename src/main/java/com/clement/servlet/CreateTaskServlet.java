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

public class CreateTaskServlet extends HttpServlet {
    private TaskService taskService = new TaskService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String dueDateStr = request.getParameter("dueDate");
        String assignee = request.getParameter("assignee");

        if (name == null || name.trim().isEmpty() ||
            assignee == null || assignee.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/task-form.jsp?error=Please fill in required fields");
            return;
        }

        try {
            LocalDate dueDate = null;
            if (dueDateStr != null && !dueDateStr.trim().isEmpty()) {
                dueDate = LocalDate.parse(dueDateStr, DateTimeFormatter.ISO_LOCAL_DATE);
            }

            Task newTask = new Task(name.trim(), description != null ? description.trim() : "", dueDate, assignee.trim());

            HttpSession session = request.getSession(true);
            taskService.addTask(session, newTask);

            response.sendRedirect(request.getContextPath() + "/tasks");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/task-form.jsp?error=" + 
                                "Error creating task: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/task-form.jsp");
    }
}
