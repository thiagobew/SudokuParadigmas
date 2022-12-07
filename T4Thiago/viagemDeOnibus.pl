% https://rachacuca.com.br/logica/problemas/viagem-de-onibus/

mochila(amarela).
mochila(azul).
mochila(branca).
mochila(verde).
mochila(vermelha).

nome(ana).
nome(cintia).
nome(isabela).
nome(rafaela).
nome(sabrina).

visitar(avos).
visitar(irmaos).
visitar(pais).
visitar(sobrinhos).
visitar(tios).

poltrona(4).
poltrona(11).
poltrona(28).
poltrona(34).
poltrona(42).

musica(mpb).
musica(pop).
musica(rock).
musica(samba).
musica(sertanejo).

suco(abacaxi).
suco(laranja).
suco(limao).
suco(maca).
suco(uva).

passageira(Nome, Mochila, Visitar, Poltrona, Musica, Suco) :-
    nome(Nome),
    mochila(Mochila),
    visitar(Visitar),
    poltrona(Poltrona),
    musica(Musica),
    suco(Suco).

%X está à ao lado de Y
aoLado(X,Y,Lista) :- nextto(X,Y,Lista);nextto(Y,X,Lista).
                       
%X está à esquerda de Y (em qualquer posição à esquerda)
aEsquerda(X,Y,Lista) :- nth0(IndexX,Lista,X), 
                        nth0(IndexY,Lista,Y), 
                        IndexX < IndexY.
                        
%X está à direita de Y (em qualquer posição à direita)
aDireita(X,Y,Lista) :- aEsquerda(Y,X,Lista). 

%X está no canto se ele é o primeiro ou o último da lista
noCanto(X,Lista) :- last(Lista,X).
noCanto(X,[X|_]).

todosDiferentes([]).
todosDiferentes([H|T]) :- not(member(H,T)), todosDiferentes(T).

% X exatamente à direita se seu index é + 1 em relação ao index de Y
exatamenteADireita(X, Y, Lista) :-
	nth0(IndexX, Lista, X),
	nth0(IndexY, Lista, Y),
	IndexX is IndexY + 1.

% Y está entre X e Z se à direita de X e à esquerda de Z
entre(Y, X, Z, Lista) :-
	aEsquerda(Y, Z, Lista),
	aEsquerda(X, Y, Lista).

