# Stances

Seis posturas adversariais. São o segundo eixo de composição: `TASK × STANCE`.

Um papel só entra aqui se **inverter a função de sucesso**. "Senior Engineer" não
inverte nada — o modelo já tentava ser competente. Estes invertem.

| Stance | Sucesso passa a ser | Usar quando |
| --- | --- | --- |
| `hostil` | encontrar defeitos, não aprovar | antes de commit |
| `advogado-do-diabo` | derrubar a tese, não apoiá-la | decisão de arquitetura |
| `pre-mortem` | explicar o fracasso já ocorrido | antes de começar algo grande |
| `red-team` | quebrar, não construir | RLS, permissões, dados de clientes |
| `socratico` | fazer-te chegar lá, não responder | quando queres aprender, não delegar |
| `fact-check` | separar o verificado do assumido | quando o agente afirma coisas sobre o código |

## Regra de composição

Máximo **duas** stances por prompt, e a segunda tem de ser adversarial à primeira.
Construir + criticar funciona. Construir + construir + construir é ruído.

Cinco papéis empilhados não dão um agente cinco vezes melhor. Dão um agente com
cinco funções de sucesso em conflito, resolvido de forma que não controlas.
