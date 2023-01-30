.headers on
.mode columns
.nullvalue NULL

---Listagem do número de cores disponíveis de cada peça genérica
---por ordem decrescente de número de cores.

select idPecaGenerica, descricao, count(idCor) as numCores
from PecaGenericaCor
natural join PecaGenerica 
group by descricao
order by numCores DESC;