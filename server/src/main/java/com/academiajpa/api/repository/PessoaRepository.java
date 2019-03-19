package com.academiajpa.api.repository;

import com.academiajpa.api.entities.Pessoa;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PessoaRepository extends JpaRepository<Pessoa, Integer>{

    public Optional<Pessoa> findByNome(String nome);

   // public Pessoa atualizar(Long codigo, Pessoa pessoa);
    //wilds methods
    public Pessoa findByEmailAndSenha(String email, String senha);
}
