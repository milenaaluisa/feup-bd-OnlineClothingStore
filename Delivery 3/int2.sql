.mode columns
.headers on
.nullvalue NULL

---Quais são as peças genéricas mais e menos adquiridas?

---Criação da View que contém a quantidade vendida por cada peça genérica
create view if not exists QuantPecaGenerica as
select idPecaGenerica, sum(somaEspecifica) as somaGenerica
from PecaEspecifica
natural join (select idPecaEspecifica, sum(quantSelecionada) as somaEspecifica
              from Compra
              group by idPecaEspecifica) as QuantEspecifica
group by idPecaGenerica;


select idPecaGenerica, descricao, somaGenerica as quantVendida
from PecaGenerica
natural join QuantPecaGenerica as QPG1
where not exists (select * from QuantPecaGenerica QPG2 where QPG2.somaGenerica > QPG1.somaGenerica) or
      not exists (select * from QuantPecaGenerica QPG2 where QPG2.somaGenerica < QPG1.somaGenerica)
order by quantidadeTotalAdquirida DESC, idPecaGenerica;

