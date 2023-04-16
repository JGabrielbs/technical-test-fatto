package com.example.listtasksactivity.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import com.example.listtasksactivity.model.ErrorMessage;
import com.example.listtasksactivity.model.ErrorResponse;
import jakarta.validation.ValidationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import com.example.listtasksactivity.model.Task;

import com.example.listtasksactivity.service.ITaskService;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class TaskController {
    
    @Autowired
    private ITaskService taskService;

    String taskName;
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        // Date - dd/MM/yyyy
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
    }

    @RequestMapping(value = "/get-task", method = RequestMethod.GET)
    @ResponseBody
    public Optional<Task> showTask(@RequestParam long id, ModelMap model) {
        Optional<Task> task = taskService.getTaskById(id);
        return task;
    }

    @RequestMapping(value = "/list-tasks", method = RequestMethod.GET)
    public String showTasks(ModelMap model, RedirectAttributes attributes) {
        model.addAttribute("tasks",  taskService.getAllTasks());
        model.addAttribute("newTask", new Task());
        attributes.addFlashAttribute("message");
        return "list-tasks";
    }


    @RequestMapping(value = "/add-task", method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView addTask(ModelMap model, @ModelAttribute("newTask") Task task, BindingResult result) {
        ModelAndView modelAndView = new ModelAndView("redirect:list-tasks");
        if(!taskService.existsByNameAndNotId(task.getTaskName(), task.getId())) {
            task.setOrdenationPosition(taskService.getNextOrdenationPosition());
            taskService.saveTask(task);
            return modelAndView;
        } else {
            modelAndView.addObject("message", "Oops, parece que você já possui uma tarefa com esse nome.");
            return modelAndView;
        }
    }

    @RequestMapping(value = "/delete-task", method = RequestMethod.GET)
    public String deleteTask(@RequestParam long id) {
        taskService.deleteTask(id);
        return "redirect:list-tasks";
    }

    @RequestMapping(value = "/update-task", method = RequestMethod.POST)
    public ResponseEntity<String> updateTask(@RequestBody Task task, BindingResult result) {
        if (result.hasErrors()) {
            throw new ValidationException("Requisição Inválida.");
        } else if(taskService.existsByNameAndNotId(task.getTaskName(), task.getId())){
            throw new ValidationException("Oops, parece que você já possui uma tarefa com esse nome.");
        } else {
            taskService.updateTask(task);
        }
        return ResponseEntity.ok().build();
    }

    @RequestMapping(value = "/order-task", method = RequestMethod.POST)
    public String orderTask(@RequestParam long id, @RequestParam  String operation) {
        Task task = taskService.getTaskById(id).orElse(null);
        taskService.orderTask(task, operation);
        return "redirect:list-tasks";
    }

    @ExceptionHandler(ValidationException.class)
    public ResponseEntity<ErrorResponse> handleValidationException(ValidationException ex) {
        ErrorResponse errorResponse = new ErrorResponse(HttpStatus.BAD_REQUEST.value(), ex.getMessage(), LocalDateTime.now());
        System.out.println(errorResponse.getMessage());
        return new ResponseEntity<>(errorResponse, HttpStatus.BAD_REQUEST);
    }

}
