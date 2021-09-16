CRIANDO UM BANCO DE DADOS
--> CREAT DATABASE NOMEDOBANCO;
EXCLUINDO BANCO
--> DROP DATABASE NOMEDOBANCO;
**COMANDOS**
 --ATENÇÃO--
Sempre usar o comando em caixa alta e o que estiver sendo filtrado Minusculo 
--Operadores SQL--
( '=' igual, '>' Maior que, '<' Menor que, '>=' Maior que ou igual, '<=' Menor que ou igual, '<>' Diferente que, 'AND' Operador logico E, 'OR' Operador logico OU)
SELECT coluna1,coluna2
FROM tabela;
(vai filtrar as COLUNAS que estão na TABELA)
SELECT *
FROM tabela;
(Mostrar toda tabela sem filtro)
SELECT DISTINCT coluna1
FROM tabela;
(Vai filtrar tirando as informações duplicadas)
SELECT * 
FROM person.Person 
WHERE LastName = 'miller' and FirstName = 'anna';
(filtrou a tabela de acordo com a informação especifica da coluna)
SELECT * 
FROM production.product 
WHERE color = 'blue' or color = 'black';
(filtrou a tabela de acordo com a informação especifica da coluna)
SELECT * 
FROM Production.Product 
WHERE ListPrice > 1500 and ListPrice < 2500;
(Comparação de preço usando Operadores logicos)
SELECT name 
FROM Production.Product 
WHERE ListPrice > 500 and ListPrice < 700;
(Comparação de preço usando Operadores logicos mas retornando somente os nomes dentro desse filtro)
SELECT * 
FROM Production.Product 
WHERE color <> 'red';
(Mostra todas as cores excerto o VERMELHO)
SELECT COUNT(*)
FROM Person.Person
(Quantidade de pessoas na tabela em geral junto com duplicadas)
SELECT COUNT(Title)
FROM Person.Person
(Quantidade de titulos junto com os duplicadas)
SELECT COUNT(DISTINCT Title)
FROM Person.Person
(Quantidade de titulos junto sem os duplicadas)
SELECT TOP 10 *
FROM tabela
(Escolha a Quantidade de linhas com as informações)
SELECT FirstName,LastName
FROM Person.Person
ORDER BY FirstName asc, LastName desc;
(Ordem crescente ASC e descrescente DESC)
SELECT TOP 10 ProductID, ListPrice
FROM Production.Product
ORDER BY ListPrice desc;
(Mostra 10 linhas na ordem descrescente da lista de valores e mostra o ID dos product)
SELECT ListPrice
FROM Production.Product
WHERE ListPrice between 1000 and 1500
ORDER BY ListPrice desc;
(Vai mostrar os valores entre 1000 e 1500 na pratica seria valor >= minimo and valor <= maximo)
SELECT ListPrice
FROM Production.Product
WHERE ListPrice not between 1000 and 1500
ORDER BY ListPrice desc;
(vai mostrar todos os valores sem o 1000 ate 1500)
Usamos o IN junto com WHERE para verificar se um valor correspondem com qualquer valor passado na lista de valores
SELECT *
FROM tabela
WHERE coluna1 IN (2,7,13);
Vamos dizer que voce não sabe o nome da pessoa e so ouviu o inicio do nome mas precisamos procurar o nome na lista, nisso usamos o LIKE
SELECT *
FROM person.person
WHERE FirstName like 'ovi%';
(ovi% - inicio do nome, %ovi - final do nome, %ovi% - nao sabe se é no inicio, meio ou fim do nome, %ro_ - vai fzr o query pela letra)

