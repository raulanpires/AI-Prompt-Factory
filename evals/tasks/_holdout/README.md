# _holdout/

Quatro tarefas que **não** se usam para iterar. Correm só em portões de decisão.

Se iterares contra elas, deixam de ser reserva e tornam-se fixtures como as
outras — a pontuação delas passa a só poder subir.

Mesma montagem das tarefas da régua. Minadas do mesmo repositório, com a mesma
qualidade de ground truth.

| Tarefa | PR | Commit base | Sintoma |
| --- | --- | --- | --- |
| h01 | #6493 | `9700f9b73b19b8f79612aad5a60529eb2240503f` | fixar linhas deixa de funcionar depois de desagrupar |
| h02 | #6431 | `4cb3a7d2c6fb75215c546075ca7f28a74c8427ad` | em modo de ordenação única, ordenar por nova coluna não substitui a anterior |
| h03 | #6439 | `05edac5768d3d67bd233b31f6c569d5418dae7d2` | filtro global aplica-se a colunas que não o pediram explicitamente |
| h04 | #6433 | `f7ea1ed52be394a208e1c0bd526040294dd56cb8` | filtros automáticos falham em colunas que aceitam null |

Ficheiros de código e de teste de cada PR: `git show <pr-sha> --name-only` no clone.
