.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

---A data de chegada deve ser posterior à data de expedição
---e ambas devem ser posteriores à data do pedido.

create trigger if not exists verificaDatas
before insert on Envio2
for each row
when exists (select * from Encomenda where dataPedido > new.dataExpedicao or dataPedido > new.dataChegada) or new.dataExpedicao > new.dataChegada
begin
	select raise(abort, 'Datas incoerentes');
end;