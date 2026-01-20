select
  extract(year from ate.dt_atendimento) as ano,
  count(*) as qtd
from atendime ate
where ate.tp_atendimento in ('U', 'E')
  and ate.dt_atendimento >= date '2018-01-01'
  and ate.dt_atendimento <  date '2024-01-01'
group by extract(year from ate.dt_atendimento)
order by ano;