SELECT TOP 10 SUM(Linetotal)
FROM Sales.SalesOrderDetail
(SUM-soma, Vai somar as 10 linhas)
SELECT TOP 10 MIN(Linetotal)
FROM Sales.SalesOrderDetail
(MIN-Minimo, Vai mostrar o menor valor ou valor minimo)
SELECT TOP 10 MAX(Linetotal)
FROM Sales.SalesOrderDetail
(MAX-maximo, vai mostrar o valor maximo)
SELECT TOP 10 AVG(Linetotal)
FROM Sales.SalesOrderDetail
(AVG-media, vai mostrar a media)
--------------usando GROUP BY-----------------------
SELECT coluna1,funçãodeagregação(coluna2)
FROM tabela
GROUP BY coluna1
EX - 1
SELECT ProductID, COUNT(productID) AS "contagem", AVG(orderqty) AS "media"
FROM Production.WorkOrder
GROUP BY ProductID
EX - 2
(transformou isso no codigo a baixo)
SELECT SpecialOfferID, UnitPrice
FROM Sales.SalesOrderDetail
WHERE SpecialOfferID = '9'
SELECT SpecialOfferID,SUM(unitprice) AS "soma"
FROM Sales.SalesOrderDetail
GROUP BY SpecialOfferID
(Bem mais otimizado)
EX - 3
SELECT color, AVG(ListPrice)
FROM Production.Product
WHERE Color = 'silver'
GROUP BY Color
(media de preço de produtos com a cor silver)
-------------------HAVING-----------------------
A grande diferença entre having e WHERE é que o GROUP BY é aplicado depois que os dados ja foram agrupados, enquanto o WHERE é aplicado antes dos dados serem agrupados.
SELECT FirstName, COUNT(FirstName)
FROM Person.Person
GROUP BY FirstName
HAVING COUNT(firstname) > 10
(vai mostrar o nome e a Quantidade de vezes que esse nome aparece mais que 10 vezes)
SELECT FirstName, COUNT(FirstName)
FROM Person.Person
WHERE title = 'mr.'
GROUP BY FirstName
HAVING COUNT(FirstName) > 10
(usando o HAVING e o WHERE junto)
SELECT ProductID, SUM(LineTotal) AS "total"
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(linetotal) BETWEEN 162000 AND 500000
(Mostrando os produtos com valores entre 162k a 500k)
------------------------AS--------------------------
SELECT TOP 10 SUM(Linetotal) AS "soma" - vai dar o nome da coluna que irar aparecer as 10 linhas
FROM Sales.SalesOrderDetail
SELECT TOP 10 FirstName AS "primeiro nome", LastName AS "Sobrenome" - mudando nome da coluna ja existente
FROM Person.Person
OBS: Se colocar apenas uma palavra não necessita de ASPAS, caso ao contrario coloque as ASPAS
-----------------------JOINS---------------------
Existe 3 tipos de joins: Inner join, Outer join e Self-join
INNER JOIN:
EX 1:
SELECT P.BusinessEntityID,P.FirstName,P.LastName,PE.EmailAddress
FROM Person.Person AS P
INNER JOIN Person.EmailAddress AS PE ON P.BusinessEntityID = PE.BusinessEntityID
(Temos que achar uma coluna em comum com as duas tabelas, nisso criamos apelidos para as duas tabelas igual no person.person que é P e no person.emailaddress é PE e colocar seus apelido em suas devidas colunas, depois disso inserir o INNER JOIN com a tabela de fora junto com a coluna semelhante)
EX 2:
SELECT PR.ListPrice, PR.Name,PC.Name
FROM Production.Product AS PR
INNER JOIN Production.ProductSubcategory AS PC on PR.ProductSubcategoryID = PC.ProductSubcategoryID
EX 3:
SELECT TOP 10 *
FROM Person.BusinessEntityAddress BA
INNER JOIN Person.Address AS PA ON PA.AddressID = BA.AddressID
(Mesclou as Tabelas e as colunas)
-----------------------------------SELF JOIN-------------------------------
--SELECT A.NOME_COLUNA
--FROM TABELA A
--WHERE CONDIÇÃO
SELECT A.ContactName,A.Region,B.ContactName,B.Region
FROM Customers A, Customers B
WHERE A.Region = B.Region

