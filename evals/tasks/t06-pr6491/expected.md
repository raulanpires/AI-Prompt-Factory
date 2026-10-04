# Tarefa t06 — PR #6491

**Banco:** tanstack-table
**Modo de falha:** convenção do AGENTS.md ignorada
**Commit base:** `54fb3bf7572a9d8461741eb19e4f031ca5d88c44`
**Queimada:** não

## Ground truth
PR #6491 do TanStack/table. O PR acrescentou testes — **são eles a asserção**.

Ficheiros de código que o PR tocou:
```
packages/table-core/src/features/row-selection/rowSelectionFeature.utils.ts
```

Ficheiros de teste que o PR acrescentou ou alterou:
```
packages/table-core/tests/implementation/features/row-selection/rowSelectionFeature.test.ts
packages/table-core/tests/unit/features/row-selection/rowSelectionFeature.utils.test.ts
```

## Montagem da corrida
```bash
git -C <clone> worktree add <wt> 54fb3bf7572a9d8461741eb19e4f031ca5d88c44
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
