package com.example.listtasksactivity.model;


import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

/**
 * @author Joao Gabriel
 *
 */

 @Entity
 @Table(name = "Task")
 public class Task { 
     @Getter @Setter    
     @Id
     @GeneratedValue(strategy = GenerationType.AUTO)
     private long id;

    private String taskName;

    private Date targetDate;

    private int ordenationPosition;
    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    private Double taskCost;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Double getTaskCost() {
        return taskCost;
    }

    public void setTaskCost(Double taskCost) {
        this.taskCost = taskCost;
    }

    public Date getTargetDate() {
        return targetDate;
    }

    public void setTargetDate(Date targetDate) {
        this.targetDate = targetDate;
    }

    public int getOrdenationPosition() {
        return ordenationPosition;
    }

    public void setOrdenationPosition(int ordenationPosition) {
        this.ordenationPosition = ordenationPosition;
    }

     public Task(String taskName, Double taskCost, Date targetDate, int ordenationPosition){

     }
     public Task(){

     }
 
 
 }