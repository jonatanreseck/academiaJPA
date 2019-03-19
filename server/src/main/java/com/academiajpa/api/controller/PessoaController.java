package com.academiajpa.api.controller;

import com.academiajpa.api.entities.Pessoa;
import com.academiajpa.api.repository.PessoaRepository;
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
@RequestMapping("/usuario")
public class PessoaController {

    @Autowired
    private PessoaRepository pessoaRepository;

    @GetMapping
    public List<Pessoa> listar() {
        return pessoaRepository.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Pessoa> buscar(@PathVariable Integer id) {
        Optional<Pessoa> empExistente = pessoaRepository.findById(id);

        if (empExistente.isPresent()) {
            return ResponseEntity.ok(empExistente.get());
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Pessoa salvar(@Valid @RequestBody Pessoa pessoa) {
        //verifico se o email já está cadastrado para garantir que é unico
        Optional<Pessoa> pExistente = pessoaRepository.findByNome(pessoa.getNome());

        if (pExistente.isPresent()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "exercicio já cadastrado");
        }
        return pessoaRepository.save(pessoa);
    }

    /*put seguindo a documentação*/
    @PutMapping("/{id}")
    Pessoa replaceEmployee(@RequestBody Pessoa newPessoa, @PathVariable Integer id) {

        return pessoaRepository.findById(id)
                .map(pessoa -> {
                    pessoa.setBairro(newPessoa.getBairro());
                    pessoa.setNome(newPessoa.getNome());
                    pessoa.setNumero(newPessoa.getNumero());
                    pessoa.setRua(newPessoa.getRua());
                    pessoa.setSenha(newPessoa.getSenha());
                    pessoa.setSetor(newPessoa.getSetor());
                    pessoa.setTelefone(newPessoa.getTelefone());
                    return pessoaRepository.save(pessoa);
                })
                .orElseGet(() -> {
                    newPessoa.setId(id);
                    return pessoaRepository.save(newPessoa);
                });
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.ACCEPTED)
    public void deletar(@PathVariable Integer id) {
        pessoaRepository.deleteById(id);
    }
    
    @PostMapping("/autenticar")
    @ResponseStatus(HttpStatus.CREATED)
    public Pessoa autenticar(@Valid @RequestBody Pessoa pessoa) {
        //verifico se o email já está cadastrado para garantir que é unico
        Pessoa pExistente = new Pessoa();
        pExistente = pessoaRepository.findByEmailAndSenha(pessoa.getEmail(), pessoa.getSenha());

        if (!(pExistente != null)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Login ou senha inválido!");
        }else{
            return pExistente;
        }
    }

}
