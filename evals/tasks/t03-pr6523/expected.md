# Tarefa t03 — PR #6523

**Banco:** tanstack-table
**Modo de falha:** verificação saltada
**Commit base:** `2d5d6c580c799d54ac9789c757c49bebd23f99cc`
**Queimada:** não

## Ground truth
PR #6523 do TanStack/table. O PR acrescentou testes — **são eles a asserção**.

Ficheiros de código que o PR tocou:
```
packages/table-core/src/features/row-aggregation/aggregationFns.ts
```

Ficheiros de teste que o PR acrescentou ou alterou:
```
packages/table-core/tests/unit/fns/aggregationFns.test.ts
```

## Montagem da corrida
```bash
git -C <clone> worktree add <wt> 2d5d6c580c799d54ac9789c757c49bebd23f99cc
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
