select 
ate.cd_paciente as "Prontuário", 
ate.CD_ATENDIMENTO as "Atendimento",
mov.hr_mov_int as "Internação",
nm_paciente as "Paciente",
esp.ds_especialid as "Especiadade",  
ds_unid_int as "Unidade Internação",
leito.ds_leito as "Leito",
mov.tp_mov as "Tipo"
from atendime ate
inner join especialid esp on esp.cd_especialid = ate.cd_especialid
inner join  paciente on paciente.cd_paciente = ate.cd_paciente
inner join mov_int mov on mov.CD_ATENDIMENTO = ate.cd_atendimento 
inner  join leito on leito.cd_leito = mov.cd_leito
inner join unid_int on unid_int.cd_unid_int = leito.cd_unid_int
where 1=1
--and ate.DT_atendimento between '01/01/2023' and '01/02/2023'
and mov.DT_MOV_INT between '01/01/2022' and '01/02/2023'
--AND mov.TP_MOV = 'I'
and ate.tp_atendimento = 'I'
and leito.cd_unid_int = '17' -- 17 = UTI 01 - 2 = Bloco A - Predio original - 8 Blocao A Clinica Médica
--and ate.cd_atendimento= 313718
order by ate.dt_atendimento, ate.CD_ATENDIMENTO, mov.hr_mov_int desc

