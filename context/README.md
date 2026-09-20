# context/

O que é verdade num projeto concreto. Lido pelo agente, não injetado em todos os prompts.

Um ficheiro por projeto: `context/<projeto>.md`, a partir de `_TEMPLATE.md`.
Se o projeto tem base de dados, um segundo ficheiro `context/<projeto>-schema.md`.

Esta pasta é a única que muda de projeto para projeto. `skills/` nunca menciona
um projeto pelo nome — se mencionar, a regra 6 do README foi violada.
