-- =========================================================================
-- PROJETO: SISTEMA CATÁLOGO DE BANDAS E SHOWS
-- ARQUIVO: script-dml.sql (Povoamento Orientado a Cenários Reais)
-- =========================================================================

USE BandasShowsDB;

-- =========================================================================
-- Cenário 1 — Configuração Inicial do Catálogo e Espaços Culturais:
-- Antes de iniciar a temporada de eventos de 2026, a produtora cadastrou os
-- cinco gêneros musicais principais atendidos pela plataforma e homologou
-- cinco casas de espetáculos e teatros em diferentes capitais brasileiras,
-- inventariando também os equipamentos de som e luz disponíveis em cada local.
-- =========================================================================

INSERT INTO GeneroMusical (id_genero, nome_genero, descricao, origem_historica, ativo) VALUES
(1, 'Rock Alternativo', 'Vertente independente do rock com foco em guitarras e letras autorais', 'Anos 1980 - Reino Unido/EUA', TRUE),
(2, 'MPB', 'Música Popular Brasileira contemporânea e fusões acústicas', 'Anos 1960 - Brasil', TRUE),
(3, 'Heavy Metal', 'Som pesado com distorção acentuada e vocais técnicos', 'Final dos anos 1960 - Inglaterra', TRUE),
(4, 'Indie Pop', 'Pop independente com arranjos eletrônicos e melódicos', 'Anos 1990 - Reino Unido', TRUE),
(5, 'Samba Rock', 'Fusão rítmica entre samba tradicional, soul e funk', 'Anos 1960 - São Paulo/Brasil', TRUE);

INSERT INTO LocalEvento (id_local, nome_local, capacidade, cidade, estado, tipo_espaco) VALUES
(1, 'Circo Voador', 2000, 'Rio de Janeiro', 'RJ', 'Lona Cultural / Casa de Shows'),
(2, 'Audio Club', 3200, 'São Paulo', 'SP', 'Casa de Espetáculos'),
(3, 'Teatro Rival Refit', 450, 'Rio de Janeiro', 'RJ', 'Teatro'),
(4, 'Opinião Bar', 1200, 'Porto Alegre', 'RS', 'Casa de Shows'),
(5, 'Autêntica BH', 1500, 'Belo Horizonte', 'MG', 'Casa de Espetáculos');

INSERT INTO EquipamentoSom (id_equipamento, nome_equipamento, categoria, quantidade, estado_conservacao, id_local) VALUES
(1, 'Mesa Digital Yamaha CL5', 'Áudio / Mixagem', 1, 'Excelente', 1),
(2, 'Sistema Line Array JBL VTX', 'Sonorização PA', 2, 'Excelente', 2),
(3, 'Kit Microfones Shure SM58/SM57', 'Captação', 12, 'Bom', 3),
(4, 'Console de Iluminação GrandMA2', 'Iluminação Cênica', 1, 'Excelente', 4),
(5, 'Monitores de Retorno Ativos QSC', 'Retorno de Palco', 8, 'Bom', 5);


-- =========================================================================
-- Cenário 2 — Credenciamento das Bandas Independentes e seus Integrantes:
-- Com os locais preparados, cinco bandas do circuito independente assinaram
-- contrato de representação para a temporada e realizaram o cadastro oficial
-- de seus grupos e dos músicos titulares (respeitando a regra de que cada
-- integrante pertence a apenas uma banda no sistema).
-- =========================================================================

INSERT INTO Banda (id_banda, nome_banda, ano_formacao, cidade_origem, cache_base, id_genero) VALUES
(1, 'Ecos do Asfalto', 2018, 'São Paulo', 4500.00, 1),
(2, 'Maré Alta Acústico', 2020, 'Rio de Janeiro', 3800.00, 2),
(3, 'Forja de Ferro', 2015, 'Belo Horizonte', 6000.00, 3),
(4, 'Neon Tropical', 2021, 'Porto Alegre', 3200.00, 4),
(5, 'Balanco da Vila', 2017, 'São Paulo', 5000.00, 5);

