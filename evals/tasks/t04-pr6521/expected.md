# Tarefa t04 — PR #6521

**Banco:** tanstack-table
**Modo de falha:** API inventada
**Commit base:** `df470c52b569760d4e489a9ac15d9622bcc05352`
**Queimada:** não

## Ground truth
PR #6521 do TanStack/table. O PR acrescentou testes — **são eles a asserção**.

Ficheiros de código que o PR tocou:
```
packages/react-table/src/useLegacyTable.ts
```

Ficheiros de teste que o PR acrescentou ou alterou:
```
packages/react-table/tests/useLegacyTable.test.tsx
```

## Montagem da corrida
```bash
git -C <clone> worktree add <wt> df470c52b569760d4e489a9ac15d9622bcc05352
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
