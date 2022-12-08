%Cinco mulheres estão lado a lado visitando um museu. Cada uma chegou num horário, utilizou um meio de transporte e gosta de um pintor.



bolsa(vermelha).
bolsa(azul).
bolsa(amarela).
bolsa(verde).
bolsa(branca).

nome(adriana).
nome(poliana).
nome(iara).
nome(cecilia).
nome(sabrina).

idade(20).
idade(28).
idade(33).
idade(45).
idade(56).

pintor(brasileiro).
pintor(espanhol).
pintor(italiano).
pintor(holandes).
pintor(frances).

chegada(900).
chegada(930).
chegada(1000).
chegada(1030).
chegada(1100).

transporte(onibus).
transporte(trem).
transporte(carro).
transporte(bicicleta).
transporte(metro).

visitante(Bolsa, Nome, Idade, Pintor, Chegada, Transporte) :-
    bolsa(Bolsa),
    nome(Nome),
    idade(Idade),
    pintor(Pintor),
    chegada(Chegada),
    transporte(Transporte).

% regras
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

exatamenteAEsquerda(X, Y, Lista) :-
    nth0(IndexX, Lista, X),
    nth0(IndexY, Lista, Y),
    IndexX is IndexY - 1.

exatamenteADireita(X, Y, Lista) :-
	nth0(IndexX, Lista, X),
	nth0(IndexY, Lista, Y),
	IndexX is IndexY + 1.

entre(Y, X, Z, Lista) :-
	aEsquerda(Y, Z, Lista),
	aEsquerda(X, Y, Lista).


