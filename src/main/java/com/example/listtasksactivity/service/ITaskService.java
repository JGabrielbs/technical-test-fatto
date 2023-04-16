package com.example.listtasksactivity.service;



import java.util.Date;
import java.util.List;
import java.util.Optional;

import com.example.listtasksactivity.model.Task;

public interface ITaskService {

    List < Task > getAllTasks();

    void updateTask(Task todo);

    void addTask(String taskName, Double taskCost, Date targetDate, int ordenationPosition);

    void deleteTask(long id);

    void saveTask(Task task);

    Optional<Task> getTaskById(long id);

    boolean existsByNameAndNotId(String name, long id);
    boolean existsByName(String name);

    int getNextOrdenationPosition();

    void orderTask(Task task, String operation);

}