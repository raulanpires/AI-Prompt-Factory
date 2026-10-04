# Tarefa t08 — PR #6442

**Banco:** tanstack-table
**Modo de falha:** regressão silenciosa
**Commit base:** `8fcfd34531e28ac16bfa77c5f6a7c4fc5fd92e2a`
**Queimada:** não

## Ground truth
PR #6442 do TanStack/table. O PR acrescentou testes — **são eles a asserção**.

Ficheiros de código que o PR tocou:
```
packages/table-core/src/features/column-visibility/columnVisibilityFeature.utils.ts
```

Ficheiros de teste que o PR acrescentou ou alterou:
```
packages/table-core/tests/unit/features/column-visibility/columnVisibilityFeature.utils.test.ts
```

## Montagem da corrida
```bash
git -C <clone> worktree add <wt> 8fcfd34531e28ac16bfa77c5f6a7c4fc5fd92e2a
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