SELECT A.FirstName, A.HireDate,B.FirstName,B.HireDate
FROM Employees A, Employees B
WHERE DATEPART(YEAR, A.HireDate) = DATEPART(YEAR,B.HireDate)
----------------------------LEFT,FULL JOINS------------------------------------------
SELECT *
FROM Person.StateProvince SP
LEFT JOIN Person.Address AS PA ON SP.StateProvinceID = PA.StateProvinceID
WHERE PA.StateProvinceID IS NULL
(Ele mescla as colunas - As colunas tem que ser as mesmas nas duas tabelas porem no WHERE pode colocar coluna que não esta presente no SELECT mas tem que existi na tabela, E ja remove as duplicadas)
SELECT PR.ListPrice, PR.Name,PC.Name
FROM Production.Product AS PR
FULL OUTER JOIN Production.ProductSubcategory AS PC on PR.ProductSubcategoryID = PC.ProductSubcategoryID
---------------UNION-----------------------------
EX 1:
SELECT ProductID,Name,ProductNumber
FROM Production.Product
WHERE Name LIKE '%chain%'
UNION
SELECT ProductID,Name,ProductNumber
FROM Production.Product
WHERE Color = 'black'
(Ele mescla as colunas - As colunas tem que ser as mesmas nas duas tabelas porem no WHERE pode colocar coluna que não esta presente no SELECT mas tem que existi na tabela, E ja remove as duplicadas)
EX 2:
SELECT FirstName,Title,MiddleName
FROM Person.Person
WHERE Title = 'Mr.'
UNION
SELECT FirstName,Title,MiddleName
FROM Person.Person
WHERE MiddleName = 'A'
EX 3:
SELECT FirstName,Title,MiddleName
FROM Person.Person
WHERE Title = 'Mr.'
UNION ALL
SELECT FirstName,Title,MiddleName
FROM Person.Person
WHERE MiddleName = 'A'
(Usa o UNION ALL Para Entrar todas as informações ate mesmo as duplicadas)
--------------------DATEPART---------------------------
(manipulação de data, para mais informações consultar a documentação DATEPART)
SELECT AVG(TotalDue) AS Media, DATEPART(YEAR, OrderDate) AS Ano
FROM Sales.SalesOrderHeader
GROUP BY DATEPART(YEAR,OrderDate)
ORDER BY Ano

SELECT AVG(TotalDue) AS Media, DATEPART(MONTH, OrderDate) AS Mes
FROM Sales.SalesOrderHeader
GROUP BY DATEPART(MONTH,OrderDate)
ORDER BY Mes

SELECT AVG(TotalDue) AS Media, DATEPART(DAY, OrderDate) AS Dia
FROM Sales.SalesOrderHeader
GROUP BY DATEPART(DAY,OrderDate)
ORDER BY Dia
--------------------manipulação com string------------------------
SELECT FirstName, LastName,CONCAT(FirstName,' ',LastName)AS 'Com espaço',CONCAT(FirstName,LastName)AS 'sem espaço'
FROM Person.Person
(Usamos o CONCAT para juntar as strings)

(Vai deixar a coluna Maiuscula(UPPER) e a outra Minuscula(LOWER))
SELECT UPPER(FirstName), LOWER(FirstName)
FROM Person.Person

SELECT FirstName,LEN(FirstName)
FROM Person.Person
(Vai contar a quantidade de letras da string usando o LEN)

SELECT FirstName ,SUBSTRING(FirstName,1,3)
FROM Person.Person
(Usando o SUBSTRING quero que do Indice 1 conte 3 letras, vai contar da primeira letra ate a terceira, se substituir o 1 por 2 vai contar do 2 ate a 3 letra)

SELECT ProductNumber ,REPLACE(ProductNumber,'-','alterado')
FROM Production.Product
(usamos o REPLACE para substituir alguma informação da coluna,'-'selecionei o que queria alterar,'alterado'coloquei o conteudo que queria que fosse inserido)
-----------------------Operações mat-------------------------------
SELECT UnitPrice * LineTotal
FROM Sales.SalesOrderDetail

SELECT UnitPrice + LineTotal
FROM Sales.SalesOrderDetail

SELECT UnitPrice / LineTotal
FROM Sales.SalesOrderDetail

SELECT UnitPrice - LineTotal
FROM Sales.SalesOrderDetail

SELECT UnitPrice * LineTotal
FROM Sales.SalesOrderDetail

SELECT UnitPrice + LineTotal
FROM Sales.SalesOrderDetail

SELECT UnitPrice / LineTotal
FROM Sales.SalesOrderDetail

