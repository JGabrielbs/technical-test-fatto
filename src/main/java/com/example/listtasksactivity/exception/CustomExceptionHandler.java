package com.example.listtasksactivity.exception;

import com.example.listtasksactivity.model.ErrorResponse;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import java.time.LocalDateTime;

@ControllerAdvice
public class CustomExceptionHandler extends ResponseEntityExceptionHandler {

    protected ResponseEntity<Object> handleMethodArgumentNotValid(
            MethodArgumentNotValidException ex, HttpHeaders headers, HttpStatus status, WebRequest request) {
        String mensagem = "Erro de validação: " + ex.getBindingResult().getFieldError().getDefaultMessage();
        ErrorResponse errorResponse = new ErrorResponse(status.value(), mensagem, LocalDateTime.now());
        return new ResponseEntity<>(errorResponse, headers, status);
    }
}
