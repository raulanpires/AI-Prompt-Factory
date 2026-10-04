# Runbook — do zero ao baseline

Quatro passos, por esta ordem. O quarto é o único que produz informação; os três
primeiros existem para o tornar possível.

---

## 1 — Empurrar para o GitHub (5 min)

```bash
cd "C:\PROMPT FACTORY"
git push -u origin main
```

Histórico já juntado com o stub do remoto; são 8 commits à frente.

**Verificar:** `git status` diz `up to date with origin/main`.

Se pedir credenciais, autentica como fazes normalmente. Nada depende deste passo
— é backup, não parte do ciclo de medição.

---

## 2 — Montar o banco de ensaio (20–40 min, quase tudo a descarregar)

```bash
cd "C:\PROMPT FACTORY"
bash bench/setup.sh
```

Clona os três repositórios para `.bench-clones/` e fixa o commit base de cada um
em `bench/pins.txt`.

Depois, **uma vez por banco**, instalar dependências no clone:

```bash
cd .bench-clones/tanstack-table
pnpm i
pnpm build
```

O `pnpm build` faz falta: as tarefas de `table-core` dependem de pacotes
construídos. Sem isto os testes falham por razões que não têm nada a ver com o
agente, e pontuavas zero a todas.

**Verificar:**

```bash
cat bench/pins.txt                     # três linhas com sha
cd .bench-clones/tanstack-table
pnpm vitest run packages/table-core/tests/unit/fns/aggregationFns.test.ts
```

O teste tem de passar **antes** de qualquer corrida. Se não passa no estado
limpo, o banco está mal montado e todas as medições seriam lixo.

> `bench/setup.sh` corrido duas vezes não atualiza os pins. É de propósito:
> mudar um pin invalida todas as corridas anteriores.

---

## 3 — Registar os hooks (10 min)

Abrir `~/.claude/settings.json` e colar os quatro blocos de
`hooks/settings-snippet.json`. Se o ficheiro já tem uma secção `hooks`, juntar os
eventos em vez de substituir.

Confirmar o caminho. No Git Bash do Windows, `C:\PROMPT FACTORY` escreve-se
`/c/PROMPT FACTORY`.

**Verificar** — abrir o Claude Code em qualquer pasta, fazer um pedido trivial, e:

```bash
ls ~/.factory-runs/
cat ~/.factory-runs/<id>.json
```

Três coisas a confirmar neste JSON:

| Campo | Esperado | Se falhar |
| --- | --- | --- |
| `skills_installed` | ~37, **não 0** | o `$HOME` do hook não aponta para o teu perfil |
| `transcript` | caminho existente | sem ele a linha "perguntas" não pontua |
| `commands` | os comandos que correste | o `PostToolUse` não está a disparar |

O `skills_installed: 0` é a falha mais provável e a mais silenciosa. Resolve-se
pondo o caminho absoluto em vez de `$HOME` dentro do `log-run.sh`.

Os outros dois hooks só agem quando o repositório tem `.factory/`. Para o banco:

```bash
mkdir -p .bench-clones/tanstack-table/.factory
printf '#!/usr/bin/env bash\nset -e\npnpm vitest run --silent\n' \
  > .bench-clones/tanstack-table/.factory/gate.sh
```

Sem `forbidden.txt` o `block-constraints.sh` não bloqueia nada — correto, porque
um repositório de terceiros não tem restrições de domínio tuas.

---

## 4 — Medir o baseline (3–5 h)

**O ponto todo.** Baseline = as quatro skills da Factory **desligadas**, as 37 de
terceiros ligadas (decisão Q3), hooks a registar.

### Desligar só as da Factory

```bash
mkdir -p ~/.agents/skills.off
mv ~/.agents/skills/{carregar-contexto,implementar-feature,alterar-schema,review-hostil} \
   ~/.agents/skills.off/ 2>/dev/null || true
```

Com junctions (decisão Q5) isto move o link, não o conteúdo. A Factory fica intacta.

### Correr as dez

Para cada tarefa, uma corrida com etiqueta `A`:

```bash
bash evals/run.sh t01-pr6260 A
# → imprime a worktree. Abre o Claude Code lá e passa-lhe o PEDIDO.md.
# Quando o agente terminar:
bash evals/score.sh t01-pr6260 A
```

Regras durante este passo, de `evals/PROTOCOLO.md`:

- **Não abrir o `expected.md`.** Sabes a resposta e isso enviesa o que aceitas.
- **Uma corrida por tarefa.** Três só nos portões de decisão.
- **Não instalar nem remover skills.** O `skillset_hash` muda e o baseline morre.
- Worktree nova por tarefa — o `run.sh` já garante.

### Consolidar

```bash
for t in evals/tasks/t0*-pr* evals/tasks/t*-armadilha; do
  bash evals/score.sh "$(basename $t)" A 2>/dev/null
done | jq -s '{
  total: map(.total) | add,
  por_tarefa: map({(.tarefa): .total}) | add,
  hashes: map(.skillset_hash) | unique,
  skills_que_dispararam: map(.skills_fired) | map(select(. != "")) | unique
}'
```

Guardar em `evals/runs/<data>-baseline.md`.

**Três leituras obrigatórias deste consolidado:**

1. **`hashes` tem de ter um só valor.** Mais do que um significa que o ambiente
   mudou a meio e as corridas não são comparáveis. Repetir as afetadas.
2. **`skills_que_dispararam`** — a resposta à pergunta de quais das 37 chegam a
   ativar. O meu palpite é cinco ou seis. Se for esse o caso, as outras trinta são
   entulho e a opção "curar" da Q3 volta à mesa com dados em vez de palpite.
3. **O total.** Provavelmente entre 55 e 70 em 100. É este número que todas as
   alterações futuras têm de bater por 5 pontos para contarem.

### Voltar a ligar

```bash
mv ~/.agents/skills.off/* ~/.agents/skills/
```

---

## Depois

A primeira skill a medir é a `carregar-contexto`, por ser a mais barata de avaliar
e a que mais provavelmente move a linha "Perguntas". Uma alteração, uma corrida de
dez, comparar com o baseline, e aplicar a regra: menos de +5 pontos, reverter.
