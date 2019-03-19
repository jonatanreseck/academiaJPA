package com.academiajpa.api.controller;

import com.academiajpa.api.entities.Musculo;
import com.academiajpa.api.repository.MusculoRepository;
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

@RestController
@RequestMapping("/musculo")
@CrossOrigin
public class MusculoService {

    @Autowired
    private MusculoRepository musculoRepository;

    @GetMapping
    public List<Musculo> listar() {
        return musculoRepository.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Object> especifico(@PathVariable Integer id) {
        Optional<Musculo> musculoExistente = musculoRepository.findById(id);

        if (musculoExistente.isPresent()) {
            return ResponseEntity.ok(musculoExistente.get());
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public Musculo salvar(@Valid @RequestBody Musculo musculo) {
        return musculoRepository.save(musculo);
    }

    @PutMapping("/{id}")
    public Musculo alterar(@RequestBody Musculo atualizarMusculo, @PathVariable Integer id) {
        return musculoRepository.findById(id)
                .map(musculo -> {
                    musculo.setNome(atualizarMusculo.getNome());
                    return musculoRepository.save(musculo);
                })
                .orElseGet(() -> {
                    atualizarMusculo.setId(id);
                    return musculoRepository.save(atualizarMusculo);
                });
    }

    @DeleteMapping("/{id}")
    public void apagar(@PathVariable Integer id) {
        musculoRepository.deleteById(id);
    }

}
