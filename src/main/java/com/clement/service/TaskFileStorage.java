package com.clement.service;

import com.clement.model.Task;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class TaskFileStorage {
    private static final String STORAGE_DIR = System.getProperty("user.home") + File.separator + ".clement-tasks";
    private static final String TASKS_FILE = STORAGE_DIR + File.separator + "tasks.json";
    private static final ObjectMapper objectMapper = new ObjectMapper();

    static {
        objectMapper.registerModule(new JavaTimeModule());
        objectMapper.configure(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS, false);
    }

    public TaskFileStorage() {
        ensureStorageDirectoryExists();
    }

    private static void ensureStorageDirectoryExists() {
        try {
            Files.createDirectories(Paths.get(STORAGE_DIR));
        } catch (IOException e) {
            System.err.println("Error creating storage directory: " + e.getMessage());
        }
    }

    public void saveTasks(List<Task> tasks) {
        try {
            objectMapper.writerWithDefaultPrettyPrinter().writeValue(new File(TASKS_FILE), tasks);
        } catch (IOException e) {
            System.err.println("Error saving tasks to file: " + e.getMessage());
        }
    }

    public List<Task> loadTasks() {
        File file = new File(TASKS_FILE);

        if (!file.exists()) {
            return new ArrayList<>();
        }

        try {
            Task[] tasksArray = objectMapper.readValue(file, Task[].class);
            return new ArrayList<>(Arrays.asList(tasksArray));
        } catch (IOException e) {
            System.err.println("Error loading tasks from file: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    public void deleteTasksFile() {
        File file = new File(TASKS_FILE);
        if (file.exists()) {
            file.delete();
        }
    }
}
