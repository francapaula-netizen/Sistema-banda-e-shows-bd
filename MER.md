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

---

## 4. Diagrama Entidade e Relacionamento (DER)

```mermaid
erDiagram
    BANDA ||--|{ INTEGRANTE : possui
    BANDA ||--|{ SHOW : realiza
    LOCAL ||--|{ SHOW : sedia

    BANDA {
        int id_banda PK
        string nome_banda
        string genero_musical
        int ano_formacao
    }

    INTEGRANTE {
        int id_integrante PK
        string nome_integrante
        string cpf
        string instrumento
        string telefone
    }

    LOCAL {
        int id_local PK
        string nome_local
        int capacidade
        string cidade
        string estado
    }

    SHOW {
        int id_show PK
        date data_show
        float preco_ingresso
    }
