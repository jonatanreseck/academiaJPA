-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema academiaJPA
-- -----------------------------------------------------
-- banco para treinar o JPA com umas interações meio locas, mas bora lá.

-- -----------------------------------------------------
-- Schema academiaJPA
--
-- banco para treinar o JPA com umas interações meio locas, mas bora lá.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `academiaJPA` DEFAULT CHARACTER SET utf8 ;
USE `academiaJPA` ;

-- -----------------------------------------------------
-- Table `academiaJPA`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academiaJPA`.`fornecedor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `telefone` VARCHAR(45) NULL,
  `cnpj` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `academiaJPA`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academiaJPA`.`produto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `valor` VARCHAR(45) NULL,
  `tipo` VARCHAR(45) NULL,
  `fornecedo_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fornecedor_id_idx` (`fornecedo_id` ASC),
  CONSTRAINT `fornecedor_id`
    FOREIGN KEY (`fornecedo_id`)
    REFERENCES `academiaJPA`.`fornecedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `academiaJPA`.`pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academiaJPA`.`pessoa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `senha` VARCHAR(45) NULL,
  `cpf` VARCHAR(45) NULL,
  `rua` VARCHAR(45) NULL,
  `numero` VARCHAR(45) NULL,
  `bairro` VARCHAR(45) NULL,
  `telefone` VARCHAR(45) NULL,
  `isfuncionario` INT NULL,
  `setor` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `academiaJPA`.`venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academiaJPA`.`venda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `formadepagamento` VARCHAR(45) NULL,
  `data` VARCHAR(45) NULL,
  `hora` VARCHAR(45) NULL,
  `produto_id` INT NULL,
  `pessoa_id` INT NULL,
  `valorvenda` DECIMAL NULL,
  `numeroparcela` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `produto_id_idx` (`produto_id` ASC),
  INDEX `pessoa_id_idx` (`pessoa_id` ASC),
  CONSTRAINT `produto_id`
    FOREIGN KEY (`produto_id`)
    REFERENCES `academiaJPA`.`produto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pessoa_id`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `academiaJPA`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `academiaJPA`.`parcelavenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academiaJPA`.`parcelavenda` (
  `id` VARCHAR(45) NOT NULL,
  `data` VARCHAR(45) NULL,
  `valorparcela` DECIMAL NULL,
  `pagou` VARCHAR(45) NULL,
  `venda_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `venda_id_idx` (`venda_id` ASC),
  CONSTRAINT `venda_id`
    FOREIGN KEY (`venda_id`)
    REFERENCES `academiaJPA`.`venda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `academiaJPA`.`servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academiaJPA`.`servico` (
  `id` INT NOT NULL,
  `tipo` VARCHAR(45) NULL,
  `valortotal` DECIMAL(10,2) NULL,
  `horarioentrada` VARCHAR(45) NULL,
  `horariosaida` VARCHAR(45) NULL,
  `dias` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `academiaJPA`.`adquirir`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academiaJPA`.`adquirir` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pessoa_id` INT NULL,
  `servico_id` INT NULL,
  `numeroparcela` INT NULL,
  `valorparcela` DECIMAL(10,2) NULL,
  `parcelaspagas` INT NULL,
  `valorrestante` DECIMAL(10,2) NULL,
  `valortotal` DECIMAL(10,2) NULL,
  PRIMARY KEY (`id`),
  INDEX `pessoa_id_idx` (`pessoa_id` ASC),
  INDEX `servico_id_idx` (`servico_id` ASC),
  CONSTRAINT `pessoa_adquirir_id`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `academiaJPA`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `servico_adquirir_id`
    FOREIGN KEY (`servico_id`)
    REFERENCES `academiaJPA`.`servico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `academiaJPA`.`parcelaservico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academiaJPA`.`parcelaservico` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `adquirir_id` INT NULL,
  `pessoa_id` INT NULL,
  `servico_id` INT NULL,
  `data` VARCHAR(45) NULL,
  `pagou` VARCHAR(45) NULL,
  `valorparcela` DECIMAL NULL,
  PRIMARY KEY (`id`),
  INDEX `cliente_id_idx` (`pessoa_id` ASC),
  INDEX `servico_id_idx` (`servico_id` ASC),
  INDEX `adquirir_id_idx` (`adquirir_id` ASC),
  CONSTRAINT `pessoa_parcela_id`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `academiaJPA`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `servico_parcela_id`
    FOREIGN KEY (`servico_id`)
    REFERENCES `academiaJPA`.`servico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `adquirir_parcela_id`
    FOREIGN KEY (`adquirir_id`)
    REFERENCES `academiaJPA`.`adquirir` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `academiaJPA`.`pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academiaJPA`.`pagamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pessoa_id` INT NULL,
  `cliente_id` INT NULL,
  `data` VARCHAR(45) NULL,
  `hora` VARCHAR(45) NULL,
  `parcelaservico_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `parcelaservico_id_idx` (`parcelaservico_id` ASC),
  INDEX `pessoa_id_idx` (`pessoa_id` ASC),
  CONSTRAINT `pagamento_pessoa_id`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `academiaJPA`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `pagamento_parcelaservico_id`
    FOREIGN KEY (`parcelaservico_id`)
    REFERENCES `academiaJPA`.`parcelaservico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `academiaJPA`.`estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academiaJPA`.`estoque` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantidade` INT NULL,
  `produto_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `estoque_id_idx` (`produto_id` ASC),
  CONSTRAINT `estoque_id`
    FOREIGN KEY (`produto_id`)
    REFERENCES `academiaJPA`.`produto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `academiaJPA`.`exercicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academiaJPA`.`exercicio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `equipamento` VARCHAR(45) NULL,
  `posicaoinicial` VARCHAR(256) NULL,
  `movimento` VARCHAR(256) NULL,
  `instrucoes` VARCHAR(526) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `academiaJPA`.`serie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academiaJPA`.`serie` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dia` INT NULL,
  `exercicio_id` INT NULL,
  `qtd_repeticao` INT NULL,
  `peso` INT NULL,
  `obs` VARCHAR(255) NULL,
  `pessoa_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `exercicio_id_idx` (`exercicio_id` ASC),
  INDEX `cliente_id_idx` (`pessoa_id` ASC),
  CONSTRAINT `seroe_exercicio_id`
    FOREIGN KEY (`exercicio_id`)
    REFERENCES `academiaJPA`.`exercicio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `serie_pessoa_id`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `academiaJPA`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `academiaJPA`.`musculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academiaJPA`.`musculo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `academiaJPA`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academiaJPA`.`categoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `exercicio_id` INT NULL,
  `musculo_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `exercicio_id_idx` (`exercicio_id` ASC),
  INDEX `musculo_id_idx` (`musculo_id` ASC),
  CONSTRAINT `exercicio_id`
    FOREIGN KEY (`exercicio_id`)
    REFERENCES `academiaJPA`.`exercicio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `musculo_id`
    FOREIGN KEY (`musculo_id`)
    REFERENCES `academiaJPA`.`musculo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
