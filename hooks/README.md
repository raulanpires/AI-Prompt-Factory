# hooks/

Código que corre sempre, em vez de instruções que o modelo pode ignorar.

Um prompt é um pedido. Um hook é uma condição. Para uma proibição mecanizável,
a diferença não é de grau — é de natureza. E custa **zero tokens em runtime**,
porque não está no contexto.

| Hook | Evento | Faz |
| --- | --- | --- |
| `block-constraints.sh` | `PreToolUse` | nega edições que violem `.factory/forbidden.txt` |
| `exit-gate.sh` | `Stop` | recusa terminar enquanto `.factory/gate.sh` falhar (3 tentativas) |
| `log-run.sh` | `SessionStart` · `PostToolUse` · `Stop` | instrumentação para a rúbrica e o protocolo |

Nenhum menciona projeto nenhum — são guiados pelos dados de `.factory/` do
repositório onde correm. Sem esses ficheiros, saem limpos sem bloquear nada.

## Instalação

Registar uma vez em `~/.claude/settings.json` a partir de `settings-snippet.json`,
apontando para os scripts **desta pasta**. A lógica fica versionada em git; só o
registo, que são linhas que nunca mudam, vive fora.

## Por projeto

```
<repo>/.factory/
├── forbidden.txt    # um glob por linha, ou !grep:<padrão>
└── gate.sh          # sai 0 quando o portão passa
```

Exemplo de `gate.sh` para um projeto TypeScript:

```bash
#!/usr/bin/env bash
set -e
npm run -s typecheck
npm run -s test
```

## O que o `log-run.sh` produz

Um JSON por sessão em `~/.factory-runs/<sid>.json`:

```json
{
  "session": "...", "at": "...", "cwd": "...",
  "env": { "skillset_hash": "a1b2c3d4e5f6", "skills_installed": 37 },
  "skills_fired": ["tdd"],
  "files_touched": ["packages/table-core/src/x.ts"],
  "commands": ["npm run test"]
}
```

Daqui saem três linhas da rúbrica — Mínimo (ficheiros vs. PR), Verificou
(comandos), e o registo de tokens — mais o `skillset_hash`, que é o que deteta
automaticamente que o ambiente mudou e que o baseline caducou.
