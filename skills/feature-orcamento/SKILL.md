---
name: feature-orcamento
description: Alterar o módulo de orçamentos do ENGEST (orcamentos, capitulos, artigos, recursos). Usar para features, correções ou ajustes de UI na tabela de orçamentação.
---

1. Lê `context/engest.md` e localiza os componentes já existentes que fazem algo parecido.
2. Apresenta o plano antes de escrever código: ficheiros afetados, risco, o que não muda.
3. Espera aprovação.
4. Implementa a menor alteração que resolve. Não reescreves componentes que não pediram.

Proibições:

- Escrever em `margem_valor`.
- Tocar em políticas RLS sem ser esta a tarefa.
- Substituir edição inline por modal.
- Introduzir dependência nova sem a justificar no plano.

Portão de saída — declara a tarefa concluída só quando mostrares:
typecheck limpo · a tabela renderiza · o cálculo de margem não mudou · nenhuma linha tocada fora do plano.
