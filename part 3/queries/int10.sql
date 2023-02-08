.headers on
.mode columns
.nullvalue NULL

---Listagem dos clientes que já adquiriram peças de todos os materiais.

---Criação da view que contém o total de materiais diferentes que existem
create view if not exists viewIdMateriais as
select count(idMaterial) as materiaisExistentes
from Material; 

select Cliente.idCliente, Cliente.nome, count(distinct PecaGenerica.idMaterial) as materiaisComprados
from Cliente
join Pagamento on Cliente.idCliente = Pagamento.idCliente
join Encomenda on Encomenda.idEncomenda = Pagamento.idEncomenda
join Compra on Compra.idEncomenda = Encomenda.idEncomenda
join PecaEspecifica on PecaEspecifica.idPecaEspecifica = Compra.idPecaEspecifica
join PecaGenerica on PecaGenerica.idPecaGenerica = PecaEspecifica.idPecaGenerica
group by Cliente.idCliente
having count(distinct PecaGenerica.idMaterial) = (select materiaisExistentes from viewIdMateriais);