solucionar(ListaSolucao) :-
    ListaSolucao = [
        visitante(Bolsa1, Nome1, Idade1, Pintor1, Chegada1, Transporte1),
        visitante(Bolsa2, Nome2, Idade2, Pintor2, Chegada2, Transporte2),
        visitante(Bolsa3, Nome3, Idade3, Pintor3, Chegada3, Transporte3),
        visitante(Bolsa4, Nome4, Idade4, Pintor4, Chegada4, Transporte4),
        visitante(Bolsa5, Nome5, Idade5, Pintor5, Chegada5, Transporte5)
    ],

    %Na primeira posição está quem foi de Trem.
    visitante(_,_,_,_,_,trem) = nth0(0,ListaSolucao,_),

    %Sabrina está em algum lugar entre a dona da bolsa Amarela e a visitante que gosta do pintor Francês, nessa ordem.

    entre(visitante(_,sabrina,_,_,_,_),visitante(amarela,_,_,_,_,_),visitante(_,_,_,frances,_,_),ListaSolucao),

    %A visitante mais velha está em algum lugar à direita da visitante da bolsa Azul.
    
    aDireita(visitante(_,_,56,_,_,_),visitante(azul,_,_,_,_,_),ListaSolucao),

    %A mulher que chegou às 10:00 está ao lado da visitante que gosta do pintor Brasileiro.
        
    aoLado(visitante(_,_,_,_,1000,_),visitante(_,_,_,brasileiro,_,_),ListaSolucao),

    %A visitante de 28 anos está em algum lugar entre a dona da bolsa Branca e a mulher mais nova, nessa ordem.
            
    entre(visitante(_,_,28,_,_,_),visitante(_,_,_,_,_,_),visitante(_,_,28,_,_,_),ListaSolucao),

    %A dona da bolsa Azul está em algum lugar à esquerda de quem chegou às 10:30.
                    
    aEsquerda(visitante(azul,_,_,_,_,_),visitante(_,_,_,_,1030,_),ListaSolucao),

    %Quem foi de Metrô está ao lado de quem gosta do pintor Brasileiro.
                        
    aoLado(visitante(_,_,_,_,_,metro),visitante(_,_,_,brasileiro,_,_),ListaSolucao),

    %Adriana está ao lado de quem foi de Bicicleta.
                            
    aoLado(visitante(_,adriana,_,_,_,_),visitante(_,_,_,_,_,bicicleta),ListaSolucao),

    %Cecília está em uma das pontas.
                                
    noCanto(visitante(_,cecilia,_,_,_,_),ListaSolucao),

    %A visitante que gosta do pintor Brasileiro está em algum lugar entre a mulher de 45 anos e a mulher que gosta do pintor Italiano, nessa ordem.
                                    
    entre(visitante(_,_,_,brasileiro,_,_),visitante(_,_,45,_,_,_),visitante(_,_,_,italiano,_,_),ListaSolucao),

    %A mulher de 33 anos está ao lado da mulher que foi de Ônibus para a exposição.
                                        
    aoLado(visitante(_,_,33,_,_,_),visitante(_,_,_,_,_,onibus),ListaSolucao),

    %A visitante da bolsa Verde gosta do pintor Francês.
                                                
    aoLado(visitante(verde,_,_,_,_,_),visitante(_,_,_,frances,_,_),ListaSolucao),   

    %Quem foi de Carro está ao lado de quem chegou às 10:00.
                                                        
    aoLado(visitante(_,_,_,_,_,carro),visitante(_,_,_,_,1000,_),ListaSolucao),

    %Poliana está em algum lugar à direita da mulher de bolsa Azul. 
                                                                
    aDireita(visitante(_,poliana,_,_,_,_),visitante(azul,_,_,_,_,_),ListaSolucao),

    %Quem foi de Bicicleta está em algum lugar entre quem foi de Metrô e quem foi de Ônibus, nessa ordem.
                                                                        
    entre(visitante(_,_,_,_,_,bicicleta),visitante(_,_,_,_,_,metro),visitante(_,_,_,_,_,onibus),ListaSolucao),

    %A visitante que chegou mais cedo está ao lado da visitante de bolsa Vermelha.
                                                                                    
    aoLado(visitante(_,_,_,_,900,_),visitante(vermelha,_,_,_,_,_),ListaSolucao),

    %Iara está ao lado da mulher de bolsa Azul.
                                                                                                
    aoLado(visitante(_,iara,_,_,_,_),visitante(azul,_,_,_,_,_),ListaSolucao),

    %A visitante que foi de Bicicleta está exatamente à esquerda da visitante de bolsa Verde.
                                                                                                        
    exatamenteAEsquerda(visitante(_,_,_,_,_,bicicleta),visitante(verde,_,_,_,_,_),ListaSolucao),

    %A visitante que gosta do pintor Francês está ao lado de Sabrina.
                                                                                                                
    aoLado(visitante(_,_,_,frances,_,_),visitante(_,sabrina,_,_,_,_),ListaSolucao),

    %Quem gosta do pintor Espanhol está ao lado de quem chegou às 9:00.
                                                                                                                        
    aoLado(visitante(_,_,_,espanhol,_,_),visitante(_,_,_,_,900,_),ListaSolucao),

    %A dona da bolsa Vermelha gosta do pintor Italiano.
                                                                                                                            
    member(visitante(vermelha,_,_,italiano,_,_),ListaSolucao),

        %Quem chegou às 9:30 está entre quem foi de Trem e quem chegou às 9:00, nessa ordem.
                                                                                                                                
    entre(visitante(_,_,_,_,930,_),visitante(_,_,_,_,_,trem),visitante(_,_,_,_,900,_),ListaSolucao),

    %A visitante de bolsa Branca está ao lado da visitante que foi de Metrô.
                                                                                                                                        
    aoLado(visitante(branca,_,_,_,_,_),visitante(_,_,_,_,_,metro),ListaSolucao),
    
    bolsa(Bolsa1),
    bolsa(Bolsa2),
    bolsa(Bolsa3),
    bolsa(Bolsa4),
    bolsa(Bolsa5),
    todosDiferentes([Bolsa1,Bolsa2,Bolsa3,Bolsa4,Bolsa5]),

    nome(Nome1),
    nome(Nome2),
    nome(Nome3),
    nome(Nome4),
    nome(Nome5),
    todosDiferentes([Nome1,Nome2,Nome3,Nome4,Nome5]),

    idade(Idade1),
    idade(Idade2),
    idade(Idade3),
    idade(Idade4),
    idade(Idade5),
    todosDiferentes([Idade1,Idade2,Idade3,Idade4,Idade5]),

    pintor(Pintor1),
    pintor(Pintor2),
    pintor(Pintor3),
    pintor(Pintor4),
    pintor(Pintor5),
    todosDiferentes([Pintor1,Pintor2,Pintor3,Pintor4,Pintor5]),

    chegada(Chegada1),
    chegada(Chegada2),
    chegada(Chegada3),
    chegada(Chegada4),
    chegada(Chegada5),
    todosDiferentes([Chegada1,Chegada2,Chegada3,Chegada4,Chegada5]),

    transporte(Transporte1),
    transporte(Transporte2),
    transporte(Transporte3),
    transporte(Transporte4),
    transporte(Transporte5),
    todosDiferentes([Transporte1,Transporte2,Transporte3,Transporte4,Transporte5]).