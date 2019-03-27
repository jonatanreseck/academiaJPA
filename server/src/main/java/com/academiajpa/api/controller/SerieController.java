package com.academiajpa.api.controller;

import com.academiajpa.api.entities.Pessoa;
import com.academiajpa.api.entities.Serie;
import com.academiajpa.api.repository.SerieRepository;
import java.util.List;
import java.util.Optional;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

@CrossOrigin
@RestController
@RequestMapping("/serie")
public class SerieController {
    @Autowired
    public SerieRepository dao;
    
    @GetMapping
    public List<Serie> listar() {
        return dao.findAll();
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<Serie> buscar(@PathVariable Integer id) {
        Optional<Serie> serieExistente = dao.findById(id);

        if (serieExistente.isPresent()) {
            return ResponseEntity.ok(serieExistente.get());
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Serie salvar(@Valid @RequestBody Serie serie) {
        return dao.save(serie);
    }
    
    @PutMapping("/{id}")
    Serie replaceEmployee(@RequestBody Serie newSerie, @PathVariable Integer id) {

        return dao.findById(id)
                .map(serie -> {
                    serie.setDia(newSerie.getDia());
                    serie.setExercicio(newSerie.getExercicio());
                    serie.setObs(newSerie.getObs());
                    serie.setPeso(newSerie.getPeso());
                    serie.setPessoa(newSerie.getPessoa());
                    serie.setQtdRepeticao(newSerie.getQtdRepeticao());
                    return dao.save(serie);
                })
                .orElseGet(() -> {
                    newSerie.setId(id);
                    return dao.save(newSerie);
                });
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.ACCEPTED)
    public void deletar(@PathVariable Integer id) {
        dao.deleteById(id);
    }
}
