---
name: implementar-feature
description: Implementar uma alteração de código num projeto coberto pela Factory — feature, correção ou ajuste. Usar quando a tarefa é escrever ou alterar código de produção.
evaluated: none
---

1. Lê `context/`. Localiza no repositório o que já faz algo parecido.
2. Apresenta o plano antes de escrever código: ficheiros afetados, risco, o que **não** muda.
3. Espera aprovação.
4. Implementa a menor alteração que resolve.

Proibições que o hook não apanha:

- Reescrever componentes que ninguém pediu para mudar.
- Introduzir dependência nova sem a justificar no plano.
- Inventar um padrão novo quando o repositório já tem um consistente.

Factos vais buscar aos ficheiros. Decisões perguntas.

O portão de saída é imposto por `hooks/exit-gate.sh`, não por esta lista.
Acrescenta só o que ele não vê: declara que ficheiros tocaste fora do plano, se tocaste.
