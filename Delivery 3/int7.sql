.headers on
.mode columns
.nullvalue NULL

---Entre as peças mais caras, qual é a que tem menor stock?

create view if not exists pgMaisCaras as
select idPecaEspecifica, PG1.idPecaGenerica as idPG, PG1.descricao as descricao
from PecaGenerica PG1, PecaEspecifica
where idPG = PecaEspecifica.idPecaGenerica and not exists (select *
							     from PecaGenerica PG2
							     where PG1.preco < PG2.preco);

create view  if not exists peMaisCaras
select pgMaisCaras.idPecaEspecifica as idPecaEspecifica, stock
from pgMaisCaras
join PecaEspecifica on PecaEspecifica.idPecaEspecifica = pgMaisCaras.idPecaEspecifica;

select idPecaEspecifica, stock
from peMaisCaras PMC1
where not exists (select *
		  from peMaisCaras PMC2
		  where PMC1.stock > PMC2.stock);