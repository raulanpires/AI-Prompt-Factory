# PROMPT FACTORY

Catálogo de procedimentos para trabalhar com agentes de código. Agnóstico de projeto.

Não é uma biblioteca de prompts. A unidade de reutilização é o **procedimento**:
ordem das operações, proibições, e o portão que diz que a tarefa acabou.

## Três camadas

| Pasta | Pergunta | Quem preenche | Muda quando |
| --- | --- | --- | --- |
| `context/` | o que é verdade neste projeto | o projeto | o projeto muda |
| `skills/` | como se trabalha | a Factory | uma falha ensina algo |
| `evals/` | funcionou? | o projeto | a cada execução |

Só `skills/` e `stances/` são da Factory. `context/` e `evals/` são **por projeto** —
a Factory fornece os templates, cada projeto traz o conteúdo.

`failures.md` fecha o ciclo: cada falha real vira uma linha numa skill existente.

## Como se instala num projeto

1. Copia `skills/` e `stances/` para o projeto (ou aponta o agente para aqui).
2. Escreve `context/<projeto>.md` a partir de `context/_TEMPLATE.md`.
3. Escreve 10 golden tasks a partir de `evals/tasks/_TEMPLATE.md`.
4. Mede o baseline **com as skills desligadas**.
5. Liga as skills. Mede outra vez.

O passo 4 é o que toda a gente salta e depois passa um ano a discutir prompts
com base em sensações.

## Regras da casa

1. Uma skill nasce de uma **falha real**, nunca de uma ideia.
2. Máximo **15 linhas** de corpo por skill. Crescer só com evidência.
3. Uma instrução só vale os seus tokens se for possível **desobedecer-lhe de forma observável**.
4. Nenhuma alteração entra sem correr as golden tasks. Menos de +5 pontos = reverter.
5. Preferir acrescentar uma linha a uma skill existente do que criar uma skill nova.
6. Nada específico de um projeto entra em `skills/`. Se entrou, pertence a `context/`.

## Não reescrever

Já instalado via `npx skills add mattpocock/skills`: `grilling`, `code-review`,
`tdd`, `research`, `domain-modeling`, `pr`, `diagnosing-bugs`, `writing-for-agents`.
Esta Factory cobre só o que aquelas não cobrem.
