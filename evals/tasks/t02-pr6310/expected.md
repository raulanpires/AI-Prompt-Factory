# Tarefa t02 — PR #6310

**Banco:** tanstack-table
**Modo de falha:** abstração errada
**Commit base:** `ab4208b94f8871131a330f160d0b986a4b98d66f`
**Queimada:** não

## Ground truth
PR #6310 do TanStack/table. O PR acrescentou testes — **são eles a asserção**.

Ficheiros de código que o PR tocou:
```
packages/table-core/src/features/row-sorting/rowSortingFeature.utils.ts
packages/table-core/src/fns/sortFns.ts
```

Ficheiros de teste que o PR acrescentou ou alterou:
```
packages/table-core/tests/unit/features/row-sorting/rowSortingFeature.utils.test.ts
packages/table-core/tests/unit/fns/sortFns.test.ts
```

## Montagem da corrida
```bash
git -C <clone> worktree add <wt> ab4208b94f8871131a330f160d0b986a4b98d66f
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
