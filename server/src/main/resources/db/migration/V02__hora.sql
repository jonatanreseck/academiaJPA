SET @@global.time_zone = '+3:00';

# pessoa
INSERT INTO `academiajpa`.`pessoa` (`nome`, `email`, `senha`, `cpf`, `rua`, `numero`, `bairro`, `telefone`, `isfuncionario`) VALUES ('user', 'user@email.com', '123', '111111', 'rua das aur', '21', 'vvfvf', '3534715909', '0');

# musculos
INSERT INTO `academiajpa`.`musculo` (`nome`) VALUES ('peito');
INSERT INTO `academiajpa`.`musculo` (`nome`) VALUES ('costas');

# exercicios
INSERT INTO `academiajpa`.`exercicio` (`equipamento`, `posicaoinicial`, `movimento`, `instrucoes`) VALUES ('Crucifixo', 'Deite-se em um banco horizontal. Segure os halteres com os braços estendidos e os cotovelos levemente flexionados.', 'Ao Inspirar: Abra os braços, abaixando os halteres até que os cotovelos atinjam a altura dos ombros.', 'Prefira um banco estreito, pois isso deverá permitir que seus braços se estiquem sem encostar em qualquer lugar.');

# serie
INSERT INTO `academiajpa`.`serie` (`dia`, `exercicio_id`, `qtd_repeticao`, `peso`, `pessoa_id`) VALUES ('1', '1', '12', '5', '1');