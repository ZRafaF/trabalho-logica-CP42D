% Definindo predicados dinamicos
:- dynamic local_duda/1.
:- dynamic duda_possui/1.
:- dynamic banho_tomado/1.
:- dynamic objeto/2.


local_duda(patio).
duda_possui().
banho_tomado(nao).

% Definindo locais
local(patio).
local(lagoa).
local(casa).
local(floresta).
local(galinheiro).
local(reator).


% Definindo (objeto, local)
objeto(rede, casa).
objeto(ovo, galinheiro).
objeto(bessy, floresta).


/* ### Predicados lógicos ### */

% Checa se o caminho é acessivel
acessivel(From, To):- 
    (local(From), local(To)), 
    (From == patio; To == patio),
    write("O caminho e valido!"), 
    nl.

acessivel:- 
    write("Caminho inválido!"), 
    nl.


% Checa se a condição de entrada foi cumprida
condicao_de_entrada(X):-
    X \== casa.

condicao_de_entrada(X):-
    X == casa,
    banho_tomado(B),
    B == sim.

condicao_de_entrada(X):-
    X == casa,
    banho_tomado(B),
    B == nao,
    write("Duda precisa tomar banho antes"),
    nl,
    false.



% Recebe uma nova posição, checa e altera o local_duda
ir_para(X):- 
    local_duda(Y), 
    acessivel(Y, X),
    condicao_de_entrada(X),
    retract(local_duda(Y)), 
    assert(local_duda(X)),
    write("Duda se encontra em: "), 
    write(X),
    nl.

ir_para(X):-
    write("Nao foi possivel ir para: "), 
    write(X),
    nl.


% Ação de tomar banho
tomar_banho:-
    local_duda(Y), 
    (Y==lagoa),
    banho_tomado(B),
    B == nao,
    retract(banho_tomado(nao)), 
    assert(banho_tomado(sim)),
    write("Banho tomado!"),
    nl.

tomar_banho:-
    banho_tomado(B),
    B == sim,
    write("Duda ja tomou banho!"),
    nl.

tomar_banho:-
    local_duda(Y), 
    (Y\==lagoa),
    write("Duda precisa ir a lagoa para tomar banho!"),
    nl.


% Ação de derrubar o objeto que a Duda está segurando
derrubar(X):-
    duda_possui(X),
    local_duda(Y),
    assert(objeto(X, Y)),
    retract(duda_possui(X)).


% Checa se a condição para pegar um objeto foi cumprida
condicao_de_pegar(X):-
    X \== bessy.

condicao_de_pegar(X):-
    X == bessy,
    duda_possui(O),
    O == rede.

condicao_de_pegar(X):-
    X == bessy,
    write("Duda precisa da rede para pegar a bessy!"),
    nl,
    false.


% Ação de pegar um objeto
pegar(X):-
    local_duda(Y),
    objeto(X, P),
    P == Y,
    condicao_de_pegar(X),
    retract(objeto(X, P)),
    assert(duda_possui(X)),
    write("Duda pegou: "),
    write(X),
    nl.

pegar(X):-
    write("Nao foi possivel pegar: "),
    write(X),
    nl.


% Verificar atributos
onde_estou:- 
    write("Duda esta em: "),
    local_duda(X),
    write(X),
    nl.


inventario:- 
    write("Inventario: "),
    duda_possui(X),
    write(X),
    nl.


% Verifica se os parametros para a conclusão do jogo foram satisfeitos
finalizado:- 
    final_bessy.

finalizado:- 
    final_bessyzilla.

final_bessy:-
    objeto(bessy, galinheiro),
    write("VOCE GANHOU!"),
    nl,
    write("Bessy está no galinheiro novamente! Obrigado por jogar").

final_bessyzilla:-
    objeto(ovo, reator),
    write("VOCE GANHOU!"),
    nl,
    write("Voce colocou o ovo no reator, o que criou a BESSYZILLA, ela seguiu e destroiu a cidade!"),
    nl,
    print_zilla, 
    nl,
    write("Obrigado por jogar").


print_zilla:-
    nl,
    nl.
    write("     MM           "),nl,
    write("====>''\\___/|     "),nl,
    write("      \\_  _/      "),nl,
    write("        ][        "),nl.


% Inicia o jogo
rodar:-
    nl,
    write("Comandos:    |   Locais:     |   (Objeto, Local)"),
    nl,
    write("----------------------------------------------------"),
    nl,
    write("pegar(X).    |   patio       |   (rede,  casa)"),
    nl,
    write("derrubar(X). |   lagoa       |   (ovo,   galinheiro)"),
    nl,
    write("ir_para(X).  |   casa        |   (bessy, floresta)"),
    nl,
    write("tomar_banho. |   floresta    |   "),
    nl,
    write("inventario.  |   galinheiro  |   "),
    nl,
    write("onde_estou.  |               |   "),
    nl,
    write("------------------------------------------"),
    nl,
    game_loop.


% Loop do jogo
game_loop:-
    finalizado.

game_loop:-
    not(finalizado),
    read(X), 
    call(X),
    game_loop.