---Quando é efetuada uma encomenda,
---o stock é atualizado em cada peça específica adquirida.

SELECT * FROM PecaEspecifica;

INSERT INTO Compra(idEncomenda, idPecaEspecifica, quantSelecionada) VALUES(1, 1, 2);

SELECT * FROM PecaEspecifica;