.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

---Quando é efetuada uma encomenda,
---o stock é atualizado em cada peça específica adquirida.

DROP TRIGGER IF EXISTS atualizaStock;