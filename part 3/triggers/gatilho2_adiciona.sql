.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

---Um cliente não pode acrescentar ao carrinho uma peça específica
---numa quantidade maior que a do stock existente.

create trigger if not exists limitarAoStockExistente
before insert on Selecao
for each row
when exists (select * from PecaEspecifica where idPecaEspecifica = new.idPecaEspecifica and New.quantSelecionada > PecaEspecifica.stock)
begin
	select raise(abort, 'Stock insuficiente');
end;