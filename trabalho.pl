% Definindo predicados dinamicos
:- dynamic local_duda/1.
:- dynamic duda_possui/1.
:- dynamic banho_tomado/1.


local_duda(patio).
duda_possui(nada).
banho_tomado(nao).

% Definindo locais
local(patio).
local(lagoa).
local(casa).
local(floresta).
local(galinheiro).


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
    nl,
    false.


% Recebe uma nova posição, checa e altera o local_duda
ir_para(X):- 
    local_duda(Y), 
    acessivel(Y, X), 
    retract(local_duda(Y)), 
    assert(local_duda(X)),
    write("Duda se encontra em: "), 
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
    nl,
    false.

tomar_banho:-
    local_duda(Y), 
    (Y\==lagoa),
    write("Duda precisa ir a lagoa para tomar banho!"),
    nl,
    false.