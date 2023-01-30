.headers on
.mode columns
.nullvalue NULL

---Quais são os países onde foram entregues menos encomendas
---e quais os países onde não se fez nenhuma entrega, ordenados por ordem crescente de entregas e pelo nome? 

create view if not exists EncomendaPais as
select Pais.nome, count(idEncomenda) as numEncomendas
from Envio2, Morada, Localidade, Pais
where Morada.idMorada = Envio2.idMorada and Localidade.idLocalidade = Morada.idLocalidade and Pais.idPais = Localidade.idPais
group by Pais.nome;


select nome as nomePais, numEncomendas
from EncomendaPais EP1
where not exists (select * from EncomendaPais EP2 where EP2.numEncomendas < EP1.numEncomendas)
union
select nome, 0
from Pais
where Pais.nome not in (select nome from EncomendaPais)
order by numEncomendas, nomePais;



