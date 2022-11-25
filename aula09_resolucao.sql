-- 1. Integridade Referencial
-- criar uma nova base de dados BD_Empresa
CREATE DATABASE IF NOT EXISTS BD_Empresa;

-- seleccionar base de dados para utilização nas queries seguintes
USE BD_Empresa;

-- 1.1 Construir uma base de dados de acordo com o diagrama seguinte, 
-- onde um empregado trabalha num departamento e num departamento podem 
-- trabalhar vários empregados

-- O diagrama E-A pode ser transformado no seguinte esquema relacional:
-- empregado(cc, nome), PK:cc
-- trabalha(cc, did, desde), PK:cc, FK:cc->empregado(cc), FK:did->departamento(did)
-- departamento(did, nome, orcamento), PK:did

-- ou o esquema alternativo aceitando que empregado.did e desde podem admitir o valor null 
-- já que não há obrigatoriedade
-- empregado(cc, nome, desde, did), PK:cc, FK:did->departamento(did)
-- departamento(did, nome, orcamento), PK:did

-- vamos implementar a segunda opção
CREATE TABLE IF NOT EXISTS departamento (
	did INT,
	nome VARCHAR(30) NOT NULL,
	orcamento FLOAT DEFAULT 0,
	PRIMARY KEY(did),
	CONSTRAINT col_orcamentopositio CHECK(orcamento > 0)
);

CREATE TABLE IF NOT EXISTS empregado (
	cc CHAR(8),
	nome VARCHAR(50) NOT NULL,
	desde DATE,
	did INT,
	PRIMARY KEY(cc),
	CONSTRAINT fk_empregado_departamento FOREIGN KEY (did) REFERENCES departamento(did)
);


-- 1.2 Insira os tuplos
-- trabalhador Teresa Costeira, CC 12345678, que trabalha no departamento de IT orçamento 150.000€ desde '28-03-2022'
-- trabalhador Pedro Matias, CC 43218765, que trabalha no departamento de RH orçamento 80.000€ desde '10-09-2021'
INSERT INTO departamento VALUES
(1, 'IT', 150000),
(2, 'RH', 80000);

INSERT INTO empregado VALUES
('12345678', 'Teresa Costeira', '2022-03-28', 1),
('43218765', 'Pedro Matias', '2021-09-10', 2);

-- experimente apagar o departamento de IT
DELETE FROM departamento WHERE nome = 'IT';


-- 1.3 Construir uma base de dados de acordo com o diagrama seguinte, onde um empregado 
-- pode trabalhar em vários departamentos e num departamento podem trabalhar vários 
-- empregados


-- O diagrama E-A pode ser transformado no seguinte esquema relacional:
-- empregado(cc, nome), PK:cc
-- trabalha(cc, did, desde), PK:(cc, did), FK:cc->empregado(cc), FK:did->departamento(did)
-- departamento(did, nome, orcamento), PK:did


CREATE TABLE IF NOT EXISTS departamento_v2 (
	did INT,
	nome VARCHAR(30) NOT NULL,
	orcamento FLOAT DEFAULT 0,
	PRIMARY KEY(did),
	CONSTRAINT col_positivebudget CHECK(orcamento > 0)
);


CREATE TABLE IF NOT EXISTS empregado_v2 (
	cc CHAR(8),
	nome VARCHAR(50) NOT NULL,
	PRIMARY KEY(cc),
	CONSTRAINT col_ccis8digits CHECK(cc REGEXP '[0-9]{8}')
);

CREATE TABLE IF NOT EXISTS trabalha_v2 (
	cc CHAR(8),
	did INT,
	desde DATE,
	PRIMARY KEY(cc, did),
	CONSTRAINT fk_trabalha_departamento FOREIGN KEY (did) REFERENCES departamento(did),
	CONSTRAINT fk_trabalha_empregado FOREIGN KEY (cc) REFERENCES empregado(cc)
);


-- 1.4 Insira os tuplos
-- trabalhadora Teresa Costeira, CC 12345678, que trabalha no departamento de IT orçamento 150.000€ desde '28-03-2022'
-- trabalhador Pedro Matias, CC 43218765, que trabalha no departamento de RH orçamento 80.000€ desde '10-09-2021'
-- trabalhadora Luisa Macedo, CC 12344321, que trabalha no departamento de RH orçamento 80.000€ desde '12-11-2021'
INSERT INTO departamento_v2 VALUES
(1, 'IT', 150000),
(2, 'RH', 80000);

INSERT INTO empregado_v2 VALUES
('12345678', 'Teresa Costeira'),
('43218765', 'Pedro Matias'),
('12344321', 'Luisa Macedo');

INSERT INTO trabalha_v2 VALUES
('12345678', 1, '2022-03-28'),
('43218765', 2, '2021-09-10'),
('12344321', 2, '2021-11-12');

-- experimente apagar o departamento de IT
DELETE FROM departamento_v2 WHERE nome = 'IT';


-- 2. Actions
-- 2.1 Altere a BD do exercício 1.1 tal que quando um departamento é removido, 
-- todos os empregados desse departamento são removidos e para que 
-- quando o departamente é alterado perde referência para o valor null

-- remover restrict action
ALTER TABLE empregado DROP CONSTRAINT fk_empregado_departamento;

ALTER TABLE empregado 
ADD CONSTRAINT fk_empregado_departamento_2 
FOREIGN KEY (did) REFERENCES departamento(did)
ON DELETE CASCADE
ON UPDATE SET NULL;



-- 2.2 Experimente remover o departamento IT e alterar o departamento RH
DELETE FROM departamento WHERE nome = 'IT';
UPDATE departamento SET did = 3 WHERE nome = 'RH';



-- 2.3 Altere a BD em 1.3 tal que quando um departamento é removido, os seus empregados deixam 
-- de pertencer a qualquer departamento.
ALTER TABLE empregado 
DROP CONSTRAINT fk_empregado_departamento_2;

ALTER TABLE empregado 
ADD CONSTRAINT fk_empregado_departamento_3 
FOREIGN KEY (did) REFERENCES departamento(did)
ON DELETE SET NULL
ON UPDATE SET NULL;