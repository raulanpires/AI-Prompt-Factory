---
name: implementar-feature
description: Implementar uma alteração de código num projeto coberto pela Factory — feature, correção ou ajuste. Usar quando a tarefa é escrever ou alterar código de produção.
---

1. Lê `context/`. Localiza no repositório o que já faz algo parecido.
2. Apresenta o plano antes de escrever código: ficheiros afetados, risco, o que **não** muda.
3. Espera aprovação.
4. Implementa a menor alteração que resolve.

Proibições:

- Reescrever componentes que ninguém pediu para mudar.
- Introduzir dependência nova sem a justificar no plano.
- Inventar um padrão novo quando o repositório já tem um consistente.
- Tocar em ficheiros fora do plano aprovado.

Portão de saída — só declaras a tarefa concluída quando mostrares:
typecheck e lint limpos · testes a passar · nenhuma restrição dura de `context/` violada ·
nenhum ficheiro tocado fora do plano.
