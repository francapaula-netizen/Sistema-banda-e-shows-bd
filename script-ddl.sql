-- =========================================================================
-- PROJETO: SISTEMA CATÁLOGO DE BANDAS E SHOWS
-- ARQUIVO: script-ddl.sql (Definição da Estrutura do Banco de Dados)
-- =========================================================================

DROP DATABASE IF EXISTS BandasShowsDB;
CREATE DATABASE BandasShowsDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE BandasShowsDB;

-- -------------------------------------------------------------------------
-- 1. TABELA GENERO_MUSICAL (Tabela Pai)
-- -------------------------------------------------------------------------
CREATE TABLE GeneroMusical (
    id_genero INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome_genero VARCHAR(50) NOT NULL UNIQUE,
    descricao VARCHAR(200) NOT NULL,
    origem_historica VARCHAR(80) DEFAULT 'Não informada',
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);

-- -------------------------------------------------------------------------
-- 2. TABELA BANDA (Tabela Filha de GeneroMusical / Pai de Integrante e Show)
-- -------------------------------------------------------------------------
CREATE TABLE Banda (
    id_banda INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome_banda VARCHAR(100) NOT NULL UNIQUE,
    ano_formacao YEAR NOT NULL,
    cidade_origem VARCHAR(60) NOT NULL,
    cache_base DECIMAL(10,2) NOT NULL DEFAULT 1500.00,
    id_genero INT UNSIGNED NOT NULL,
    
    CONSTRAINT chk_banda_cache CHECK (cache_base >= 0),
    CONSTRAINT fk_banda_genero 
        FOREIGN KEY (id_genero) REFERENCES GeneroMusical(id_genero)
);

-- -------------------------------------------------------------------------
-- 3. TABELA INTEGRANTE (Tabela Filha de Banda)
-- -------------------------------------------------------------------------
CREATE TABLE Integrante (
    id_integrante INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome_integrante VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    instrumento VARCHAR(50) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    data_entrada DATE NOT NULL,
    id_banda INT UNSIGNED NOT NULL,
    
    CONSTRAINT fk_integrante_banda 
        FOREIGN KEY (id_banda) REFERENCES Banda(id_banda)
        ON DELETE CASCADE
);

-- -------------------------------------------------------------------------
-- 4. TABELA LOCAL_EVENTO (Tabela Pai)
-- -------------------------------------------------------------------------
CREATE TABLE LocalEvento (
    id_local INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome_local VARCHAR(100) NOT NULL,
    capacidade INT UNSIGNED NOT NULL,
    cidade VARCHAR(60) NOT NULL,
    estado CHAR(2) NOT NULL,
    tipo_espaco VARCHAR(40) NOT NULL DEFAULT 'Casa de Shows',
    
    CONSTRAINT chk_local_capacidade CHECK (capacidade > 0)
);

-- -------------------------------------------------------------------------
-- 5. TABELA EQUIPAMENTO_SOM (Tabela Filha de LocalEvento)
-- -------------------------------------------------------------------------
CREATE TABLE EquipamentoSom (
    id_equipamento INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome_equipamento VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    quantidade INT UNSIGNED NOT NULL DEFAULT 1,
    estado_conservacao VARCHAR(30) NOT NULL DEFAULT 'Bom',
    id_local INT UNSIGNED NOT NULL,
    
    CONSTRAINT chk_equip_qtd CHECK (quantidade > 0),
    CONSTRAINT fk_equipamento_local 
        FOREIGN KEY (id_local) REFERENCES LocalEvento(id_local)
        ON DELETE CASCADE
);

-- -------------------------------------------------------------------------
-- 6. TABELA SHOW_EVENTO (Tabela Filha de Banda e LocalEvento)
-- -------------------------------------------------------------------------
CREATE TABLE ShowEvento (
    id_show INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    titulo_evento VARCHAR(120) NOT NULL,
    data_show DATE NOT NULL,
    horario_abertura TIME NOT NULL DEFAULT '20:00:00',
    preco_ingresso DECIMAL(10,2) NOT NULL,
    status_show VARCHAR(30) NOT NULL DEFAULT 'Agendado',
    id_banda INT UNSIGNED NOT NULL,
    id_local INT UNSIGNED NOT NULL,
    
    CONSTRAINT chk_show_preco CHECK (preco_ingresso >= 0),
    CONSTRAINT chk_show_status CHECK (status_show IN ('Agendado', 'Realizado', 'Cancelado')),
    CONSTRAINT fk_show_banda 
        FOREIGN KEY (id_banda) REFERENCES Banda(id_banda),
    CONSTRAINT fk_show_local 
        FOREIGN KEY (id_local) REFERENCES LocalEvento(id_local)
);

-- -------------------------------------------------------------------------
-- 7. TABELA PATROCINADOR (Tabela Pai)
-- -------------------------------------------------------------------------
CREATE TABLE Patrocinador (
    id_patrocinador INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome_empresa VARCHAR(100) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE,
    segmento VARCHAR(60) NOT NULL,
    email_contato VARCHAR(100) NOT NULL UNIQUE
);

-- -------------------------------------------------------------------------
-- 8. TABELA SHOW_PATROCINIO (Tabela Associativa N:M entre Show e Patrocinador)
-- -------------------------------------------------------------------------
CREATE TABLE ShowPatrocinio (
    id_show INT UNSIGNED NOT NULL,
    id_patrocinador INT UNSIGNED NOT NULL,
    valor_cota DECIMAL(10,2) NOT NULL,
    tipo_cota VARCHAR(30) NOT NULL DEFAULT 'Apoio',
    data_contrato DATE NOT NULL,
    
    PRIMARY KEY (id_show, id_patrocinador),
    CONSTRAINT chk_patrocinio_valor CHECK (valor_cota > 0),
    CONSTRAINT fk_sp_show 
        FOREIGN KEY (id_show) REFERENCES ShowEvento(id_show)
        ON DELETE CASCADE,
    CONSTRAINT fk_sp_patrocinador 
        FOREIGN KEY (id_patrocinador) REFERENCES Patrocinador(id_patrocinador)
);
