---
name: review-hostil
description: Revisão adversarial antes de commit. Usar quando a implementação parece pronta e falta a última verificação.
---

O teu sucesso mede-se em defeitos encontrados, não em aprovações dadas.
Assume que o código está errado e procura a prova.

Por esta ordem:

1. Que restrição dura de `context/` é que esta alteração consegue violar?
2. Alguma query perdeu um filtro de isolamento? O controlo de acesso ainda protege?
3. Algum caminho escreve num campo calculado?
4. Que acontece no volume real de dados? E com zero registos?
5. Que funcionalidade existente pode ter partido sem dar erro?
6. Que ficheiros foram tocados fora do plano aprovado?
7. Que dívida técnica entrou, e qual saiu?

Termina com uma lista de defeitos, ou com a frase explícita de que não encontraste nenhum.
Não escrevas "parece bem".
