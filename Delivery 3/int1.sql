.headers on
.mode columns
.nullvalue NULL

---Listagem do nome e email dos clientes e do número de peças 
---diferentes adquiridas por cada um.

select distinct nome, email, count(PecaEspecifica.idPecaEspecifica) as quantPE
from Cliente
join Pagamento on Cliente.idCliente = Pagamento.idCliente
join Encomenda on Encomenda.idEncomenda = Pagamento.idEncomenda
join Compra on Compra.idEncomenda = Encomenda.idEncomenda
join PecaEspecifica on PecaEspecifica.idPecaEspecifica = Compra.idPecaEspecifica
group by Cliente.idCliente;