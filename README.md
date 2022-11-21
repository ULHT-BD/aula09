# aula09
Nesta aula olhamos para restrições de integridade referencial. Como criar ligações entre relações e quais as implicações que estas restrições trazem.
Bom trabalho!

[0. Requisitos](#0-requisitos)

[1. Integridade Referencial](#1-integridade-referencial)

[2. One-to-Many](#2-one-to-many)

[3. Many-to-Many](#3-many-to-many)

[4. Trabalho de Casa](#4-trabalho-de-casa)

[5. Resoluções](#5-resoluções)

[Bibliografia e Referências](#bibliografia-e-referências)

[Outros](#outros)

## 0. Requisitos
Requisitos: Para esta aula, precisa de ter o ambiente de trabalho configurado ([Docker](https://www.docker.com/products/docker-desktop/) com [base de dados HR](https://github.com/ULHT-BD/aula03/blob/main/docker_db_aula03.zip) e [DBeaver](https://dbeaver.io/download/)). Caso ainda não o tenha feito, veja como fazer seguindo o passo 1 da [aula03](https://github.com/ULHT-BD/aula03/edit/main/README.md#1-prepare-o-seu-ambiente-de-trabalho).

Caso já tenha o docker pode iniciá-lo usando o comando ```docker start mysgbd``` no terminal, ou através do interface gráfico do docker-desktop:
<img width="1305" alt="image" src="https://user-images.githubusercontent.com/32137262/194916340-13af4c85-c282-4d98-a571-9c4f7b468bbb.png">

Deve também ter o cliente DBeaver.

## 1. Integridade Referencial
A integridade referencial permite criar relações entre relações e em SQL é implementada através da definição de chaves estrangeiras com a cláusula ```FOREIGN KEY```.
No momento de criação de uma relação podemos definir uma chave estrangeira usando a sintaxe

``` sql
CREATE TABLE tabela (
  definicao-de-colunas,
  FOREIGN KEY (coluna) REFERENCES tabela-referencia(coluna)
);
```

ou se quisermos, explicitando o nome da restrição de integridade (no exemplo acima um nome será atribuído automaticamente):

``` sql
CREATE TABLE tabela (
  definicao-de-colunas,
  CONSTRAINT fk_tabela_tabelaref FOREIGN KEY (coluna) REFERENCES tabela-referencia(coluna)
);
```

Podemos alterar uma tabela existente adicionando restrições de integridade:

``` sql
ALTER TABLE tabela
ADD CONSTRAINT fk_tabela_tabelaref FOREIGN KEY (coluna) REFERENCES tabela-referencia(coluna)
);
```

ou removendo restrições de integridade:

``` sql
ALTER TABLE tabela DROP CONSTRAINT;
```

### Exercícios
Para cada uma das alíneas seguintes, escreva a query que permite obter:
1. Uma vista para os empregados onde é possivel ter acesso ao id, primeiro nome, último nome e salário (incluindo comissão quando existe)
2. Atualize a comissão do empregado cujo id é 100 para 25%. Consulte a vista e verifique a alteração do resultado na vista.
3. Crie uma vista v_job que permite obter os valores mínimo, médio e máximo do salário de cada função (JOB_ID)
4. Utilize a vista anterior para obter a lista de JOB_ID e salários médios para as funções cujo salário médio é superior a 10000.

## 2. One-to-Many


### Exercícios
Para cada uma das alíneas seguintes, escreva a query que permite obter:
1. Quais os índices da tabela employees e os vários atributos (tipo de índice, sequência, etc)
2. Adicione um índice para o telefone de empregados e volte a verificar os índices existentes
3. Remova o índice que adicionou no ponto anterior

## 3. Many-to-Many


### Exercícios
Para cada uma das alíneas seguintes, escreva a query que permite obter:
1. Quais os índices da tabela employees e os vários atributos (tipo de índice, sequência, etc)
2. Adicione um índice para o telefone de empregados e volte a verificar os índices existentes
3. Remova o índice que adicionou no ponto anterior


## 4. Trabalho de Casa
(a publicar)


## 5. Resoluções
[Resolução dos exercícios em aula](https://github.com/ULHT-BD/aula09/blob/main/aula09_resolucao.sql)

[Resolução do trabalho de casa](https://github.com/ULHT-BD/aula09/blob/main/TPC_a09_resolucao.sql)

## Bibliografia e Referências
* [mysqltutorial - CREATE TABLE](https://www.mysqltutorial.org/mysql-create-table/)
* [mysqltutorial - Data Types](https://www.mysqltutorial.org/mysql-data-types.aspx)
* [MySQL - Data Types](https://dev.mysql.com/doc/refman/8.0/en/data-types.html)
* [mysqltutorial - Storage Engines](https://www.mysqltutorial.org/understand-mysql-table-types-innodb-myisam.aspx)
* [w3schools - MySQL Functions](https://www.w3schools.com/mysql/mysql_ref_functions.asp)

## Outros
Para dúvidas e discussões pode juntar-se ao grupo slack da turma através do [link](
https://join.slack.com/t/ulht-bd/shared_invite/zt-1iyiki38n-ObLCdokAGUG5uLQAaJ1~fA) (atualizado 2022-11-03)
