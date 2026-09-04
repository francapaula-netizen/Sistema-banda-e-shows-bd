# Sistema Catálogo de Bandas e Shows

## Minimundo (Descrição do Contexto)
O gerenciamento de eventos musicais, agendamento de apresentações e controle de integrantes de bandas costumam ser tarefas descentralizadas e suscetíveis a erros de organização. Este banco de dados visa resolver o problema da falta de centralização de dados no mercado musical independente, permitindo que organizadores de eventos e empresários consigam gerenciar bandas, seus músicos, os locais disponíveis para eventos e o histórico completo de apresentações realizadas.

## Regras de Negócio e Processos Principais
1. **Cadastro de Bandas:** O sistema deve registrar bandas musicais informando seu nome, gênero musical principal e ano de formação.
2. **Gestão de Integrantes:** Cada banda possui um ou mais integrantes (músicos). É necessário armazenar o nome do músico, CPF, telefone e o instrumento que ele toca na banda. Um músico pertence a apenas uma banda no sistema.
3. **Locais de Shows:** O sistema deve cadastrar os locais (casas de shows, teatros, arenas) com nome do espaço, capacidade máxima de público, cidade e estado.
4. **Agendamento de Shows:** O sistema deve registrar os shows realizados ou agendados, vinculando qual banda tocará em qual local, registrando a data do evento e o valor do ingresso.
5. **Tarefas Atendidas:**
   * Listar todos os integrantes de uma determinada banda e seus respectivos instrumentos.
   * Registrar o local e a data em que uma banda irá se apresentar.
   * Consultar o histórico completo de shows filtrados por cidade.
# Especificação Conceitual do Banco de Dados (MER)

## 1. Entidades

* **BANDA:** Representa o grupo musical cadastrado no sistema.
* **INTEGRANTE:** Representa cada músico que faz parte de uma banda e executa um instrumento específico.
* **LOCAL:** Representa a casa de show, arena ou estabelecimento onde acontecem as apresentações.
* **SHOW:** Representa o evento/apresentação agendado entre uma banda e um local em uma data específica.

---

## 2. Relacionamentos e Cardinalidades

* **[BANDA] (1,1) — possui — (1,N) [INTEGRANTE]**
  * **Explicação:** Uma Banda deve ter obrigatoriamente 1 ou N (vários) Integrantes. Cada Integrante pertence a exatamente 1 Banda.

* **[BANDA] (0,N) — realiza — (1,1) [SHOW]**
  * **Explicação:** Uma Banda pode realizar 0 ou N (vários) Shows ao longo do tempo. No entanto, cada Show é realizado por exatamente 1 Banda.

* **[LOCAL] (0,N) — sedia — (1,1) [SHOW]**
  * **Explicação:** Um Local pode sediar 0 ou N (vários) Shows. Porém, cada Show ocorre em exatamente 1 Local específico.

---

## 3. Sugestão de Atributos

* **BANDA**
  * `id_banda` (Chave Primária - PK)
  * `nome_banda` (Simples)
  * `genero_musical` (Simples)
  * `ano_formacao` (Simples)

* **INTEGRANTE**
  * `id_integrante` (Chave Primária - PK)
  * `nome_integrante` (Simples)
  * `cpf` (Simples / Identificador Único)
  * `instrumento` (Simples)
  * `telefone` (Simples)

* **LOCAL**
  * `id_local` (Chave Primária - PK)
  * `nome_local` (Simples)
  * `capacidade` (Simples)
  * `cidade` (Simples)
  * `estado` (Simples)

* **SHOW**
  * `id_show` (Chave Primária - PK)
  * `data_show` (Simples)
  * `preco_ingresso` (Simples)

























































































































































































































































































8
