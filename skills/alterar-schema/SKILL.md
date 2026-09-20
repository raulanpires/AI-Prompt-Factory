---
name: alterar-schema
description: Alterações ao schema Supabase do ENGEST — colunas, tabelas, índices, políticas RLS. Usar sempre que a tarefa implique migração.
---

Alteração de schema é decisão, não facto. Nunca a executes sem aprovação explícita.

1. Lê `context/schema-v4.md` e o estado real no Supabase. Se divergem, para e reporta.
2. Escreve a migração **e o rollback**, lado a lado.
3. Declara o impacto em RLS: que políticas tocam esta tabela, e se continuam a valer.
4. Declara o impacto em campos calculados.
5. Apresenta tudo. Espera aprovação.
6. Só depois aplica.

Portão de saída: migração aplicada · rollback testado · RLS verificada linha a linha ·
`context/schema-v4.md` atualizado no mesmo commit.
