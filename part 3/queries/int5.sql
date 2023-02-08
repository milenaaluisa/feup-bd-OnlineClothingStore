.headers on
.mode columns
.nullvalue NULL

---Listagem dos clientes que criaram um carrinho de compras,
---não chegaram a efetuar nenhuma encomenda.

select idCliente
from Cliente, Selecao
where idCliente in (select idCliente
	 	    from Carrinho)
except
select idCliente
from Cliente
where idCliente in (select idCliente
 		    from Pagamento)