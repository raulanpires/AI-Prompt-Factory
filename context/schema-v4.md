# Schema v4 — referência

12 tabelas. Preencher a partir do Supabase antes de usar em avaliações.

> Gerar com: `supabase gen types typescript` ou o MCP do Supabase.
> Este ficheiro é a versão legível pelo agente; não substitui a migração.

## Módulo Orçamentos

### `orcamentos`
| Coluna | Tipo | Nota |
| --- | --- | --- |
| id | uuid | PK |
| numero | text | `ORC-YYYY-NNNN`, automático |
| | | *por completar* |

RLS: *por completar — uma linha por política*

### `capitulos`
*por completar*

### `artigos`
*por completar*

### `recursos`
| Coluna | Tipo | Nota |
| --- | --- | --- |
| tipo | enum | MDO · MAT · EQ · SUB |
| | | *por completar* |

## Campos calculados — nunca escrever

| Tabela | Coluna | Derivado de |
| --- | --- | --- |
| *a confirmar* | `margem_valor` | preço de venda − custo |

## Restantes tabelas

*por completar — 8 tabelas*
