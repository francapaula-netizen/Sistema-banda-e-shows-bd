-- =========================================================================
-- AULA PRÁTICA: NORMALIZAÇÃO DE DADOS (1FN, 2FN e 3FN) E MAPEAMENTO DER->SQL
-- Contexto: Sistema Catálogo de Bandas e Shows
-- =========================================================================

-- Remove o banco de dados se ele já existir para reiniciar os testes
DROP DATABASE IF EXISTS BandasShowsDB;

-- Criação e seleção do banco de dados
CREATE DATABASE BandasShowsDB;
USE BandasShowsDB;


-- =========================================================================
-- CONCEITO DE NORMALIZAÇÃO DE DADOS
-- "A chave, toda a chave, e nada além da chave!"
-- =========================================================================


-- =========================================================================
-- 1. TABELA BANDA (Aplicando 1FN e 3FN)
--
-- APLICAÇÃO DA 1ª FORMA NORMAL (1FN - ATOMICIDADE):
-- 1. Atributos simples e atômicos: nome_banda, genero_musical e ano_formacao.
--
-- APLICAÇÃO DA 3ª FORMA NORMAL (3FN - ELIMINAÇÃO DE DEPENDÊNCIA TRANSITIVA):
-- 1. Nenhum atributo não-chave depende de outro atributo não-chave.
-- =========================================================================
CREATE TABLE Banda (
  -- id_banda: Chave Primária Artificial (Surrogate Key)
  id_banda INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
  nome_banda VARCHAR(100) NOT NULL,
  genero_musical VARCHAR(50) NOT NULL,
  ano_formacao INT NOT NULL
);


-- =========================================================================
-- 2. TABELA INTEGRANTE (Aplicando 1FN e 3FN)
--
-- APLICAÇÃO DA 1ª FORMA NORMAL (1FN):
-- 1. Cada atributo (nome_integrante, cpf, instrumento, telefone) é atômico.
-- 2. Cada músico pertence a apenas 1 banda (relacionamento 1:N com a tabela Banda).
--
-- APLICAÇÃO DA 3ª FORMA NORMAL (3FN):
-- 1. Mantemos apenas a FK 'id_banda'. O nome ou gênero da banda NÃO são
--    duplicados aqui para evitar dependência transitiva e redundância.
-- =========================================================================
CREATE TABLE Integrante (
  id_integrante INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
  nome_integrante VARCHAR(100) NOT NULL,
  cpf CHAR(11) NOT NULL UNIQUE,
  instrumento VARCHAR(50) NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  
  -- FK ligando ao grupo/banda (3FN mantida)
  id_banda INT UNSIGNED NOT NULL,

  CONSTRAINT fk_integrante_banda
    FOREIGN KEY (id_banda)
    REFERENCES Banda(id_banda)
    ON DELETE CASCADE
);


-- =========================================================================
-- 3. TABELA LOCAL (Tabela Base para os Locais de Espetáculo)
--
-- APLICAÇÃO DA 1ª E 3ª FORMA NORMAL (1FN / 3FN):
-- 1. Armazena as informações atômicas das casas de show, teatros ou arenas.
-- =========================================================================
CREATE TABLE Local (
  id_local INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
  nome_local VARCHAR(100) NOT NULL,
  capacidade INT UNSIGNED NOT NULL,
  cidade VARCHAR(60) NOT NULL,
  estado CHAR(2) NOT NULL
);


-- =========================================================================
-- 4. TABELA SHOW (Aplicando 2FN e 3FN - Entidade de Eventos)
--
-- CONCEITO: Relacionamento entre Banda e Local em uma determinada data.
--
-- APLICAÇÃO DA 2ª E 3ª FORMA NORMAL (2FN / 3FN):
-- 1. Evita redundâncias isolando os dados do evento (data_show e preco_ingresso).
-- 2. O nome da banda, nome do local e cidade NÃO são duplicados nesta tabela;
--    são obtidos via relacionamento através das FKs id_banda e id_local.
-- =========================================================================
CREATE TABLE `Show` (
  id_show INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
  data_show DATE NOT NULL,
  preco_ingresso DECIMAL(10,2) NOT NULL,
  
  -- Chaves Estrangeiras (FKs)
  id_banda INT UNSIGNED NOT NULL,
  id_local INT UNSIGNED NOT NULL,

  CONSTRAINT fk_show_banda
    FOREIGN KEY (id_banda)
    REFERENCES Banda(id_banda),

  CONSTRAINT fk_show_local
    FOREIGN KEY (id_local)
    REFERENCES Local(id_local)
);


