package com.clement.model;

import java.io.Serializable;
import java.time.LocalDate;

public class Task implements Serializable {
    private static final long serialVersionUID = 1L;

    private String id;
    private String name;
    private String description;
    private String status;
    private LocalDate creationDate;
    private LocalDate dueDate;
    private String assignee;

    public Task() {
    }

    public Task(String name, String description, LocalDate dueDate, String assignee) {
        this.id = generateId();
        this.name = name;
        this.description = description;
        this.creationDate = LocalDate.now();
        this.dueDate = dueDate;
        this.assignee = assignee;
        this.status = determineStatus();
    }

    public static String generateId() {
        return System.currentTimeMillis() + "_" + (int)(Math.random() * 10000);
    }

    public void updateStatus() {
        this.status = determineStatus();
    }

    private String determineStatus() {
        // If status is manually set to "Completed" or "On Hold", keep it
        if ("Completed".equals(this.status) || "On Hold".equals(this.status)) {
            return this.status;
        }

        LocalDate today = LocalDate.now();
        if (dueDate == null) {
            return "Pending";
        }

        if (today.isAfter(dueDate)) {
            return "Late";
        } else if (today.isAfter(dueDate.minusDays(7)) && today.isBefore(dueDate)) {
            return "Due Next Week";
        } else {
            return "Pending";
        }
    }

    // Getters
    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public String getStatus() {
        return status;
    }

    public LocalDate getCreationDate() {
        return creationDate;
    }

    public LocalDate getDueDate() {
        return dueDate;
    }

    public String getAssignee() {
        return assignee;
    }

    // Setters
    public void setId(String id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setCreationDate(LocalDate creationDate) {
        this.creationDate = creationDate;
    }

    public void setDueDate(LocalDate dueDate) {
        this.dueDate = dueDate;
        updateStatus();
    }

    public void setAssignee(String assignee) {
        this.assignee = assignee;
    }

    @Override
    public String toString() {
        return "Task{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", status='" + status + '\'' +
                ", creationDate=" + creationDate +
                ", dueDate=" + dueDate +
                ", assignee='" + assignee + '\'' +
                '}';
    }
}