SELECT ROUND(LineTotal,2),LineTotal
FROM Sales.SalesOrderDetail
(Para arredondar usamos o ROUND e dentro do round colocamos a precisão decima que vamos fazer o arredondamento)

SELECT SQRT(LineTotal),LineTotal
FROM Sales.SalesOrderDetail
(SQRT usamos para ver a raiz quadrada)
--------------------------SUBQUERY----------------------------
MODO MANUAL:
--Monte um relatorio para mim de todos os produtos cadastrados que tem preço de venda acima de media
--SELECT AVG(LISTPRICE)
--FROM Production.Product
--SELECT *
--FROM Production.Product
--WHERE ListPrice > 438.66
MODO USANDO SUBQUERY:
SELECT *
FROM Production.Product
WHERE ListPrice > (SELECT AVG(LISTPRICE) FROM Production.Product)

--Eu quero saber o nome dos meus funcionarios que tem o cargo de 'design Engineer'
SELECT FIRSTNAME
FROM Person.Person
WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM HumanResources.Employee WHERE JobTitle = 'Design Engineer')

SELECT *
FROM Person.Address
WHERE StateProvinceID IN (SELECT StateProvinceID FROM Person.StateProvince WHERE NAME = 'ALBERTA')
-------------------------TIPOS DE DADOS---------------------------------
1.BOLEANOS  
2.CARACTERE
3.NUMERO
4.TEMPORAIS

## 1. BOLEANOS
Por padrao ele é inicializado como nulo, e pode receber tanto 1 ou 0(comando: BIT)

## 2. CARACTERE
Tamanho fixo - char // permite inserir ate uma quantidade fixa de caracters e sempre ocupa todo o espaço reservado 10/50
Tamanhos variaveis - varchar ou nvarchar // permite inserir ate uma quantidade que for definida, porem só usa o espaço que for preenchido 10/50

## 3.NUMERO
1.TINYINT - não tem parte do valor fracionados (ex: 1.43, 24.25) somente 1,12345,123123123
2.SMALLINT - mesma coisa do TINYINT porem com limite maior
3.INT - mesma coisa do SMALLINT porem com limite maior
4.BIGINT - mesma coisa do INT porem com limite maior
5.NUMERIC ou DECIMAL - valores exatos, porem permite ter parte fracionadas, que tambem pode ser especificado a precisão e escala(escala é o numero de digitos na parte fracional) - EX: NUMERIC(5,2) -> 133,55
## VALORES APROXIMADOS
1. REAL - Tem precisão aproximada de ate 15 digitos
2. FLOAT - Tem precisão aproximada de ate 15 digitos

## 4.TEMPORAIS
DATE - armazena data no formato aaaa/mm/dd
DATETIME - armazena data e horas no formato aaaa/mm/dd:hh:mm:ss
DATETIME2 - data e hora com adição de milissegundos no formato aaaa/mm/dd:hh:mm:sssssss
SMALLDATETIME - data e hora respeitando os limites entre '1900-01-01:00:00:00' ate '2079-06-06:23:59:59'
TIME  - horas,minutos, segundos e milissegundos respeitando o limite de '00:00:00.0000000' e '23:59:59.9999999'
DATETIMEOFFSET - permite armazenar informações de data e horas incluindo o fuso horario
----------------------------PRIMARY KEY, STRANGER KEY-----------------------------------------
PRIMARY KEY(PK):
-uma chave primaria é basicamente uma coluna ou grupo de colunas, usada para identificar unicamente uma linha em uma tabela
-Você consegue criar essas chaves primarias atraves que restrições(ou constraints em ingles), que são regras que vc define quando está criando uma coluna
-Assim quando vc faz isso vc esta criando um indice unico para aquela coluna ou grupo de colunas
Ex:
CREATE TABLE NOME_TABELA(
    nomeCOLUNA tipododado PRIMARY KEY
    nomeCOLUNA tipododado ...
);
FOREIGN KEY constraints(FK):
-uma chave estrangeira é uma coluna ou grupo de colunas em uma tabela que identifica unicamente uma linha em outra tabela.
-ou seja, uma chave estrangeira é definida em uma tabela onde ela é apenas uma referencia e não contem todos os dados aplicado
-então uma chave estrangeira é simplesmente uma coluna ou grupo de colunas que é uma chave primaria em outra tabela
-A tabela que contem a chave estrangeira é chamada de tabela referenciadora ou tabela filho.E a tabela qual a chave estrangeira é referenciada é chamada de tabela referenciada ou tabela pratica
-uma tabela pode ter mais de uma chave estrangeira dependendo do seu relacionamento com as outras tabelas
-No SQL server vc define uma chave estrangeira atraves de um FOREIGN KEY constraints ou restrição de chave estrangeira
-uma restrição de chave estrangeira indica que os valores em uma coluna ou grupo de colunas na tabela filho correspondem aos valores na tabela pratica
-Nos podemos entender que uma chave estrangeira mantem a INTEGRIDADE REFERENCIAL 
Ex:
CREATE TABLE nome_tabela(
   nomeColuna tipododado restrições,
   nomeColuna tipododado FOREIGN KEY REFERENCES nomeDatabela(nomeDacoluna da outra tabela),
);
  PRIMARY KEY - ProductID         Categories
      -Productname               STRANGER KEY -CategoryID
      -supplierID                -Categoryname
      -CategoryID   ----->       -Description
      -Qtdperunit                -picture
      -unitprice
