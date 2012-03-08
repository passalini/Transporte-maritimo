Transporte-maritimo
====

Projeto para a matéria de Paradigma OO, usando OORB (https://github.com/rodrigomanhaes/oorb)

O que deveria ser
--------------

Minimundo 

Uma empresa de transporte marítimo deseja um sistema automatizado que a auxilie a alocar as cargas nos navios, de acordo com sua capacidade e destino. Cada carga deverá ser transportada integralmente por um único navio sem “transbordo”, ou seja, não pode ser dividida por mais de um navio, nem fazer “baldeação” (descer em um porto e ser embarcada em outro navio).
No momento em que a carga é aceita para ser transportada, é colada uma etiqueta contendo o número desta carga, o porto destino, seu peso em Kg, a data máxima para desembarque no porto destino (caso isto não seja atendido a empresa pagará uma multa diária), o código do agente receptor no porto destino, e a data de validade, no caso de carga perecível, ou a temperatura máxima no caso de carga sensível. Todo porto possui vários agentes receptores (cada agente opera em um único porto) e esta escolha é feita por indicação interna.
No fim do expediente o supervisor, para cada carga não embarcada, consulta uma relação contendo os navios e os portos que pertencem á rota dos navios. Caso encontre um navio que passe pelo porto destino antes da data máxima para desembarque e possua capacidade disponível, a carga é “embarcada” neste navio (se o navio passar por este porto mais de uma vez, a carga será desembarcada, sempre, na primeira chegada ao porto).

O sistema deve ser capaz de emitir:
a) Relatório dos navios e suas rotas, informando para cada navio: seu nome, sua capacidade máxima de transporte em (Kg), e a relação de portos (nome do porto) de sua rota, com a data de chegada em cada porto destino.
b) Relatório das cargas embarcadas, informando: número da carga, porto destino, navio, data máxima para desembarque da carga, e data na qual o navio vai chegar no porto.
c) Relatório das cargas não embarcadas, informando: número da carga, porto destino, data máxima para desembarque da carga, e código do agente receptor.
d) Relatório contendo, para cada porto, todos os navios que passarão por lá.
e) Relatório de todas as cargas não embarcadas porque não existe navio que passe pelo porto destino.
f) Relatório de navios em manutenção (não possuem rota).
g) Relação de todos os agentes de um determinado porto, com código e nome de cada agente, que não estão recepcionando nenhuma carga.