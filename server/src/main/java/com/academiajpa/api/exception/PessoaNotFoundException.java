/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.academiajpa.api.exception;

/**
 *
 * @author Jonatan
 */
public class PessoaNotFoundException extends RuntimeException {
    
    PessoaNotFoundException(Integer id) {
		super("Não foi encontrada a pessoa com o id: " + id);
	}
    
}
