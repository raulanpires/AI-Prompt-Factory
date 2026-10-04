# Checklist de uma skill

Os dois crivos, antes de qualquer linha:

**1 — Desobediência observável.** Possível apontar para o output e provar que falhou?
**2 — Estado interno vs. prova.** Fala do que o modelo *é*? Substituir pelo passo que produz prova.

## Essencial — cinco

| Componente | Porquê |
| --- | --- |
| **Trigger** (`description`) | decide se a skill dispara. As 20 palavras mais importantes do ficheiro |
| **Proibições verificáveis** | o conteúdo que sobrevive à ablação quase sempre. Se for mecanizável → **hook** |
| **Portão de saída** | sem ele os agentes declaram vitória. Se for mecanizável → **hook** |
| **Ordem das operações** | só onde a ordem natural seria errada |
| **Fronteira de aprovação** | factos vai buscar, decisões pergunta |

Não estão aqui, e é deliberado: papel, objetivo, formato de saída, contexto.

## Importante

Diretiva de reutilização · cerca de âmbito · **uma** stance adversarial (só em
revisão) · forma da saída (só se consumida por máquina) · regra de escalada.

## Opcional — só com falha documentada

Exemplo trabalhado (um, nunca três) · ordenação de trade-offs · vocabulário
inline · restrições de ferramentas · orçamento de comprimento.

## Eliminar

| Eliminar | Porquê |
| --- | --- |
| Declarações de papel | efeito nulo na correção técnica |
| Adjetivos de qualidade | "rigoroso", "production-ready" — falham o crivo 1 |
| Enquadramento de importância | "isto é crítico", "pensa passo a passo" isolado |
| Repetir o que o `context/` diz | duas fontes de verdade: uma fica obsoleta |
| Rituais de processo genéricos | secção existe quando serve, falta quando não serve |
| Pedidos de auto-reporte | produz confirmação falsa em que se confia |
| Instruções de tom e meta | pertencem à configuração global, uma vez |
| "Não alucines" | o modelo não sabe quando aluciná. Crivo 2 |

## Orçamento

| Tier | Linhas |
| --- | --- |
| Essencial | 10–14 |
| + Importante | até 18 |
| + Opcional | até 25 |

Passar das 25 significa quase sempre estar a escrever `context/` dentro de uma skill.

## Abrangente ≠ muitos temas

Um prompt abrangente é o que **bloqueia as formas pelas quais esta tarefa falha**.
Vinte boas práticas listadas são ruído com aparência de rigor. Cinco proibições
que correspondem às cinco falhas reais são cobertura.

Origem legítima de cada linha: `failures.md`. Uma proibição que não vem de uma
falha observada é um palpite com cara de regra.

## Ordem de ablação

De baixo para cima nesta tabela: primeiro os oito a eliminar, depois os opcionais
sem falha associada, depois os importantes. Os essenciais quase nunca saem.
