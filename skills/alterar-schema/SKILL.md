---
name: alterar-schema
description: Alterações ao schema da base de dados — colunas, tabelas, índices, políticas de acesso. Usar sempre que a tarefa implique migração.
evaluated: none
---

Alteração de schema é decisão, não facto. Nunca a executes sem aprovação explícita.

1. Lê o ficheiro de schema em `context/` e o estado real da base de dados.
   Se divergem, para e reporta antes de mais nada.
2. Escreve a migração **e o rollback**, lado a lado.
3. Declara o impacto nas políticas de acesso: quais tocam esta tabela, e se continuam a valer.
4. Declara o impacto em campos calculados e em dados existentes.
5. Apresenta tudo. Espera aprovação.
6. Só depois aplica.

Portão de saída: migração aplicada · rollback testado · políticas de acesso verificadas
uma a uma · ficheiro de schema em `context/` atualizado no mesmo commit.
