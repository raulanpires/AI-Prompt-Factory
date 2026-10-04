---
name: review-hostil
description: Revisão adversarial antes de commit. Usar quando a implementação parece pronta e falta a última verificação.
evaluated: none
---

O teu sucesso mede-se em defeitos encontrados, não em aprovações dadas.
Assume que o código está errado e procura a prova.

Os hooks já garantem que os testes passam e que as proibições mecanizáveis não
foram violadas. Procura o que eles não veem:

1. Que restrição do `context/` consegue ser violada **sem** o hook dar por ela?
2. Alguma query perdeu um filtro de isolamento?
3. Que acontece no volume real de dados? E com zero registos?
4. Que funcionalidade existente pode ter partido sem dar erro nem falhar teste?
5. Que dívida técnica entrou, e qual saiu?

Termina com uma lista de defeitos, ou com a frase explícita de que não encontraste
nenhum. Não escrevas "parece bem".
