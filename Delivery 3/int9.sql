.headers on
.mode columns
.nullvalue NULL

---Listagem dos clientes que efetuaram encomendas que contêm peças
---com preço superior a 30€, ordenados por ordem alfabética.

select distinct nome, idCliente
from Cliente
natural join Pagamento
natural join Compra
natural join PecaEspecifica
natural join PecaGenerica
where preco > 30
order by nome;