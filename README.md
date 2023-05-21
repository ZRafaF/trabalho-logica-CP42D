<!--
 Copyright (c) 2023 Rafael Farias

 This software is released under the MIT License.
 https://opensource.org/licenses/MIT
-->

# Trabalho de Lógica para Computação

## Requerimentos

### Predicados

```prolog
duda_possui(X). %Controla o que Duda possui durante a execução do jogo.

local_duda(X). %Controla onde Duda se encontra durante a execução do jogo.

acessivel(X, Y). %Determina se é possível se locomover diretamente de X a Y.

ir_para(X). %Se X for acessível a partir de onde Duda se encontra atualmente (verificável por meio do predicado “acessivel”), move Duda para X.

pegar(X). %Se X estiver no local onde Duda se encontra e Duda tiver os requisitos necessários para pegar X, adiciona X à lista de posses de Duda.

finalizado. %Verifica se Duda se encontra em um dos estados que levam ao fim do jogo.

rodar. %Se o objetivo final do jogo tiver sido atingido (o que deve ser verificado por meio do predicado “finalizado”), encerra a execução do jogo. Caso contrário, pede uma ação do usuário e a executa (que pode ser um comando do tipo “ir_para(X)” ou “pegar(X)”).


```

## Referencia para programação

### Imprimindo na tela

```prolog
idade(gustavo, 26).
idade(mateus, 17).
idade(maria, 26).
idade(luana, 20).
idade(lucas, 30).
idade(juliana, 20).
maior(X) :- idade(X, Y), Y>=18, write("Encontrado alvo maior de idade!").
```
