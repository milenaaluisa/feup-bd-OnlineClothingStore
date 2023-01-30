---Um cliente não pode acrescentar ao carrinho uma peça específica
---numa quantidade maior que a do stock existente.

select * from Selecao;

insert into Selecao(idCarrinho, idPecaEspecifica, quantSelecionada) values(13, 26, 1000);

select * from Selecao