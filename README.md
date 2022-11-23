# aula09
Nesta aula olhamos para restrições de integridade referencial. Como criar ligações entre relações e quais as implicações que estas restrições trazem.
Bom trabalho!

[0. Requisitos](#0-requisitos)

[1. Integridade Referencial](#1-integridade-referencial)

[2. Actions](#2-actions)

[3. Trabalho de Casa](#3-trabalho-de-casa)

[4. Resoluções](#4-resoluções)

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
Escreva o código SQL que permite:
0. Crie a Base de Dados BD_Empresa
1. Construir uma base de dados de acordo com o diagrama seguinte, onde um empregado trabalha num departamento e num departamento podem trabalhar vários empregados:
<img width="747" alt="image" src="https://user-images.githubusercontent.com/32137262/203181180-9e39a698-902c-4198-ab1f-04cb5ad9cb1f.png">

2. Insira os tuplos
- trabalhador Teresa Costeira, CC 12345678, que trabalha no departamento de IT orçamento 150.000€ desde '28-03-2022'
- trabalhador Pedro Matias, CC 43218765, que trabalha no departamento de RH orçamento 80.000€ desde '10-09-2021'
- experimente apagar o departamento de IT

3. Construir uma base de dados de acordo com o diagrama seguinte, onde um empregado pode trabalhar em vários departamentos e num departamento podem trabalhar vários empregados:
<img width="747" alt="image" src="https://user-images.githubusercontent.com/32137262/203181590-ae62094b-e265-4af0-924f-233a0290aecb.png">

4. Insira os tuplos
- trabalhadora Teresa Costeira, CC 12345678, que trabalha no departamento de IT orçamento 150.000€ desde '28-03-2022'
- trabalhador Pedro Matias, CC 43218765, que trabalha no departamento de RH orçamento 80.000€ desde '10-09-2021'
- trabalhadora Luisa Macedo, CC 12344321, que trabalha no departamento de RH orçamento 80.000€ desde '12-11-2021'
- experimente apagar o departamento de IT


## 2. Actions
Podemos definir ações de forma programática quando ocorrem alterações às referências. A ação por defeito é ```RESTRICT``` provocando um erro ao tentar remover ou alterar uma chave estrangeira. Podemos definir ações para a ocorrência de eventos sobre uma chave estrangeira, quando alterado (```ON UPDATE```) ou quando é removido (```ON DELETE```).

O comportamento por defeito e restringir ```RESTRICT``` dar erro. Outras alternativas sao 
- ```CASCADE``` - efeito em cascata se tuplo referencia (ou master) for removido/alterado os tuplos referenciados serão removidos/alterados
- ```SET NULL``` - se tuplo referencia (ou master) for removido/alterado o atributo FK nos tuplos referenciados serão atualizados para valor ```NULL```
- ```NO ACTION``` - nenhuma acao
- ```SET DEFAULT``` -  se tuplo referencia (ou master) for removido/alterado o atributo FK nos tuplos referenciados serão atualizados para valor definido como default

Exemplo de uma definicao de chave estrangeira com definicao de uma acao:

``` sql
CREATE TABLE tabela (
  definicao-de-colunas,
  CONSTRAINT fk_tabela_tabelaref FOREIGN KEY (coluna) REFERENCES tabela-referencia(coluna) 
    ON UPDATE DELETE CASCADE
);
```

Ou se alterarmos uma tabela existente adicionando restrições de integridade e com acoes diferentes para alteracao e remocao:

``` sql
ALTER TABLE tabela
ADD CONSTRAINT fk_tabela_tabelaref FOREIGN KEY (coluna) REFERENCES tabela-referencia(coluna) 
  ON DELETE CASCADE 
  ON UPDATE SET NULL
);
```


### Exercícios
Altere a base de dados que criou no exercício anterior para o seguinte:
1. Altere a BD do exercício 1.1 tal que quando um departamento é removido, todos os empregados desse departamento são removidos e para que quando o departamente é alterado perde referência para o valor null
2. Experimente remover o departamento IT e alterar o departamento RH
3. Altere a BD em 1.3 tal que quando um departamento é removido, os seus empregados deixam de pertencer a qualquer departamento.


## 3. Trabalho de Casa
*Notas:*

1. Caso não tenha consegui criar a base de dados deisiflix nos trabalhos anteriores experimente verifique ou altere o nome de utilizador da sua ligação à ao MariaDB para ```root``` (a password deve ser ```admin```)
![image](https://user-images.githubusercontent.com/32137262/202258030-d9e452f7-4cde-4aa3-b42f-a403d59e80cc.png)

2. No [trabalho de casa da aula anterior](https://github.com/ULHT-BD/aula08/blob/main/README.md#3-trabalho-de-casa) foi pedida a criação e carregamento de dados dos ficheiros nas relações criadas, possivel via comando ```LOAD``` ou interface dbeaver (caso não tenha conseguido resolver, consulte a [resolução](https://github.com/ULHT-BD/aula08/blob/main/README.md#4-resolu%C3%A7%C3%B5es)). Para quem usou o dbeaver, duas ajudas:

* o load assume a primeira linha como nome da coluna pelo que esta não é inserida. Sugestão adicione uma primeira linha com nomes das colunas antes da importação.

* a conversão de dados no load_movies tem dificuldade em converter strings que contenham espaços (e.g. ' 123.0') em números. Sugestão abre o ficheiro e faça find and replace de ' ,' ou ', ' por '.'

### Exercício
Escreva o código SQL que permite criar as relações (movies, movie_genre, genre) definidas no modelo 1 do enunciado do projeto, incluindo as respetivas restrições de integridade referencial definidas no esquema físico:

<img width="685" alt="image" src="https://user-images.githubusercontent.com/32137262/203660157-2dae0678-bcc6-4909-ab28-45aa62b410ec.png">

Extra: se quiser adiantar o seu trabalho de projeto, crie igualmente as restantes relações e restrições.

Bom trabalho!

NOTA: submeta a sua resposta ao trabalho de casa no moodle contendo a criação de base de dados, tabelas e índices num script sql. O ficheiro de texto com o nome TPC_a09_[N_ALUNO].sql (exemplo: TPC_a09_12345.sql para o aluno número 12345).

## 4. Resoluções
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
