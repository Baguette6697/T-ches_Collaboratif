package com.clement.servlet;

import com.clement.model.Task;
import com.clement.service.TaskService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class TaskServlet extends HttpServlet {
    private TaskService taskService = new TaskService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(true);
        taskService.initializeSession(session);

        String filterStatus = request.getParameter("status");
        String filterAssignee = request.getParameter("assignee");
        String sortBy = request.getParameter("sortBy");

        List<Task> tasks;

        if (filterStatus != null && !filterStatus.isEmpty() && 
            filterAssignee != null && !filterAssignee.isEmpty()) {
            tasks = taskService.filterByStatusAndAssignee(session, filterStatus, filterAssignee);
        } else if (filterStatus != null && !filterStatus.isEmpty()) {
            tasks = taskService.filterByStatus(session, filterStatus);
        } else if (filterAssignee != null && !filterAssignee.isEmpty()) {
            tasks = taskService.filterByAssignee(session, filterAssignee);
        } else {
            tasks = taskService.getTasks(session);
        }

        if (sortBy != null) {
            if ("dueDate".equals(sortBy)) {
                tasks = taskService.sortByDueDate(tasks);
            } else if ("creationDate".equals(sortBy)) {
                tasks = taskService.sortByCreationDate(tasks);
            } else if ("status".equals(sortBy)) {
                tasks = taskService.sortByStatus(tasks);
            }
        }

        request.setAttribute("tasks", tasks);
        request.setAttribute("assignees", taskService.getUniqueAssignees(session));
        request.setAttribute("statuses", taskService.getUniqueStatuses(session));
        request.setAttribute("currentFilterStatus", filterStatus);
        request.setAttribute("currentFilterAssignee", filterAssignee);
        request.setAttribute("currentSort", sortBy);

        request.getRequestDispatcher("/task-list.jsp").forward(request, response);
    }
}
