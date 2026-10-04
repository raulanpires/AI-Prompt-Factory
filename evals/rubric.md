# Rúbrica — v1

5 critérios × 0–2 pontos × 10 tarefas da régua = **100 pontos**.

**Nenhuma linha depende de juízo humano.** Isso é deliberado: toda a contaminação
que o protocolo tenta evitar entra pelo avaliador. Se o avaliador é um script,
não há nada por onde entrar.

| # | Critério | 0 | 1 | 2 | Fonte |
| --- | --- | --- | --- | --- | --- |
| 1 | Correto | suite falha | passa após retoque manual | passa à primeira | comando de teste |
| 2 | Restrições | lint falha ou grep proibido encontra | aviso de lint | limpo | lint + grep |
| 3 | Mínimo | tocou ficheiros fora da lista do PR | ⊆ lista + 1 | ⊆ lista do PR | log do hook |
| 4 | Verificou | não invocou o comando de teste | invocou, ignorou a falha | invocou e passou | log do hook |
| 5 | Perguntas | 2 ou mais | 1 | 0 | transcrição |

## Porque a linha 5 é contável

Num repositório de terceiros com um PR já aceite como resposta, **não existem
decisões legítimas para perguntar** — a decisão foi tomada pelos mantenedores e
está no histórico. Todos os factos estão nos ficheiros. Logo qualquer pergunta de
esclarecimento é, por construção, um facto que o agente podia ter lido.

Isto não vale em código próprio, onde há decisões abertas. Lá a linha 5 mede
outra coisa e não se aplica assim.

## As armadilhas invertem a rúbrica

Nas tarefas t09 e t10 a resposta certa é **não alterar código**. Lá, `files_touched`
não vazio é falha, e as linhas "Mínimo" não se aplicam. O script de pontuação lê o
`expected.md` de cada tarefa, que declara os seus próprios critérios — a tabela
acima é o caso geral, não a lei.

## Registo obrigatório por tarefa

Além do score: **tokens gastos** e **aceite à primeira (S/N)**, ambos do log do hook.

## Métrica principal

Não é o score. É:

```latex
\text{custo por tarefa concluída} = \frac{\sum \text{tokens de todas as tentativas}}{\text{tarefas aceites à primeira}}
```

Um prompt mais longo que evita uma segunda tentativa **poupa** tokens. Prompts
maiores não são melhores — e mais curtos também não.

## Decisão

| Delta vs. baseline | Ação |
| --- | --- |
| +10 ou mais | continuar |
| +5 a +10 | uma iteração de ablação antes de decidir |
| menos de +5 | parar. O problema não eram os prompts — ver contexto e scoping |

Uma alteração que não mova o total em pelo menos 5 pontos é ruído. Reverter,
mesmo que "pareça melhor".

## Versão

Esta rúbrica é **v1**. Reformular qualquer linha torna todas as pontuações
anteriores incomparáveis e obriga a novo baseline. Mudar a rúbrica = incrementar
a versão e registar no run log.
