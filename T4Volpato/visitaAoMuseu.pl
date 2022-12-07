%Cinco mulheres estão lado a lado visitando um museu. Cada uma chegou num horário, utilizou um meio de transporte e gosta de um pintor.



bolsa(vermelha)
bolsa(azul)
bolsa(amarela)
bolsa(verde)
bolsa(branca)
nome(Adriana)
nome(Poliana)
nome(Iara)
nome(Cecilia)
nome(Sabrina)
idade(20)
idade(28)
idade(33)
idade(45)
idade(56)
pintor(brasileiro)
pintor(espanhol)
pintor(italiano)
pintor(holandes)
pintor(frances)
chegada(900)
chegada(930)
chegada(1000)
chegada(1030)
chegada(1100)

transporte(onibus)
transporte(trem)
transporte(carro)
transporte(bicicleta)
transporte(metro)

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

exatamenteADireita(X, Y, Lista) :-
	aDireita(X, Y, Lista).

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
    ].


%Na primeira posição está quem foi de Trem.

    transporte(Trem),
    aEsquerda(visitante(_,_,_,_,_,Trem),_,ListaSolucao),

%Sabrina está em algum lugar entre a dona da bolsa Amarela e a visitante que gosta do pintor Francês, nessa ordem.

    nome(Sabrina),
    entre(visitante(_,Sabrina,_,_,_,_),visitante(_,_,_,_,_,_),visitante(_,_,_,frances,_,_),ListaSolucao),

%Na primeira posição está quem foi de Trem.
    
    transporte(Trem),
    aEsquerda(visitante(_,_,_,_,_,Trem),_,ListaSolucao),

%A visitante mais velha está em algum lugar à direita da visitante da bolsa Azul.
    
    idade(IdadeMaisVelha),
    aDireita(visitante(_,_,IdadeMaisVelha,_,_,_),visitante(_,_,_,_,_,_),ListaSolucao),

%A mulher que chegou às 10:00 está ao lado da visitante que gosta do pintor Brasileiro.
        
    chegada(1000),
    aoLado(visitante(_,_,_,_,1000,_),visitante(_,_,_,brasileiro,_,_),ListaSolucao),

%A visitante de 28 anos está em algum lugar entre a dona da bolsa Branca e a mulher mais nova, nessa ordem.
            
    idade(28),
    entre(visitante(_,_,28,_,_,_),visitante(_,_,_,_,_,_),visitante(_,_,IdadeMaisNova,_,_,_),ListaSolucao),

%A dona da bolsa Azul está em algum lugar à esquerda de quem chegou às 10:30.
                    
    bolsa(azul),
    aEsquerda(visitante(azul,_,_,_,_,_),visitante(_,_,_,_,1030,_),ListaSolucao),

%Quem foi de Metrô está ao lado de quem gosta do pintor Brasileiro.
                        
    transporte(metro),
    aoLado(visitante(_,_,_,_,_,metro),visitante(_,_,_,brasileiro,_,_),ListaSolucao),

%Adriana está ao lado de quem foi de Bicicleta.
                            
    nome(Adriana),
    aoLado(visitante(_,Adriana,_,_,_,_),visitante(_,_,_,_,_,bicicleta),ListaSolucao),

%Cecília está em uma das pontas.
                                
    nome(Cecilia),
    noCanto(visitante(_,Cecilia,_,_,_,_),ListaSolucao),

%A visitante que gosta do pintor Brasileiro está em algum lugar entre a mulher de 45 anos e a mulher que gosta do pintor Italiano, nessa ordem.
                                    
    pintor(brasileiro),
    entre(visitante(_,_,45,_,_,_),visitante(_,_,_,_,_,_),visitante(_,_,_,italiano,_,_),ListaSolucao),

%A mulher de 33 anos está ao lado da mulher que foi de Ônibus para a exposição.
                                        
    idade(33),
    aoLado(visitante(_,_,33,_,_,_),visitante(_,_,_,_,_,onibus),ListaSolucao),

%A visitante da bolsa Verde gosta do pintor Francês.
                                                
    bolsa(verde),
    pintor(frances),
    aoLado(visitante(verde,_,_,_,_,_),visitante(_,_,_,frances,_,_),ListaSolucao),   

%Quem foi de Carro está ao lado de quem chegou às 10:00.
                                                        
    transporte(carro),
    aoLado(visitante(_,_,_,_,_,carro),visitante(_,_,_,_,1000,_),ListaSolucao),

%Poliana está em algum lugar à direita da mulher de bolsa Azul. 
                                                                
    nome(Poliana),
    aDireita(visitante(_,Poliana,_,_,_,_),visitante(azul,_,_,_,_,_),ListaSolucao),

%Quem foi de Bicicleta está em algum lugar entre quem foi de Metrô e quem foi de Ônibus, nessa ordem.
                                                                        
    transporte(bicicleta),
    entre(visitante(_,_,_,_,_,bicicleta),visitante(_,_,_,_,_,_),visitante(_,_,_,_,_,onibus),ListaSolucao),

%A visitante que chegou mais cedo está ao lado da visitante de bolsa Vermelha.
                                                                                    
    chegada(ChegadaMaisCedo),
    aoLado(visitante(_,_,_,_,ChegadaMaisCedo,_),visitante(vermelha,_,_,_,_,_),ListaSolucao),

%Iara está ao lado da mulher de bolsa Azul.
                                                                                                
    nome(Iara),
    aoLado(visitante(_,Iara,_,_,_,_),visitante(azul,_,_,_,_,_),ListaSolucao),

%A visitante que foi de Bicicleta está exatamente à esquerda da visitante de bolsa Verde.
                                                                                                        
    transporte(bicicleta),
    aEsquerda(visitante(_,_,_,_,_,bicicleta),visitante(verde,_,_,_,_,_),ListaSolucao),

%A visitante que gosta do pintor Francês está ao lado de Sabrina.
                                                                                                                
    pintor(frances),
    nome(Sabrina),
    aoLado(visitante(_,_,_,frances,_,_),visitante(_,Sabrina,_,_,_,_),ListaSolucao),

%Quem gosta do pintor Espanhol está ao lado de quem chegou às 9:00.
                                                                                                                        
    pintor(espanhol),
    aoLado(visitante(_,_,_,espanhol,_,_),visitante(_,_,_,_,900,_),ListaSolucao),

%A dona da bolsa Vermelha gosta do pintor Italiano.
                                                                                                                            
    bolsa(vermelha),
    pintor(italiano),
    aoLado(visitante(vermelha,_,_,_,_,_),visitante(_,_,_,italiano,_,_),ListaSolucao),

%Quem chegou às 9:30 está entre quem foi de Trem e quem chegou às 9:00, nessa ordem.
                                                                                                                                
    chegada(930),
    entre(visitante(_,_,_,_,930,_),visitante(_,_,_,_,_,_),visitante(_,_,_,_,900,_),ListaSolucao),

%A visitante de bolsa Branca está ao lado da visitante que foi de Metrô.
                                                                                                                                        
    bolsa(branca),
    transporte(metro),
    aoLado(visitante(branca,_,_,_,_,_),visitante(_,_,_,_,_,metro),ListaSolucao),

    