.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

---Quando é efetuada uma encomenda,
---o stock é atualizado em cada peça específica adquirida.

CREATE TRIGGER IF NOT EXISTS atualizaStock
AFTER INSERT ON Compra
FOR EACH ROW
BEGIN
	UPDATE PecaEspecifica 
	SET stock = stock - NEW.quantSelecionada
	WHERE PecaEspecifica.idPecaEspecifica = NEW.idPecaEspecifica;
END;