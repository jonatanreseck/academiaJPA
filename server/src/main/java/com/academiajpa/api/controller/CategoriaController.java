package com.academiajpa.api.controller;

import com.academiajpa.api.entities.Categoria;
import com.academiajpa.api.repository.CategoriaRepository;
import java.util.List;
import java.util.Optional;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/categoria")
@RestController
@CrossOrigin
public class CategoriaController {

    @Autowired
    private CategoriaRepository categoriaRepository;

    @GetMapping
    public List<Categoria> listar() {
        return categoriaRepository.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Object> especifico(@PathVariable Integer id) {
        Optional<Categoria> categoriaExistente = categoriaRepository.findById(id);

        if (categoriaExistente.isPresent()) {
            return ResponseEntity.ok(categoriaExistente.get());
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public Categoria salvar(@Valid @RequestBody Categoria categoria) {
        return categoriaRepository.save(categoria);
    }

    @PutMapping("/{id}")
    public Categoria alterar(@RequestBody Categoria atualizarCategoria, @PathVariable Integer id) {
        return categoriaRepository.findById(id)
                .map(categoria -> {
                    categoria.setExercicio(atualizarCategoria.getExercicio());
                    categoria.setMusculo(atualizarCategoria.getMusculo());
                    return categoriaRepository.save(categoria);
                })
                .orElseGet(() -> {
                    atualizarCategoria.setId(id);
                    return categoriaRepository.save(atualizarCategoria);
                });
    }

    @DeleteMapping("/{id}")
    public void apagar(@PathVariable Integer id) {
        categoriaRepository.deleteById(id);
    }

}
