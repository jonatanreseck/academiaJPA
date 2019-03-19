package com.academiajpa.api.repository;

import com.academiajpa.api.entities.Categoria;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoriaRepository extends JpaRepository<Categoria, Integer>{
    
}
