select msc.atd_seq as ATENDIMENTO,
ap.nome as PACIENTE,
ae.nome_especialidade as ESPECIALIDADE,
msc.dthr_solicitada as DATA_SOLICITACAO,
msc.dthr_resposta as DATA_RESPOSTA,
auf.descricao as UNIDADE
from mpm_solicitacao_consultorias msc 
inner join agh_atendimentos aa 
on aa.seq = msc.atd_seq 
inner join agh_especialidades ae 
on ae.seq = msc.esp_seq 
inner join agh_unidades_funcionais auf 
on auf.seq = aa.unf_seq 
inner join aip_pacientes ap 
on aa.pac_codigo = ap.codigo 
where aa.emp_id =1
and aa.unf_seq = 71 -- 71 UTI G
and ae.seq in (300,1487,1160,1484,366) -- 1487 INT-ORTOPEDIA -  300 NEFROLOGIA - 1160 INFECTOLOGIA - 1484 INT-VASCULAR - 366 OFTALMOLOGIA - 
and msc.dthr_solicitada >= DATE '2025-05-01'
and msc.dthr_solicitada <  DATE '2025-08-30' 