-- =========================================================================
-- 5. INSERÇÃO DE DADOS (DML) - POVOAMENTO DO BANCO DE DADOS
-- =========================================================================

-- Inserindo Bandas
INSERT INTO Banda (id_banda, nome_banda, genero_musical, ano_formacao) VALUES
(1, 'Os Paralamas do Sucesso', 'Rock Nacional', 1982),
(2, 'Legião Urbana', 'Rock Nacional', 1982),
(3, 'Iron Maiden', 'Heavy Metal', 1975);

-- Inserindo Integrantes (Associados às bandas via id_banda)
INSERT INTO Integrante (id_integrante, nome_integrante, cpf, instrumento, telefone, id_banda) VALUES
(1, 'Herbert Vianna', '11122233344', 'Guitarra/Vocal', '(21) 99999-1111', 1),
(2, 'Bi Ribeiro', '22233344455', 'Baixo', '(21) 99999-2222', 1),
(3, 'João Barone', '33344455566', 'Bateria', '(21) 99999-3333', 1),
(4, 'Renato Russo', '44455566677', 'Vocal', '(61) 98888-4444', 2),
(5, 'Bruce Dickinson', '55566677788', 'Vocal', '+44 20 7946 0912', 3);

-- Inserindo Locais de Shows
INSERT INTO Local (id_local, nome_local, capacidade, cidade, estado) VALUES
(1, 'Audio Club', 3200, 'São Paulo', 'SP'),
(2, 'Circo Voador', 2500, 'Rio de Janeiro', 'RJ'),
(3, 'Km de Vantagens Hall', 8000, 'Belo Horizonte', 'MG');

-- Inserindo Agendamento de Shows
INSERT INTO `Show` (id_show, data_show, preco_ingresso, id_banda, id_local) VALUES
(101, '2026-05-15', 120.00, 1, 1), -- Paralamas na Audio Club (SP)
(102, '2026-06-20', 150.00, 1, 2), -- Paralamas no Circo Voador (RJ)
(103, '2026-07-10', 300.00, 3, 1), -- Iron Maiden na Audio Club (SP)
(104, '2026-08-05', 90.00,  2, 3); -- Legião Urbana em BH


-- =========================================================================
-- 6. CONSULTAS DEMONSTRATIVAS DAS FORMAS NORMAIS (DQL)
-- =========================================================================

-- -------------------------------------------------------------------------
-- TAREFA 1: Listar todos os integrantes de uma determinada banda 
-- e seus respectivos instrumentos (Demonstração de 1FN e 3FN via JOIN).
-- -------------------------------------------------------------------------
SELECT 
    b.nome_banda AS 'Banda',
    i.nome_integrante AS 'Integrante',
    i.instrumento AS 'Instrumento',
    i.telefone AS 'Telefone'
FROM Banda b
INNER JOIN Integrante i ON b.id_banda = i.id_banda
WHERE b.id_banda = 1;


-- -------------------------------------------------------------------------
-- TAREFA 2: Registrar local e data em que uma banda irá se apresentar.
-- Reconstruindo a visão completa via JOIN sem duplicar dados nas tabelas.
-- -------------------------------------------------------------------------
SELECT 
    s.id_show AS 'Cód. Show',
    b.nome_banda AS 'Banda',
    l.nome_local AS 'Local',
    l.cidade AS 'Cidade',
    l.estado AS 'UF',
    s.data_show AS 'Data do Evento',
    s.preco_ingresso AS 'Valor Ingresso (R$)'
FROM `Show` s
INNER JOIN Banda b ON s.id_banda = b.id_banda
INNER JOIN Local l ON s.id_local = l.id_local
ORDER BY s.data_show;


-- -------------------------------------------------------------------------
-- TAREFA 3: Consultar o histórico completo de shows filtrados por cidade 
-- com agrupamento e contagem de eventos.
-- -------------------------------------------------------------------------
SELECT 
    l.cidade AS 'Cidade',
    l.nome_local AS 'Local de Evento',
    b.nome_banda AS 'Banda',
    s.data_show AS 'Data do Show',
    s.preco_ingresso AS 'Preço do Ingresso'
FROM `Show` s
INNER JOIN Banda b ON s.id_banda = b.id_banda
INNER JOIN Local l ON s.id_local = l.id_local
WHERE l.cidade = 'São Paulo'
ORDER BY s.data_show;
