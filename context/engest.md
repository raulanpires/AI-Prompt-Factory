# ENGEST — contexto do projeto

Lido pelo agente quando trabalha no ENGEST. Factos, não instruções.

## O produto

SaaS de orçamentação e gestão de obra para PME de construção em Portugal.
Utilizador principal: o Director de Obra. O orçamento é a fonte única de verdade.

## Stack

Next.js 14 (App Router) · TypeScript · Tailwind · Supabase (eu-west-2) · Vercel · Stripe

## Restrições duras

Violar qualquer uma destas é falha da tarefa, independentemente do resto.

- Nunca quebrar RLS.
- Nunca escrever em `margem_valor` — é campo calculado.
- Não existe pasta `/src`.
- Não usar styled-jsx.
- Não alterar o schema em silêncio. Alteração de schema é decisão, não facto.

## Módulo Orçamentos

Tabelas: `orcamentos` · `capitulos` · `artigos` · `recursos`

- Numeração automática `ORC-YYYY-NNNN`
- Ordenação fracionária (drag and drop)
- Pesquisa full-text
- Recursos tipificados: MDO · MAT · EQ · SUB

Escala de dados: ~2 200 artigos · ~2 300 recursos · ~8 800 condições de preço.

## Regras de UI

- A tabela é a interface primária.
- Edição inline > modais. Modal só quando estritamente necessário.
- Manter densidade de informação alta.
- Semântica de cor, não negociável: **âmbar** = custo · **verde** = margem · **azul** = venda.
- Com borda = editável. Sem borda = calculado.

## Vocabulário

| Termo | Significado |
| --- | --- |
| Orçamento | documento-raiz; contém capítulos |
| Capítulo | agrupamento de artigos |
| Artigo | unidade orçamentada; decompõe-se em recursos |
| Recurso | MDO (mão de obra), MAT (material), EQ (equipamento), SUB (subempreitada) |
| Condição de preço | preço de um recurso num contexto específico |
| Desvio | diferença entre orçamentado e real |

## Por preencher

- [ ] Estrutura de multi-tenant: como é feito o isolamento por organização
- [ ] Políticas RLS por tabela, uma linha cada
- [ ] Convenção de nomes de ficheiros e componentes
- [ ] Onde vivem os cálculos: base de dados, servidor ou cliente
