# PROMPT FACTORY

Catálogo de procedimentos para trabalhar com agentes de código, com aparelho de
medição próprio. Agnóstico de projeto.

A unidade de reutilização é o **procedimento** — ordem das operações, proibições,
e o portão que diz que a tarefa acabou. Não é o texto do prompt.

## Os dois testes

Tudo o que entra aqui passa por estes dois crivos.

**1 — Desobediência observável.** Uma instrução só vale os seus tokens se for
possível apontar para o output e provar que falhou.

**2 — Estado interno vs. prova.** Uma instrução sobre o estado interno do modelo
não funciona. Substitui-se por um passo que produz prova.

## Arquitetura

| Camada | Pergunta | Onde | Por projeto? |
| --- | --- | --- | --- |
| `context/` | o que é verdade neste projeto | ficheiros lidos pelo agente | sim |
| `skills/` | como se trabalha | `SKILL.md`, carregadas por trigger | não |
| `hooks/` | o que não pode acontecer | código, corre sempre | não |
| `evals/` | funcionou? | tarefas + rúbrica mecânica | — |
| `bench/` | medido contra o quê | repositórios de terceiros | — |

`failures.md` fecha o ciclo: cada falha real vira uma linha numa skill existente
ou numa proibição de hook.

## Decisões fundadoras

| | Decisão |
| --- | --- |
| Banco de ensaio | repositórios de terceiros, nunca código próprio — ver `bench/` |
| Régua | TanStack/table, 10 tarefas, produz o score |
| Tropeços | drizzle-orm e excalidraw, 3 tarefas cada, só passa/falha |
| Pontuação | 100% mecânica, zero juízo humano por corrida |
| Skills de terceiros | ficam ligadas e instrumentadas, não desativadas |
| Distribuição | junctions de `~/.agents/skills/` para esta pasta |
| Âmbito | só agentes de desenvolvimento |

## Regras da casa

1. Uma skill nasce de uma **falha real**, nunca de uma ideia.
2. Máximo **15 linhas** de corpo por skill. Crescer só com evidência.
3. Nenhuma alteração entra sem correr as golden tasks. Menos de +5 pontos = reverter.
4. Preferir acrescentar uma linha a uma skill existente do que criar uma skill nova.
5. Nada específico de um projeto entra em `skills/` ou `hooks/`. Se entrou, pertence a `context/`.
6. Uma proibição mecanizável pertence a um **hook**, não a um prompt.
7. Toda a skill declara `evaluated:` no frontmatter. Sem exceção.

## A convenção `evaluated:`

Cada `SKILL.md` declara contra o que foi medida:

```yaml
evaluated: tanstack-table     # medida, com provas em evals/runs/
evaluated: none               # não medida — é opinião, e sabe-se que é
```

Sem esta linha, skills com provas e skills por palpite ficam lado a lado com o
mesmo aspeto, e em três meses não se distinguem. É o que separa este projeto de
uma pasta de prompts.

## Instalação

```bash
# Windows, sem privilégios de administrador:
mklink /J "%USERPROFILE%\.agents\skills\carregar-contexto" "C:\PROMPT FACTORY\skills\carregar-contexto"
# ... uma por skill

# Hooks: registar uma vez em ~/.claude/settings.json,
# apontando para os scripts desta pasta — ver hooks/settings-snippet.json
```

Fonte única de verdade: esta pasta. Editas aqui, fica ativo no instante seguinte,
em todos os projetos, sem passo intermédio.

## Estado

- [ ] Clones do banco criados (`bench/setup.sh`)
- [ ] 10 golden tasks da régua escritas
- [ ] Hooks registados e a produzir log
- [ ] Baseline medido
- [ ] Primeira skill medida com delta
