PRAGMA foreign_keys = ON;

Drop Table if exists Cliente;
Drop Table if exists Morada;
Drop Table if exists ClienteMorada;
Drop Table if exists Pais;
Drop Table if exists Localidade;
Drop Table if exists Carrinho;
Drop Table if exists Encomenda;
Drop Table if exists Pagamento;
Drop Table if exists Envio1;
Drop Table if exists Envio2;
Drop Table if exists PecaEspecifica;
Drop Table if exists Devolucao;
Drop Table if exists Compra;
Drop Table if exists Selecao;
Drop Table if exists Foto;
Drop Table if exists PecaGenerica;
Drop Table if exists Categoria;
Drop Table if exists Relacao;
Drop Table if exists Material;
Drop Table if exists Cor;
Drop Table if exists PecaGenericaCor;
Drop Table if exists Tamanho;
Drop Table if exists PecaGenericaTamanho;

Create tabLE Cliente(
  idCliente int primary key,
  nome varchar(60) CONSTRAINT nn_nome not NULL,
  nif int constraint u_nif UNIQUE,
  telefone int constraint nn_telefone NOT NULL,
  email varchar(320) CONSTRAINT nn_email NOT NULL CONSTRAINT u_email UNIQUE,
  dataNasc date
);

create table Pais(
  idPais int primary key,
  nome varchar(20) constraint nn_nome NOT NULL constraint u_nome UNIQUE
);

CREATE TABLE Localidade (
  idLocalidade INT PRIMARY KEY,
  nome VARCHAR(30) CONSTRAINT nn_localidade NOT NULL CONSTRAINT u_nome UNIQUE,
  idPais int CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_pais REFERENCES Pais(idPais)
);

CREATE TABLE Morada(
  idMorada int primary key,
  nome varchar(10) constraint nn_nome NOT NULL,
  rua varchar(40) CONSTRAINT nn_rua not NULL,
  codigoPostal varchar(20) CONSTRAINT nn_codigopostal not NULL,
  idLocalidade int CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_localidade references Localidade(idLocalidade),
  CONSTRAINT u_nrci UNIQUE(nome, rua, codigoPostal, idLocalidade),
  CONSTRAINT u_in UNIQUE(nome, idMorada)
);


create table ClienteMorada(
  idCliente int CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_cliente references Cliente(idCliente),
  idMorada int CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_morada references Morada(idMorada),
  PRIMARY KEY (idCliente, idMorada)
);



CREATE Table Carrinho (
  idCarrinho INT Primary Key,
  dataCriacao date CONSTRAINT nn_data_criacao NOT NULL,
  idCliente int CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_cliente REFERENCES CLiente(idCliente),
  CONSTRAINT u_di UNIQUE(dataCriacao, idCliente)
);

Create Table Encomenda(
  idEncomenda int CONSTRAINT nn_id_encomenda NOT NULL CONSTRAINT u_id_encomenda Unique,
  dataPedido date CONSTRAINT nn_data_validade NOT NULL
);

Create Table Pagamento(
  idCliente int CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_cliente REFERENCES Cliente(idCliente),
  idEncomenda int PRIMARY Key CONSTRAINT fk_id_encomenda REFERENCES Encomenda(idEncomenda),
  numCartao int CONSTRAINT nn_num_cartao NOT NULL,
  cvv int CONSTRAINT nn_cvv NOT NULL,
  dataValidade date CONSTRAINT nn_data_validade NOT NULL
);

Create table Envio1(
  pesoTotal real (4,2) CONSTRAINT nn_peso_total NOT NULL CHECK(pesoTotal>=0),
  portes real (4,2) CONSTRAINT nn_portes NOT NULL
);

Create Table Envio2(
  idEncomenda int PRIMARY key CONSTRAINT fk_id_encomenda REFERENCES Encomenda(idEncomenda),
  idMorada INT CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_morada REFERENCES Morada(idMorada),
  dataExpedicao date CONSTRAINT nn_data_expedicao NOT NULL,
  dataChegada date CONSTRAINT nn_data_chegada NOT NULL,
  codigoRastreamento int CONSTRAINT nn_codigo_rastreamento NOT NULL CONSTRAINT u_codigo_rastreamento UNIQUE CHECK( dataChegada>=dataExpedicao)
);

