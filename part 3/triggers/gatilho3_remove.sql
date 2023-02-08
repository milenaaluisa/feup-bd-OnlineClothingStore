.mode columns
.header on
.nullvalue NULL

---A data de chegada deve ser posterior à data de expedição
---e ambas devem ser posteriores à data do pedido.

PRAGMA foreign_keys = ON;

drop trigger if exists verificarDatas;