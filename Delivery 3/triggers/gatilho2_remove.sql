.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

---Um cliente não pode acrescentar ao carrinho uma peça específica
---numa quantidade maior que a do stock existente.

drop trigger if exists limitarAoStockExistente;