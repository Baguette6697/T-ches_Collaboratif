package com.clement.service;

import com.clement.model.Task;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public class TaskService {
    private static final String TASKS_SESSION_KEY = "tasks";
    private static final TaskFileStorage fileStorage = new TaskFileStorage();

    public TaskService() {
    }

    public List<Task> initializeSession(HttpSession session) {
        List<Task> tasks = (List<Task>) session.getAttribute(TASKS_SESSION_KEY);

        if (tasks == null) {
            tasks = fileStorage.loadTasks();
            session.setAttribute(TASKS_SESSION_KEY, tasks);
        }

        return tasks;
    }

    public List<Task> getTasks(HttpSession session) {
        List<Task> tasks = (List<Task>) session.getAttribute(TASKS_SESSION_KEY);
        if (tasks == null) {
            tasks = initializeSession(session);
        }
        return tasks;
    }

    public void addTask(HttpSession session, Task task) {
        List<Task> tasks = getTasks(session);
        tasks.add(task);
        saveTasks(session, tasks);
    }

    public void updateTask(HttpSession session, String taskId, Task updatedTask) {
        List<Task> tasks = getTasks(session);
        for (int i = 0; i < tasks.size(); i++) {
            if (tasks.get(i).getId().equals(taskId)) {
                updatedTask.setId(taskId);
                tasks.set(i, updatedTask);
                break;
            }
        }
        saveTasks(session, tasks);
    }

    public void deleteTask(HttpSession session, String taskId) {
        List<Task> tasks = getTasks(session);
        tasks.removeIf(task -> task.getId().equals(taskId));
        saveTasks(session, tasks);
    }

    public Task getTaskById(HttpSession session, String taskId) {
        List<Task> tasks = getTasks(session);
        return tasks.stream()
                .filter(task -> task.getId().equals(taskId))
                .findFirst()
                .orElse(null);
    }

    public List<Task> filterByStatus(HttpSession session, String status) {
        List<Task> tasks = getTasks(session);
        return tasks.stream()
                .filter(task -> task.getStatus().equals(status))
                .collect(Collectors.toList());
    }

    public List<Task> filterByAssignee(HttpSession session, String assignee) {
        List<Task> tasks = getTasks(session);
        return tasks.stream()
                .filter(task -> task.getAssignee().equalsIgnoreCase(assignee))
                .collect(Collectors.toList());
    }

    public List<Task> filterByStatusAndAssignee(HttpSession session, String status, String assignee) {
        List<Task> tasks = getTasks(session);
        return tasks.stream()
                .filter(task -> task.getStatus().equals(status) && task.getAssignee().equalsIgnoreCase(assignee))
                .collect(Collectors.toList());
    }

    public List<Task> sortByDueDate(List<Task> tasks) {
        return tasks.stream()
                .sorted(Comparator.comparing(Task::getDueDate, Comparator.nullsLast(Comparator.naturalOrder())))
                .collect(Collectors.toList());
    }

    public List<Task> sortByCreationDate(List<Task> tasks) {
        return tasks.stream()
                .sorted(Comparator.comparing(Task::getCreationDate))
                .collect(Collectors.toList());
    }

    public List<Task> sortByStatus(List<Task> tasks) {
        return tasks.stream()
                .sorted(Comparator.comparing(Task::getStatus))
                .collect(Collectors.toList());
    }

    public List<String> getUniqueAssignees(HttpSession session) {
        List<Task> tasks = getTasks(session);
        return tasks.stream()
                .map(Task::getAssignee)
                .distinct()
                .sorted()
                .collect(Collectors.toList());
    }

    public List<String> getUniqueStatuses(HttpSession session) {
        List<Task> tasks = getTasks(session);
        return tasks.stream()
                .map(Task::getStatus)
                .distinct()
                .sorted()
                .collect(Collectors.toList());
    }

    private void saveTasks(HttpSession session, List<Task> tasks) {
        // Update task statuses based on current dates
        for (Task task : tasks) {
            task.updateStatus();
        }
        session.setAttribute(TASKS_SESSION_KEY, tasks);
        fileStorage.saveTasks(tasks);
    }

    public void clearAllTasks(HttpSession session) {
        List<Task> emptyList = new ArrayList<>();
        session.setAttribute(TASKS_SESSION_KEY, emptyList);
        fileStorage.saveTasks(emptyList);
    }
}
