# evals/tasks/

Uma pasta por tarefa. A estrutura existe para resolver um bug de contaminação
concreto: **o ficheiro com a resposta certa nunca pode entrar no contexto do agente.**

```
tasks/
├── _TEMPLATE/
│   ├── prompt.md      ← ENTRA no contexto. Só o pedido.
│   └── expected.md    ← NUNCA entra. Resposta, PR, armadilha, ficheiros.
├── _holdout/          ← conjunto de reserva, só nos portões de decisão
└── t01-<slug>/
```

Agentes leem ficheiros. Um template que junta "Pedido" e "Resposta certa" no
mesmo ficheiro anula a tarefa no momento em que o agente a abre — e não dá erro,
dá uma pontuação alta.

## Regra do harness

O runner copia **apenas** `prompt.md` para a worktree. O `expected.md` fica aqui
e é lido só pelo script de pontuação, depois de a sessão ter terminado.

Nunca correr uma tarefa com a pasta da Factory acessível ao agente.

## Mistura da régua (TanStack/table, 10 tarefas)

Organizadas por **modo de falha**, não por tipo de funcionalidade. Cobertura por
tipo parece abrangente e não é.

| # | Modo de falha que testa |
| --- | --- |
| t01 | excesso de alcance — reescreve o que não foi pedido |
| t02 | abstração errada — inventa padrão novo tendo um consistente à mão |
| t03 | verificação saltada — declara concluído sem correr testes |
| t04 | API inventada — usa coisa que não existe no repositório |
| t05 | restrição perdida em resposta longa |
| t06 | convenção do `AGENTS.md` ignorada |
| t07 | caso-limite não tratado (zero registos, volume grande) |
| t08 | regressão silenciosa noutra parte |
| t09 | **armadilha** — a resposta certa é "não faças isto" |
| t10 | **armadilha** — o pedido parte de uma premissa falsa |

As t09 e t10 são obrigatórias. A filosofia do projeto diz que o agente deve
questionar premissas erradas; sem tarefas que o testem, não se obtém.

## Pares

Sempre que possível, uma tarefa tem gémea que difere numa coisa que *deveria*
mudar a resposta. Pontuação boa nas duas = compreendeu. Boa numa e má na gémea =
decorou o padrão.

## Conjunto de reserva

Escrever 15, iterar contra 10, fechar 5 em `_holdout/` e correr só nos portões
de decisão. Impede afinar os procedimentos às tarefas que se andam a olhar.
