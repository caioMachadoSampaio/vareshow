-- MySQL Script generated by MySQL Workbench
-- Sun May 16 22:01:36 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL,
  `nome` VARCHAR(65) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `telefone` VARCHAR(11) NOT NULL,
  `email` VARCHAR(65) NOT NULL,
  `lojista` TINYINT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Lojista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Lojista` (
  `idLojista` INT NOT NULL,
  `cnpj` VARCHAR(18) NOT NULL,
  `razaoSocial` VARCHAR(65) NULL,
  `nomeFantasia` VARCHAR(65) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idLojista`),
  INDEX `fk_Logista_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Logista_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Endereco` (
  `idEndereco` INT NOT NULL,
  `cep` VARCHAR(8) NOT NULL,
  `numero` INT NOT NULL,
  `rua` VARCHAR(65) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Lojista_idLogista` INT NULL,
  PRIMARY KEY (`idEndereco`),
  INDEX `fk_Endereco_Cliente_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Endereco_Logista1_idx` (`Lojista_idLogista` ASC) VISIBLE,
  CONSTRAINT `fk_Endereco_Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Endereco_Logista1`
    FOREIGN KEY (`Lojista_idLogista`)
    REFERENCES `mydb`.`Lojista` (`idLojista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sub_Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sub_Categoria` (
  `idSub_Categoria` INT NOT NULL,
  `nome` VARCHAR(65) NOT NULL,
  PRIMARY KEY (`idSub_Categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Categoria` (
  `idCategoria` INT NOT NULL,
  `nome` VARCHAR(65) NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produto` (
  `idProduto` INT NOT NULL,
  `nome` VARCHAR(65) NOT NULL,
  `quantidade` INT NOT NULL,
  `descricao` VARCHAR(75) NOT NULL,
  `preco` FLOAT NOT NULL,
  `Lojista_idLojista` INT NOT NULL,
  `Categoria_idCategoria` INT NOT NULL,
  `Sub_Categoria_idSub_Categoria` INT NULL,
  PRIMARY KEY (`idProduto`),
  INDEX `fk_Produto_Logista1_idx` (`Lojista_idLojista` ASC) VISIBLE,
  INDEX `fk_Produto_Sub_Categoria1_idx` (`Sub_Categoria_idSub_Categoria` ASC) VISIBLE,
  INDEX `fk_Produto_Categoria1_idx` (`Categoria_idCategoria` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_Logista1`
    FOREIGN KEY (`Lojista_idLojista`)
    REFERENCES `mydb`.`Lojista` (`idLojista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_Sub_Categoria1`
    FOREIGN KEY (`Sub_Categoria_idSub_Categoria`)
    REFERENCES `mydb`.`Sub_Categoria` (`idSub_Categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_Categoria1`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `mydb`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `idPedido` INT NOT NULL,
  `data_hora` DATETIME NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `valor` FLOAT NOT NULL,
  `statusEntrega` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cesta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cesta` (
  `Pedido_idPedido` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `quantidade` INT NOT NULL,
  INDEX `fk_Cesta_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  PRIMARY KEY (`Pedido_idPedido`, `Produto_idProduto`),
  CONSTRAINT `fk_Cesta_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cesta_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pagamento` (
  `idPagamento` INT NOT NULL,
  `data_hora` DATETIME NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `forma_de_pagamento` VARCHAR(45) NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  PRIMARY KEY (`idPagamento`),
  INDEX `fk_Pagamento_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
