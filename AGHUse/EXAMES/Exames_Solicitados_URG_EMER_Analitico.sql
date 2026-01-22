select agh.agh_atendimentos.seq as ATENDIMENTO,aip_pacientes.nome as NOME, agh.ael_item_solicitacao_exames.soe_seq as SOL_EXAME, agh.ael_item_solicitacao_exames.ufe_ema_exa_sigla as SIGLA, agh_unidades_funcionais.descricao as UNIDADE, agh.ael_solicitacao_exames.criado_em as DATA 
from agh.ael_item_solicitacao_exames  -- item solicitado dentro do exame
inner join agh.ael_solicitacao_exames
on agh.ael_solicitacao_exames.seq = agh.ael_item_solicitacao_exames.soe_seq
inner join agh.agh_atendimentos
on agh.agh_atendimentos.seq = agh.ael_solicitacao_exames.atd_seq
join agh_unidades_funcionais 
on agh.agh_atendimentos.unf_seq = agh_unidades_funcionais.seq
JOIN aip_pacientes 
  ON aip_pacientes.codigo = agh.agh_atendimentos.pac_codigo
where agh.agh_atendimentos.emp_id = 1
and agh.agh_atendimentos.unf_seq in (25,27)
order by agh.agh_atendimentos.seq asc;