---------------------------CRIANDO TABELA-------------------------------------------
Principais tipos de restrições que podem ser aplicadas
NOT NULL - Não permite nulos
UNIQUE - Força que todos os valores em uma coluna sejam diferentes
PRIMARY KEY - uma junção de NOT NULL e UNIQUE
FOREIGN KEY - Idetifica unicamente uma linha em outra tabela
CHECK - FORÇA uma CONDIÇÃO especifica em uma coluna (So quero numero maior que 10, usando o CHECK a gente pode força essa condição)
DEFAULT - força um valor padrão quando nenhum valor é passado(podemos atribuir qual valor q seja)
   CREATE TABLE nomeDaTabela(
       coluna1 tipododado restrições,
       coluna2 tipododado restrições,
       coluna3 tipododado ,(sem restrições)
   );
Ex:
   CREATE TABLE Canal(
   CanalID INT PRIMARY KEY,
   Nome VARCHAR(150) NOT NULL,
   ContagemIncritos INT DEFAULT 0,
   DateCriacao DATETIME NOT NULL,
);
CREATE TABLE Video(
   VideoId INT PRIMARY KEY,
   Nome VARCHAR(150) NOT NULL,
   Visualizacoes INT DEFAULT 0,
   Likes INT DEFAULT 0,
   Deslike INT DEFAULT 0,
   Duracao INT NOT NULL,
   CanalID INT FOREIGN KEY REFERENCES Canal(CanalID)
   
);
-------------------------INSERT INTO--------------------------------------
INSERT INTO nome_tabela(coluna1,coluna2)
VALUES(valor1,valor2)

ou queria inserir varias linhas

INSERT INTO Aula(ID,Nome)
VALUES
(2,'Aula 2'),
(3,'Aula 3'),
(4,'Aula 4'),
(5,'Aula 5');

CASO QUERIA DUPLICAR OS DADOS MAS EM UMA TABELA INEXISTENTE:
SELECT * INTO tabelaNova FROM tabelaExistente
-----------------------------UPDATE------------------------------------
UPDATE nomeDaTabela
SET coluna1 = valor1(conteudo)
    coluna2 = valor2
WHERE condição(nao esqueça de colocar o WHERE, se nao vai alterar tudo, caso queria altera tudo deixe sem)

TABELA AULA:
ID | Nome
1  | Aula 1
2  | Aula 2
3  | Aula 3
4  | Aula 4

Ex 1: SEM WHERE
  UPDATE Aula
SET Nome = 'test'
ID | Nome
1  | test
2  | test
3  | test
4  | test

Ex 2: COM WHERE
UPDATE Aula
SET Nome = 'mudei agora'
WHERE ID = 2
ID | Nome
1  | test
2  | mudei agora
3  | test
4  | test
----------------------------DELETE FROM--------------------------------------
Usamos o delete para apagar uma linha da tabela
DELETE FROM nome_tabela
WHERE condição
OBS:Se colocar sem um where, vai deletar todo conteudo da tabela
 ID | Nome
