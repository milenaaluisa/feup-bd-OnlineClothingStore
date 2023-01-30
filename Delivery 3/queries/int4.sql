.headers on
.mode columns
.nullvalue NULL

---Listagem de todas as encomendas efetuadas a partir do ano de 2010
---até à data presente, para Portugal

select Encomenda.idEncomenda
from Encomenda
join Envio2 on Encomenda.idEncomenda = Envio2.idEncomenda
join Morada on Morada.idMorada = Envio2.idMorada
join Localidade on Localidade.idLocalidade = Morada.idLocalidade
join (select *
      from Pais
      where nome = 'Portugal') as Portugal on Portugal.idPais = Localidade.idPais
where strftime('%Y', dataPedido) > '2010';