package com.example.listtasksactivity.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.listtasksactivity.model.Task;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface TaskRepository extends JpaRepository < Task, Long > {

    @Query("SELECT COUNT(t) > 0 FROM Task t WHERE t.taskName = :name AND t.id <> :id")
    boolean existsByNomeAndNotId(@Param("name") String name, @Param("id") Long id);

    @Query("SELECT COUNT(t) > 0 FROM Task t WHERE t.taskName = :nome")
    boolean existsByNome(@Param("nome") String nome);

    @Query(value ="SELECT coalesce(max(t.ordenation_position), 0) + 1 as id FROM Task t", nativeQuery = true)
    int getNextOrdenationPosition();

    @Query(value ="SELECT t.id FROM Task t where t.ordenation_position = :position", nativeQuery = true)
    int findTarget(Long position);


}