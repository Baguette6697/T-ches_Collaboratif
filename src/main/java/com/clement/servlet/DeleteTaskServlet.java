package com.clement.servlet;

import com.clement.service.TaskService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class DeleteTaskServlet extends HttpServlet {
    private TaskService taskService = new TaskService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String taskId = request.getParameter("id");

        if (taskId == null || taskId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/tasks?error=Invalid task ID");
            return;
        }

        try {
            HttpSession session = request.getSession(true);
            taskService.deleteTask(session, taskId);
            response.sendRedirect(request.getContextPath() + "/tasks");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/tasks?error=" + 
                                "Error deleting task: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/tasks");
    }
}
