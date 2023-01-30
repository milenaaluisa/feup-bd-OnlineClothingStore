.headers on
.mode columns
.nullvalue NULL

---Listagem das encomendas por ordem crescente dos preços totais.

select Encomenda.idEncomenda, sum(quantSelecionada*preco) as precoTotal
from Encomenda
join Compra on Compra.idEncomenda = Encomenda.idEncomenda
join PecaEspecifica on PecaEspecifica.idPecaEspecifica = Compra.idPecaEspecifica
join PecaGenerica on PecaGenerica.idPecaGenerica = PecaEspecifica.idPecaGenerica
group by Encomenda.idEncomenda
order by precoTotal;