1  | test
2  | mudei agora
3  | test
4  | test
5  | mudei agora

Ex 1:
 DELETE FROM Aula
 WHERE ID = 5
 ID | Nome
1  | test
2  | mudei agora
3  | test
4  | test

Ex 2:
DELETE FROM Aula
 ID | Nome
  VAZIO
------------------------------ALTER TABLE----------------------------------------
ALTER TABLE nome_tabela
Ação 

Exemplos do que pode ser feito com ALTER TABLE
- ADD, REMOVER, OU ALTERAR UMA COLUNAS
- Setar valores padroes para uma coluna
- add ou remover restrições
- renomear uma tabela

Ex 1:Adicionando uma nova coluna
ALTER TABLE nome_tabela
ADD nomeCOLUNA tipododado

Ex 2:Alterando o valor padrao de uma coluna
ALTER TABLE nome_tabela
ALTER COLUMN Nome VARCHAR (300) NOT NULL

Ex 3: Alterando o nome de uma coluna ja existente(OBS:So pode ser com este comando)
EXEC sp_rename 'nome_tabela.nomeCOLUNA', 'novoNomedaColuna', 'COLUMN' <---------NAO ESQUECER O COLUMN

Ex 4: Alterando o nome da tabela ja existente
EXEC sp_rename 'nome_tabelaAtual','novoNomeDatabela'
-----------------------------DROP TABLE e TRUNCATE TABLE------------------------------------------------
So pode apagar tabela que não tem referenciada(NAO TEM FOREIGN KEY)
DROP TABLE nomeDaTabela

Limpando uma tabela de forma otimizada
TRUNCATE TABLE nomeDaTabela
--------------------------------CHECK constraints----------------------------------------
CHECK - FORÇA uma CONDIÇÃO especifica em uma coluna (So quero numero maior que 10, usando o CHECK a gente pode força essa condição)
CREATE TABLE Carteira_motorista(
id INT NOT NULL,
Nome VARCHAR(250) NOT NULL,
idade INT CHECK(idade >= 18)
);

SELECT * FROM Carteira_motorista

INSERT INTO Carteira_motorista(id,Nome,idade)
VALUES (1,'jack',18) <-------- se for menor que 18 vai reclamar erro
----------------------------NOT NULL constraints-----------------------------------
NOT NULL força com que não seja possivel inserir dados em uma tabela sem preencher a coluna marcada como NOT NULL(nao permite campo vazios)
CREATE TABLE Carteira_motorista(
id INT NOT NULL,
Nome VARCHAR(250) NOT NULL,
idade INT CHECK(idade >= 18)
);

INSERT INTO Carteira_motorista(id,Nome,idade)
VALUES (1,'',18) <------- nao permite campos vazios
---------------------UNIQUE constraints----------------------------------------------
UNIQUE - Deixando somente o conteudo unico sem duplicar
CREATE TABLE Carteira_motorista(
id INT NOT NULL,
Nome VARCHAR(250) NOT NULL,
idade INT CHECK(idade >= 18),
CodigoCNH INT NOT NULL UNIQUE
);

INSERT INTO Carteira_motorista(id,Nome,idade,CodigoCNH)
VALUES (1,'JACK',19,548869)
INSERT INTO Carteira_motorista(id,Nome,idade,CodigoCNH)
VALUES (1,'JACK',19,548869)
(vai reclamar erro pois esse codigo de cnh ja existe)

SELECT * FROM Carteira_motorista
-----------------------------VIEWS---------------------------
Usado para relatorios, que são tabelas criadas para consulta onde vc usa outras tabelas como base para criar uma nova tabela de pesquisa so que com apenas dados especificados por vc
CREATE VIEW [Nome da tabela que voce quer] AS <---- tudo que vem dps do AS vai ser as informações que vc quer especificar 
SELECT FirstName, middlename,LastName
FROM Person.Person
WHERE Title = 'Ms.'

SELECT * FROM Nome da tabela que voce criou
