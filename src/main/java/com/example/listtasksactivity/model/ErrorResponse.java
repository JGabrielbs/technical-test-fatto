package com.example.listtasksactivity.model;

import java.time.LocalDateTime;

public class ErrorResponse {
    private int status;
    private String message;


    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }

    private LocalDateTime timestamp;

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public ErrorResponse(int value, String mensagem, LocalDateTime now) {
        this.message = mensagem;
        this.status = value;
        this.timestamp = now;
    }
}