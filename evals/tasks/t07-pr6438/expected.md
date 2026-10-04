# Tarefa t07 — PR #6438

**Banco:** tanstack-table
**Modo de falha:** caso-limite não tratado
**Commit base:** `22d775430fe9ced21ac49bbfc1dc6446ebde6b7c`
**Queimada:** não

## Ground truth
PR #6438 do TanStack/table. O PR acrescentou testes — **são eles a asserção**.

Ficheiros de código que o PR tocou:
```
packages/table-core/src/features/global-filtering/globalFilteringFeature.ts
```

Ficheiros de teste que o PR acrescentou ou alterou:
```
packages/table-core/tests/implementation/features/column-filtering/createFilteredRowModel.test.ts
```

## Montagem da corrida
```bash
git -C <clone> worktree add <wt> 22d775430fe9ced21ac49bbfc1dc6446ebde6b7c
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
