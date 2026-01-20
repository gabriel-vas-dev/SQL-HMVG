-------------------------ANALITICO-----------------------------

select  distinct pac.nm_paciente "Paciente", pac.nr_cpf "CPF", pac.nr_cns "Cart�o SUS", 
       avi.dt_inicio_cirurgia "Data da Cirurgia",
       avi.cd_aviso_cirurgia,
       avi.dt_aviso_cirurgia "Data da Cirurgia",  
       avi.dt_realizacao,         
        cir.ds_cirurgia "Cirurgia", 
       cir.cd_cirurgia "Codigo da Cirurgia",
       proc.cd_procedimento "Codigo", proc.ds_procedimento "Nome do Procedimento"
from paciente pac
inner join aviso_cirurgia avi
on avi.cd_paciente = pac.cd_paciente
inner join prestador_aviso pre_avi
on pre_avi.cd_aviso_cirurgia = avi.cd_aviso_cirurgia
inner join cirurgia_aviso cir_avi
on cir_avi.cd_aviso_cirurgia = avi.cd_aviso_cirurgia
inner join cirurgia cir
on cir.cd_cirurgia = cir_avi.cd_cirurgia
left outer join procedimento_sus proc
on cir.cd_procedimento_sih = proc.cd_procedimento
where 
cir_avi.sn_principal = 'S' and 
avi.dt_realizacao between '01/01/2019' and '01/07/2019' -- data da realiza��o da cirurgia
--avi.dt_aviso_cirurgia between '18/09/2022' and '21/09/2022' -- data do aviso da cirurgia (agendamento)
--avi.dt_inicio_cirurgia between '18/09/2022' and '21/09/2022' -- data prevista para a cirurgia
--and pac.nm_paciente like '%Jos�%'  -- pesquisa pelo nome do paciente
--and pac.nr_cpf like '%54545454% '  -- pesquisa pelo cpf do paciente
--and pac.nr_cns like '%445646546%'  -- pesquisa pelo cart�o do SUS do paciente
and avi.dt_cancelamento is null
and avi.tp_situacao = 'R'

order by 
avi.dt_inicio_cirurgia, avi.dt_aviso_cirurgia, avi.dt_realizacao



-------------------------SINTETICO-----------------------------



select
  extract(year from avi.dt_realizacao) as ano,
  count(distinct avi.cd_aviso_cirurgia) as qtd
from aviso_cirurgia avi
join cirurgia_aviso cir_avi
  on cir_avi.cd_aviso_cirurgia = avi.cd_aviso_cirurgia
where cir_avi.sn_principal = 'S'
  and avi.tp_situacao = 'R'
  and avi.dt_cancelamento is null
  and avi.dt_realizacao >= date '2022-01-01'
  and avi.dt_realizacao <  date '2022-12-30'
group by extract(year from avi.dt_realizacao)
order by ano;