INSERT INTO Integrante (id_integrante, nome_integrante, cpf, instrumento, telefone, data_entrada, id_banda) VALUES
(1, 'Lucas Almeida Mendes', '12345678901', 'Guitarra Solo e Vocal', '(11) 98765-4321', '2018-03-10', 1),
(2, 'Mariana Costa Silveira', '23456789012', 'Baixo Elétrico', '(11) 97654-3210', '2018-04-01', 1),
(3, 'Rafael Nunes Ferreira', '34567890123', 'Violão e Voz', '(21) 99876-5432', '2020-01-15', 2),
(4, 'Thiago Rocha Martins', '45678901234', 'Bateria', '(31) 98877-6655', '2015-08-20', 3),
(5, 'Camila Duarte Ribeiro', '56789012345', 'Sintetizador e Vocal', '(51) 99123-4567', '2021-06-12', 4),
(6, 'Bruno Henrique Souza', '67890123456', 'Percussão e Cavaco', '(11) 99444-3322', '2017-09-05', 5);


-- =========================================================================
-- Cenário 3 — Abertura da Agenda de Shows (Realizados e Futuros):
-- A produção lançou o calendário oficial do semestre. Os dois primeiros shows
-- aconteceram em março e abril com casa cheia, enquanto outras três datas
-- ficaram agendadas para os meses seguintes em diferentes cidades.
-- =========================================================================

INSERT INTO ShowEvento (id_show, titulo_evento, data_show, horario_abertura, preco_ingresso, status_show, id_banda, id_local) VALUES
(1, 'Noite do Rock Independente', '2026-03-14', '21:00:00', 60.00, 'Realizado', 1, 2),
(2, 'Sarau Maré Alta no Rival', '2026-04-18', '19:30:00', 50.00, 'Realizado', 2, 3),
(3, 'Festival Metal das Gerais', '2026-06-20', '20:00:00', 80.00, 'Agendado', 3, 5),
(4, 'Turnê Sul Neon Tropical', '2026-07-11', '22:00:00', 45.00, 'Agendado', 4, 4),
(5, 'Roda de Samba Rock na Lapa', '2026-08-22', '21:30:00', 70.00, 'Agendado', 5, 1);


-- =========================================================================
-- Cenário 4 — Captação de Patrocinadores e Fechamento de Cotas:
-- Para viabilizar a estrutura técnica e a divulgação das turnês, cinco
-- marcas parceiras foram cadastradas e vincularam cotas de patrocínio
-- aos espetáculos da temporada.
-- =========================================================================

INSERT INTO Patrocinador (id_patrocinador, nome_empresa, cnpj, segmento, email_contato) VALUES
(1, 'Cervejaria Artesanal Lúpulo Vivo', '11222333000181', 'Bebidas', 'eventos@lupulovivo.com.br'),
(2, 'Cordas & Amplificadores Brasil', '22333444000192', 'Instrumentos Musicais', 'marketing@cordasbrasil.com.br'),
(3, 'Rádio Cidade Alternativa FM', '33444555000103', 'Comunicação e Mídia', 'parcerias@cidadealternativa.fm'),
(4, 'Estúdio Som & Fita Gravações', '44555666000114', 'Produção Fonográfica', 'contato@somefita.com.br'),
(5, 'Energético VoltMax', '55666777000125', 'Bebidas Energéticas', 'patrocinios@voltmax.com.br');

INSERT INTO ShowPatrocinio (id_show, id_patrocinador, valor_cota, tipo_cota, data_contrato) VALUES
(1, 1, 5000.00, 'Ouro', '2026-02-10'),
(1, 3, 2500.00, 'Mídia Partner', '2026-02-15'),
(2, 4, 3000.00, 'Prata', '2026-03-20'),
(3, 2, 7500.00, 'Master', '2026-05-02'),
(4, 5, 4000.00, 'Ouro', '2026-05-28'),
(5, 1, 6000.00, 'Master', '2026-06-15');
