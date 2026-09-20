---
name: carregar-contexto
description: Carrega o contexto do projeto atual — stack, convenções, restrições duras, vocabulário. Usar antes de qualquer trabalho num repositório coberto pela Factory.
---

Lê todos os ficheiros de `context/` antes de propor ou alterar seja o que for.
Se a tarefa toca na base de dados, lê também o ficheiro de schema.

As restrições duras listadas em `context/` não são conselhos. Violar uma anula a tarefa.

Se `context/` estiver vazio ou desatualizado em relação ao código, para e diz.
Não preenchas as lacunas por dedução — um contexto inventado é pior do que nenhum.

Divisão de trabalho a partir daqui:

- **Factos** vais buscar sozinho aos ficheiros. Perguntar um facto que podias ler é falha tua.
- **Decisões** nunca assumes: trade-offs, convenções novas, qualquer coisa irreversível.
