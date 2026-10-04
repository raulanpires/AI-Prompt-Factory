# bench/

Os repositórios contra os quais a Factory se mede. Nenhum é código próprio — é
deliberado: não se pode vazar a resposta certa de código que nunca se viu.

## Papéis

| Papel | Repositório | Tarefas | Produz score? | Porquê este |
| --- | --- | --- | --- | --- |
| **Régua** | `TanStack/table` | 10 | sim | tabela densa, edição inline, virtualização — a mesma forma de problema do trabalho real. Tem `AGENTS.md`, logo convenções verificáveis |
| Tropeço | `drizzle-orm` | 3 | não | cobre o eixo de schema e tipos; tem `test:types` |
| Tropeço | `excalidraw` | 3 | não | convenções maduras (`AGENTS.md` + `CLAUDE.md`), suite grande |

**A régua é o número.** Os tropeços correm uma vez por ciclo, com uma corrida
cada, e servem para uma coisa só: se um deles degradar depois de uma alteração
que melhorou a régua, afinaste às dez tarefas em vez de melhorares o
procedimento. Não entram na média — misturar bancos dá um número que se move
por razões não atribuíveis.

## Ground truth

A resposta certa é um **PR já aceite**, não uma recordação. É melhor ground truth
do que memória própria, que é reconstrutiva. Para cada tarefa guarda-se o número
do PR e a lista de ficheiros que ele tocou.

## O que este banco NÃO consegue medir

Honestidade sobre os limites, porque um score que se acredita cobrir mais do que
cobre é pior do que nenhum.

- **Restrições duras de domínio.** Nenhum repositório de terceiros tem um campo
  calculado próprio ou isolamento por organização. O hook de proibições existe,
  mas a sua eficácia não é avaliada aqui.
- **A metade "pergunta antes de decidir".** Num PR aceite não há decisões abertas.
  Mede-se "não perguntes factos que podias ler"; não se mede o inverso.

Skills que dependam destas duas coisas declaram `evaluated: none`.

## Setup

```bash
bash bench/setup.sh    # clona os três, cria a base fixa de cada um
```

Cada tarefa corre numa **worktree nova a partir do mesmo commit base**. Sessão
nova, árvore limpa. Sem isto mede-se histórico de conversa, não procedimento.

O commit base de cada repositório fica fixado em `bench/pins.txt` e **nunca muda
a meio de uma experiência** — atualizar os clones invalida todas as corridas
anteriores.
