SET @@global.time_zone = '+3:00';

--musculos
INSERT INTO `academiajpa`.`musculo` (`nome`) VALUES ('peito');
INSERT INTO `academiajpa`.`musculo` (`nome`) VALUES ('costas');

--exercicios
INSERT INTO `academiajpa`.`exercicio` (`equipamento`, `posicaoinicial`, `movimento`, `instrucoes`) VALUES ('Crucifixo', 'Deite-se em um banco horizontal. Segure os halteres com os braços estendidos e os cotovelos levemente flexionados.', 'Ao Inspirar: Abra os braços, abaixando os halteres até que os cotovelos atinjam a altura dos ombros.', 'Prefira um banco estreito, pois isso deverá permitir que seus braços se estiquem sem encostar em qualquer lugar.');