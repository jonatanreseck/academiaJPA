package com.academiajpa.api.repository;

import com.academiajpa.api.entities.Exercicio;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ExercicioRepository extends JpaRepository<Exercicio, Integer>{
    
}