CREATE TABLE Cor (
  idCor INT PRIMARY KEY,
  nome VARCHAR(15) CONSTRAINT nn_nome NOT NULL CONSTRAINT u_cor UNIQUE
);

CREATE TABLE Tamanho (
  idTamanho INT PRIMARY KEY,
  descricao VARCHAR(3) CONSTRAINT nn_descricao NOT NULL CONSTRAINT u_descricao UNIQUE CHECK(descricao = '32' or descricao = '34' or descricao = '36' or descricao = '38' or descricao = '40' or descricao = '42' or descricao = '44' or descricao = 'XXS' or descricao = 'XS' or descricao = 'S' or descricao = 'M' or descricao = 'L' or descricao = 'XL' or descricao = 'XXL')
);

CREATE TABLE Categoria (
  idCategoria INT PRIMARY KEY,
  nome VARCHAR (20) CONSTRAINT nn_nome NOT NULL CONSTRAINT u_nome UNIQUE,
  superCategoria int CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_super_categoria REFERENCES Categoria(idCategoria)
);

CREATE TABLE Material (
  idMaterial INT PRIMARY KEY,
  nome VARCHAR(15) CONSTRAINT nn_nome NOT NULL,
  cuidados varchar(60)
);

Create Table PecaGenerica (
  idPecaGenerica int PRIMARY key,
  descricao varchar(100) CONSTRAINT nn_descricao NOT NULL ,
  referencia varchar(25) CONSTRAINT nn_referencia NOT NULL CONSTRAINT u_referencia UNIQUE,
  preco Real(5,2) CONSTRAINT nn_preco NOT NULL,
  idMaterial INT CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_material REFERENCES Material(idMaterial),
  idCategoria INT CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_categoria REFERENCES Categoria(idCategoria)
);

Create Table PecaGenericaCor (
  idPecaGenerica INT CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_peca_generica REFERENCES PecaGenerica(idPecaGenerica),
  idCor INT CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_cor REFERENCES Cor(idCor),
  PRIMARY KEY (idPecaGenerica, idCor)
);


CREATE TABLE PecaGenericaTamanho (
  idPecaGenerica INT CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_peca_generica references PecaGenerica(idPecaGenerica),
  idTamanho INT CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_tamanho REFERENCES Tamanho(idTamanho),
  PRIMARY KEY (idPecaGenerica, idTamanho)
);

Create TABLE PecaEspecifica(
  idPecaEspecifica INT PRIMARY KEY,
  stock INT CONSTRAINT stock_range CHECK(stock>=0) CONSTRAINT nn_stock NOT NULL,
  idCor INT CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_cor REFERENCES Cor (idCor),
  idTamanho INT CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_tamanho references TAMANHO(idTamanho),
  idPecaGenerica INT CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_peca_generica REFERENCES PecaEspecifica (idPecaEspecifica),
  CONSTRAINT u_iii UNIQUE(idCor, idTamanho, idPecaGenerica)
);

CREATE table Devolucao (
  idEncomenda int CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_encomenda references Encomenda(idEncomenda),
  idPecaEspecifica INT PRimary key CONSTRAINT fk_id_peca_especifica REFERENCES PecaEspecifica(idPecaEspecifica),
  motivo varchar(80) CONSTRAINT nn_motivo not NULL
);

CREATE TABLE Compra (
  idEncomenda int CONSTRAINT nn_fk NOT NULL references Encomenda (idEncomenda),
  idPecaEspecifica INT CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_peca_especifica REFERENCES PecaEspecifica(idPecaEspecifica),
  quantSelecionada INT,
  PRIMARY KEY (idEncomenda,idPecaEspecifica)
);

CREATE TABLE Selecao (
  idCarrinho INT CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_carrinho REFERENCES Carrinho(idCarrinho),
  idPecaEspecifica INT CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_peca_especifica REFERENCES PecaEspecifica(idPecaEspecifica),
  quantSelecionada int,
  PRIMARY KEY (idCarrinho, idPecaEspecifica)
);

CREATE TABLE Foto (
  idFoto int PRIMARY key,
  ficheiro BLOP CONSTRAINT nn_ficheiro NOT NULL,
  idPecaEspecifica int CONSTRAINT nn_fk NOT NULL CONSTRAINT fk_id_peca_especifica REFERENCES PecaEspecifica(idPecaEspecifica),
  CONSTRAINT u_fi UNIQUE(ficheiro, idPecaEspecifica)
);