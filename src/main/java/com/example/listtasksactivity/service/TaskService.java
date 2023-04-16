package com.example.listtasksactivity.service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.example.listtasksactivity.model.Task;
import com.example.listtasksactivity.repository.TaskRepository;


@Service
public class TaskService implements ITaskService {

    @Autowired
    private TaskRepository taskRepository;

    @Override
    public List < Task > getAllTasks() { 
        return taskRepository.findAll(Sort.by(Sort.Direction.ASC, "ordenationPosition"));
    }
    
    public Optional<Task> getTaskById(long id){
        return taskRepository.findById(id);
    }

    @Override
    public void updateTask(Task task) {
        taskRepository.save(task);
    }

    @Override
    public void addTask(String taskName, Double taskCost, Date targetDate, int ordenationPosition) {
        taskRepository.save(new Task(taskName, taskCost, targetDate, ordenationPosition));  
    }

    @Override
    public void deleteTask(long id) {
        Optional < Task > todo = taskRepository.findById(id);
        if (todo.isPresent()) {
            taskRepository.delete(todo.get());
        }
    }

    @Override
    public void saveTask(Task todo) {
        taskRepository.save(todo);
    }

    @Override
    public boolean existsByNameAndNotId(String name, long id) {
       return taskRepository.existsByNomeAndNotId(name, id);
    }

    public boolean existsByName(String name) {
        return taskRepository.existsByNome(name);
    }

    public int getNextOrdenationPosition(){ return taskRepository.getNextOrdenationPosition(); }

    public void orderTask(Task task, String operation){
        int taskPosition = task.getOrdenationPosition();
        long position = 0;
        if("down".equals(operation)){
            position = task.getOrdenationPosition() + 1;
        }
        if("up".equals(operation)){
            position = task.getOrdenationPosition() - 1;
        }
        long idTaskToReplace = taskRepository.findTarget(position);
        Optional<Task> taskToReplace = getTaskById(idTaskToReplace);
        task.setOrdenationPosition(taskToReplace.get().getOrdenationPosition());
        taskRepository.save(task);
        taskToReplace.get().setOrdenationPosition(taskPosition);
        taskRepository.save(taskToReplace.orElse(null));
    }

}