solucionar(ListaSolucao) :-
	ListaSolucao = [
		passageira(Nome1, Mochila1, Visitar1, Poltrona1, Musica1, Suco1),
		passageira(Nome2, Mochila2, Visitar2, Poltrona2, Musica2, Suco2),
		passageira(Nome3, Mochila3, Visitar3, Poltrona3, Musica3, Suco3),
		passageira(Nome4, Mochila4, Visitar4, Poltrona4, Musica4, Suco4),
		passageira(Nome5, Mochila5, Visitar5, Poltrona5, Musica5, Suco5)
	],
	
	% Cintia está exatamente à direita da passageira que está bebendo suco de Limão.
	exatamenteADireita(passageira(cintia, _, _, _, _, _), passageira(_, _, _, _, _, limao), ListaSolucao),

	% A mulher de mochila Verde está em algum lugar entre a mulher que vai visitar os Pais e a passageira que sentará na poltrona 42, nessa ordem.
	entre(passageira(_, verde, _, _, _, _), passageira(_, _, pais, _, _, _), passageira(_, _, _, 42, _, _), ListaSolucao),

	% A passageira que está ouvindo Sertanejo está ao lado da passageira que está bebendo suco de Limão.
	aoLado(passageira(_, _, _, _, sertanejo, _), passageira(_, _, _, _, _, limao), ListaSolucao),

	% A mulher de mochila Azul está em algum lugar à esquerda da mulher que vai visitar os Irmãos.
	aEsquerda(passageira(_, azul, _, _, _, _), passageira(_, _, irmaos, _, _, _), ListaSolucao),

	% Isabela está em uma das pontas.
	noCanto(passageira(isabela, _, _, _, _, _), ListaSolucao),

	% A passageira de mochila Verde está exatamente à direita da passageira de mochila Amarela.
	exatamenteADireita(passageira(_, verde, _, _, _, _), passageira(_, amarela, _, _, _, _), ListaSolucao),

	% Rafaela está ao lado da mulher que sentará na poltrona 11.
	aoLado(passageira(rafaela, _, _, _, _, _), passageira(_, _, _, 11, _, _), ListaSolucao),

	% A mulher que está escutando Samba está em algum lugar entre a mulher que está bebendo suco de Maçã e a mulher que está escutando Rock, nessa ordem.
	entre(passageira(_, _, _, _, samba, _), passageira(_, _, _, _, _, maca), passageira(_, _, _, _, rock, _), ListaSolucao),

	% Na segunda posição está a mulher que está escutando MPB.
	nth0(1, ListaSolucao, passageira(_, _, _, _, mpb, _)),

	% A mulher que sentará na poltrona 4 está ao lado da passageira que está ouvindo Rock.
	aoLado(passageira(_, _, _, 4, _, _), passageira(_, _, _, _, rock, _), ListaSolucao),

	% Sabrina está exatamente à direita da passageira que visitará os Tios.
	exatamenteADireita(passageira(sabrina, _, _, _, _, _), passageira(_, _, tios, _, _, _), ListaSolucao),

	% A mulher que sentará na poltrona 28 está exatamente à esquerda da mulher que sentará na poltrona 34.
	aEsquerda(passageira(_, _, _, 28, _, _), passageira(_, _, _, 34, _, _), ListaSolucao),

	% A mulher que está bebendo suco de Maçã está em algum lugar entre a mulher que está escutando MPB e a mulher que visitará os Sobrinhos, nessa ordem.
	entre(passageira(_, _, _, _, _, maca), passageira(_, _, _, _, mpb, _), passageira(_, _, sobrinhos, _, _, _), ListaSolucao),

	% A dona da mochila Verde está em algum lugar à esquerda da passageira que está bebendo suco de Uva.
	aEsquerda(passageira(_, verde, _, _, _, _), passageira(_, _, _, _, _, uva), ListaSolucao),

	% Em uma das pontas está a mulher que está bebendo suco de Abacaxi.
	noCanto(passageira(_, _, _, _, _, abacaxi), ListaSolucao),

	% A passageira que vai visitar os Tios está exatamente à direita da passageira que está ouvindo Pop.
	exatamenteADireita(passageira(_, _, tios, _, _, _), passageira(_, _, _, _, pop, _), ListaSolucao),

	% A mulher de mochila Branca está em algum lugar entre a Ana e a mulher de mochila Azul, nessa ordem.
	entre(passageira(_, branca, _, _, _, _), passageira(ana, _, _, _, _, _), passageira(_, azul, _, _, _, _), ListaSolucao),

	% A mulher que sentará na poltrona 34 está ao lado da mulher que está ouvindo Sertanejo.
	aoLado(passageira(_, _, _, 34, _, _), passageira(_, _, _, _, sertanejo, _), ListaSolucao),

	% A passageira de mochila Branca está em algum lugar à esquerda da passageira que sentará na poltrona 11.
	aEsquerda(passageira(_, branca, _, _, _, _), passageira(_, _, _, 11, _, _), ListaSolucao),

	nome(Nome1),
	nome(Nome2),
	nome(Nome3),
	nome(Nome4),
	nome(Nome5),
	todosDiferentes([Nome1, Nome2, Nome3, Nome4, Nome5]),

	mochila(Mochila1),
	mochila(Mochila2),
	mochila(Mochila3),
	mochila(Mochila4),
	mochila(Mochila5),
	todosDiferentes([Mochila1, Mochila2, Mochila3, Mochila4, Mochila5]),

	visitar(Visitar1),
	visitar(Visitar2),
	visitar(Visitar3),
	visitar(Visitar4),
	visitar(Visitar5),
	todosDiferentes([Visitar1, Visitar2, Visitar3, Visitar4, Visitar5]),

	poltrona(Poltrona1),
	poltrona(Poltrona2),
	poltrona(Poltrona3),
	poltrona(Poltrona4),
	poltrona(Poltrona5),
	todosDiferentes([Poltrona1, Poltrona2, Poltrona3, Poltrona4, Poltrona5]),

	musica(Musica1),
	musica(Musica2),
	musica(Musica3),
	musica(Musica4),
	musica(Musica5),
	todosDiferentes([Musica1, Musica2, Musica3, Musica4, Musica5]),

	suco(Suco1),
	suco(Suco2),
	suco(Suco3),
	suco(Suco4),
	suco(Suco5),
	todosDiferentes([Suco1, Suco2, Suco3, Suco4, Suco5]).