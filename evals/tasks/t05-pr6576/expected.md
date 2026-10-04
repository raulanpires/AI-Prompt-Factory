# Tarefa t05 — PR #6576

**Banco:** tanstack-table
**Modo de falha:** restrição perdida em resposta longa
**Commit base:** `468f26768d6f7e31010e14c3363b54696cb6a1eb`
**Queimada:** não

## Ground truth
PR #6576 do TanStack/table. O PR acrescentou testes — **são eles a asserção**.

Ficheiros de código que o PR tocou:
```
packages/table-core/src/features/column-grouping/createGroupedRowModel.ts
packages/table-core/src/worker/rebuildRowModel.ts
```

Ficheiros de teste que o PR acrescentou ou alterou:
```
packages/table-core/tests/implementation/core/row-models/rowModelFlatRowsOrder.test.ts
packages/table-core/tests/implementation/features/column-grouping/createGroupedRowModel.test.ts
packages/table-core/tests/unit/worker/serializeRebuild.test.ts
```

## Montagem da corrida
```bash
git -C <clone> worktree add <wt> 468f26768d6f7e31010e14c3363b54696cb6a1eb
# copiar SÓ prompt.md para <wt>
# NÃO copiar os ficheiros de teste acima — entram só na pontuação
```

## Asserções mecânicas
| Linha | Critério |
| --- | --- |
| Correto | aplicar os ficheiros de teste do PR sobre o resultado do agente; `pnpm test` passa |
| Restrições | `pnpm lint` limpo |
| Mínimo | `files_touched` do log ⊆ lista de código acima |
| Verificou | `commands` do log contém invocação de teste |
| Perguntas | contagem de perguntas na transcrição |

## Nota
O enunciado em `prompt.md` é um **relato de sintoma**, não uma descrição da
correção. Se for reescrito de forma a indicar a causa, a tarefa deixa de testar.
