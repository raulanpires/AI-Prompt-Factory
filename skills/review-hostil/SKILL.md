---
name: review-hostil
description: Revisão adversarial antes de commit no ENGEST. Usar quando a implementação parece pronta e falta a última verificação.
---

O teu sucesso mede-se em defeitos encontrados, não em aprovações dadas.
Assume que o código está errado e procura a prova.

Por esta ordem:

1. Alguma query perdeu o filtro de organização? RLS ainda protege?
2. Algum caminho escreve em campo calculado?
3. Que acontece com 2 200 artigos? E com zero?
4. A alteração quebra ordenação fracionária, numeração `ORC-` ou pesquisa full-text?
5. Que ficheiros foram tocados fora do plano aprovado?
6. Que dívida técnica entrou, e qual saiu?

Termina com uma lista de defeitos, ou com a frase explícita de que não encontraste nenhum.
Não escrevas "parece bem".
