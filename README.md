# PROMPT FACTORY

Catálogo de procedimentos para trabalhar com agentes de código no ENGEST.

Não é uma biblioteca de prompts. A unidade de reutilização é o **procedimento**:
ordem das operações, proibições, e o portão que diz que a tarefa acabou.

## Três camadas

| Pasta | Pergunta | Muda quando |
| --- | --- | --- |
| `context/` | o que é verdade neste projeto | o projeto muda |
| `skills/` | como se trabalha | uma falha ensina algo |
| `evals/` | funcionou? | a cada execução |

`failures.md` fecha o ciclo: cada falha real vira uma linha numa skill existente.

## Regras da casa

1. Uma skill nasce de uma **falha real**, nunca de uma ideia.
2. Máximo **15 linhas** de corpo por skill. Crescer só com evidência.
3. Uma instrução só vale os seus tokens se for possível **desobedecer-lhe de forma observável**.
4. Nenhuma alteração entra sem correr as golden tasks. Menos de +5 pontos = reverter.
5. Preferir acrescentar uma linha a uma skill existente do que criar uma skill nova.

## Estado

- [ ] 10 golden tasks escritas (`evals/tasks/`)
- [ ] Baseline medido, sem skills (`evals/runs/`)
- [ ] 4 skills escritas
- [ ] Segunda medição, com skills
- [ ] Decisão: continuar, iterar ou parar

## Não reescrever

Já instalado via `npx skills add mattpocock/skills`: `grilling`, `code-review`,
`tdd`, `research`, `domain-modeling`, `pr`, `diagnosing-bugs`, `writing-for-agents`.
Esta Factory cobre só o que é específico do ENGEST.
