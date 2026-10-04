# Protocolo de contaminação

Uma medição contaminada é pior do que nenhuma: dá um número em que se acredita.
Estas regras existem para que o número signifique o que parece significar.

## As três baratas

Se só se seguirem três, são estas — apanham a maior parte do problema.

**1. A resposta certa fora do contexto.** `prompt.md` entra na worktree,
`expected.md` nunca. Agentes leem ficheiros; um `expected.md` alcançável anula a
tarefa sem dar erro.

**2. Etiquetas cegas.** As corridas chamam-se A, B, C. Pontua-se, revela-se
depois. Dizer ao avaliador *"esta tem a skill nova, a antiga deu 71"* produz 72.
Com pontuação mecânica isto é quase gratuito — só exige não olhar para o log
antes do script correr.

**3. Worktree nova por tarefa.** Mesmo commit base de `bench/pins.txt`, sessão
nova, árvore limpa. Sem isto mede-se histórico de conversa.

## As outras

**4. Uma instrução por corrida.** Mudar duas coisas torna o delta não atribuível.
Tedioso, não negociável.

**5. Tarefas queimadas.** Depois de ~3 iterações contra uma tarefa, ela deixou de
ser teste e passou a ser fixture — o score dela só pode subir. Marcar
`Queimada: sim` no `expected.md`: continua a correr como regressão, deixa de
contar como prova de melhoria.

**6. Variância antes de celebrar.** 1 corrida por tarefa na iteração, **3 nos
portões de decisão**. Média das três e o desvio. Um ganho de +6 com desvio de ±8
é ruído. É o que mais probabilidade tem de enganar.

**7. Falha sem tarefa é história.** Cada entrada em `failures.md` aponta para a
tarefa que passou a cobri-la. Prosa sem tarefa é reinterpretada seis meses depois
para significar aquilo em que já se acredita.

**8. Rúbrica versionada.** Reformular uma linha = nova versão + novo baseline.

**9. Nunca pedir auto-reporte.** *"Respeitaste as restrições?"* produz uma
confirmação falsa em que se acaba por confiar. Verificar o diff.

## Contaminação conhecida e aceite

Honestidade sobre o que não está resolvido.

### As skills de terceiros ficam ligadas

Decisão tomada: ~37 skills instaladas continuam ativas durante as medições, em
vez de desativadas. A razão é que o ambiente real as tem, e um procedimento
afinado contra o modelo nu pode ser redundante com o `tdd` quando se volta ao
ambiente real.

O custo: se uma delas disparar em 4 de 10 tarefas, o score mede-as em parte.

A mitigação, pelo hook `log-run.sh`:

- registo de **que skills dispararam** em cada corrida;
- registo do **hash e contagem do conjunto instalado** no `SessionStart`.

E duas regras que daí decorrem:

- corridas da mesma tarefa com skills diferentes a disparar **não se somam** na
  média — sinalizam-se;
- **mudança no hash = evento de re-baseline**, registado no run log.

Sem a segunda, instalar uma skill nova invalida silenciosamente tudo o que foi
medido antes. É o defeito que esta decisão herda, e o hash é o que o fecha.

### O banco não mede tudo

Ver `bench/README.md`: restrições duras de domínio e a metade "pergunta antes de
decidir" não são avaliáveis em repositórios de terceiros. Skills que delas
dependam declaram `evaluated: none`.

### O juiz e o trabalhador

Para as linhas mecânicas é irrelevante — um script não partilha pontos cegos.
É mais um argumento para as ter mecanizado todas.

## Sequência de uma corrida

1. `git worktree add` a partir do pin.
2. Copiar **só** `prompt.md`.
3. Sessão nova, etiqueta A/B/C, sem dizer qual é a hipótese.
4. Correr. O hook registra tudo.
5. Script de pontuação lê `expected.md` + log, devolve o score.
6. Revelar as etiquetas. Comparar.
7. Apagar a worktree.
