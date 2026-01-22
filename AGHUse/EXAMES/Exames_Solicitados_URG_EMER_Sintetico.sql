
select COUNT(*) as TOTAL_EXAMES
from agh.ael_item_solicitacao_exames
inner join agh.ael_solicitacao_exames
  on agh.ael_solicitacao_exames.seq = agh.ael_item_solicitacao_exames.soe_seq
inner join agh.agh_atendimentos
  on agh.agh_atendimentos.seq = agh.ael_solicitacao_exames.atd_seq
where agh.agh_atendimentos.emp_id = 1
and agh.agh_atendimentos.unf_seq in (25,27)
and ael_solicitacao_exames.criado_em >= DATE '2025-01-01'
and ael_solicitacao_exames.criado_em <  DATE '2025-12-31' 
 --[[AND {{periodo}}]]