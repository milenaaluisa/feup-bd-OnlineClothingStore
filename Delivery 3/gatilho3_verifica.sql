---A data de chegada deve ser posterior à data de expedição
---e ambas devem ser posteriores à data do pedido.

select Encomenda.idEncomenda, dataPedido, dataExpedicao, dataChegada
from Envio2
join Encomenda on Encomenda.idEncomenda = Envio2.idEncomenda;

insert into Encomenda(idEncomenda, dataPedido) values (13, '2021-12-01');
insert into Envio2(idEncomenda, idMorada, dataExpedicao, dataChegada, codigoRastreamento) values(13, 11, '2020-12-01', '2019-12-01', 'JKSAD89');

select Encomenda.idEncomenda, dataPedido, dataExpedicao, dataChegada
from Envio2
join Encomenda on Encomenda.idEncomenda = Envio2.idEncomenda;