package com.academiajpa.api.controller;

import com.academiajpa.api.entities.Exercicio;
import com.academiajpa.api.repository.ExercicioRepository;
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

@RequestMapping("/exercicio")
@RestController
@CrossOrigin
public class ExercicioController {
    
    @Autowired
    private ExercicioRepository exercioRepository;
    
    @GetMapping
    public List<Exercicio> listar(){
        return exercioRepository.findAll();
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<Object> especifico(@PathVariable Integer id){
        Optional<Exercicio> exercicioExistente = exercioRepository.findById(id);

        if (exercicioExistente.isPresent()) {
            return ResponseEntity.ok(exercicioExistente.get());
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    
    @PostMapping
    public Exercicio salvar(@Valid @RequestBody Exercicio exercicio) {
        return exercioRepository.save(exercicio);
    }
    
    @PutMapping("/{id}")
    public Exercicio alterar(@RequestBody Exercicio atualizarExercicio, @PathVariable Integer id){
        return exercioRepository.findById(id)
                .map(exercicio -> {
                    exercicio.setEquipamento(atualizarExercicio.getEquipamento());
                    exercicio.setInstrucoes(atualizarExercicio.getInstrucoes());
                    exercicio.setMovimento(atualizarExercicio.getMovimento());
                    exercicio.setPosicaoinicial(atualizarExercicio.getPosicaoinicial());
                    return exercioRepository.save(exercicio);
                })
                .orElseGet(() -> {
                    atualizarExercicio.setId(id);
                    return exercioRepository.save(atualizarExercicio);
                });
    }
    
    @DeleteMapping("/{id}")
    public void apagar(@PathVariable Integer id){
        exercioRepository.deleteById(id);
    }
}
