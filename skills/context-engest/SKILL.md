---
name: context-engest
description: Carrega o contexto do ENGEST — stack, schema v4, restrições duras, vocabulário e regras de UI. Usar antes de qualquer trabalho no repositório ENGEST.
---

Lê `context/engest.md` antes de propor ou alterar seja o que for.
Se a tarefa toca em base de dados, lê também `context/schema-v4.md`.

Restrições duras. Violar uma anula a tarefa:

- RLS nunca quebra.
- `margem_valor` nunca é escrita.
- Não existe `/src`. Não se usa styled-jsx.
- Âmbar = custo, verde = margem, azul = venda.

Factos sobre o projeto vais buscar sozinho aos ficheiros. Decisões pergunta sempre.
