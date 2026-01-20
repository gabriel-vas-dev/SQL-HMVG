--###CONSULTA ANALITICA DO EXTRATO DOS EXAMES DE IMAGENS #####
select ped.cd_atendimento "Atendimento", ped.cd_ped_rx "Pedido", ped.dt_pedido "Data", TO_CHAR(ped.hr_pedido,'HH24:MI:SS')  "Hora", 
ped.nm_usuario "Prestador", pac.cd_paciente "Prontu�rio", pac.nm_paciente "Paciente", exa.ds_exa_rx "Exame", exa.nm_mnemonico "Sigla", 
item.dt_realizado "Realizado"--, lau.dt_study "Estudo"
from ped_rx ped
inner join itped_rx item
on item.cd_ped_rx = ped.cd_ped_rx
inner join atendime ate
on ate.cd_atendimento = ped.cd_atendimento
inner join paciente pac
on ate.cd_paciente = pac.cd_paciente
inner join exa_rx exa
on exa.cd_exa_rx = item.cd_exa_rx
--left outer join mtadmin.laudos lau
--on lau.cd_ped_rx = ped.cd_ped_rx
--and lau.examenome = exa.ds_exa_rx
where 1=1
--and ped.cd_Atendimento = 285688 --atendimento especifico
--and item.sn_realizado = 'S' -- apenas exames realizados com imagens 
and ped.dt_pedido between '01/06/2023' and '30/06/2023' -- consulta pela pedido do exame
--and item.dt_realizado between '01/08/2021' and '31/08/2021' -- consulta pela realiza��o do exame
and not item.dt_realizado is null --exames realizados, "APENAS RADIAOLOGIA E TOMOGRAFIA"
--and not item.cd_exa_rx in (966, 718, 646, 273, 244, 579) -- exames n�o reallizados pelo setor da radiologia
and ped.cd_set_exa in (4)   --7: ULTRASSONOGRAFIA, 4: RADIOLOGIA, 6: ENDOSCOPIA, 5: TOMOGRAFIA, 1: LABORATORIO, 21: ANATOMO PATOLOGICO
                             --15: CARDIOLOGIA, 14: BANCO DE SANQUE,  
--and aten.cd_especialid in () --especialidade 11 - cirurgia geral , 33 - ortopedia
--and aten.tp_atendimento in ('I') --A: ambulatorio E e U : ugencia/emergencia I: interna��o
--and not lau.dt_study is null -- data o estudo preenchido no DCE 
order by ped.dt_pedido, exa.ds_exa_rx

--###CONSULTA PARA QUANTIDADE DE EXAMES DE IMAGENS #####
select  exa.ds_exa_rx "Exame", exa.nm_mnemonico "Sigla", Count(item.cd_itped_rx) "Quantidade", ped.CD_CONVENIO AS CONVENIO
from ped_rx ped
inner join itped_rx item
on item.cd_ped_rx = ped.cd_ped_rx
inner join atendime ate
on ate.cd_atendimento = ped.cd_atendimento
inner join paciente pac
on ate.cd_paciente = pac.cd_paciente
inner join exa_rx exa
on exa.cd_exa_rx = item.cd_exa_rx
--inner join mtadmin.laudos lau
--on lau.cd_ped_rx = ped.cd_ped_rx
--and lau.examenome = exa.ds_exa_rx
where 1=1
--and ped.cd_Atendimento = 285688 --atendimento especifico
--and item.sn_realizado = 'S' -- apenas exames realizados com imagens 
and ped.dt_pedido between '10/01/2024' and '11/01/2024' -- consulta pela pedido do exame
--and item.dt_realizado between '01/08/2021' and '31/08/2021' -- consulta pela realiza��o do exame
and not item.dt_realizado is null --exames realizados, "APENAS RADIAOLOGIA E TOMOGRAFIA" 
--and not item.cd_exa_rx in (966, 718, 646, 273, 244, 579) -- exames n�o reallizados pelo setor da radiologia
and ped.cd_set_exa in (4,6,5)   --7: ULTRASSONOGRAFIA, 4: RADIOLOGIA, 6: ENDOSCOPIA, 5: TOMOGRAFIA, 1: LABORATORIO, 21: ANATOMO PATOLOGICO
                             --15: CARDIOLOGIA, 14: BANCO DE SANQUE,  
--and aten.cd_especialid in () --especialidade 11 - cirurgia geral , 33 - ortopedia
--and aten.tp_atendimento in ('I') --A: ambulatorio E e U : ugencia/emergencia I: interna��o
--and not lau.dt_study is null -- data o estudo preenchido no DCE
group by exa.ds_exa_rx, exa.nm_mnemonico,ped.CD_CONVENIO
order by exa.ds_exa_rx


---------------------SINTETICO---------------------------------

-- TOTAL DE EXAMES (IMAGEM) POR CONVÊNIO
select
  ped.cd_convenio as convenio,
  count(item.cd_itped_rx) as quantidade
from ped_rx ped
inner join itped_rx item
  on item.cd_ped_rx = ped.cd_ped_rx
inner join atendime ate
  on ate.cd_atendimento = ped.cd_atendimento
inner join paciente pac
  on ate.cd_paciente = pac.cd_paciente
inner join exa_rx exa
  on exa.cd_exa_rx = item.cd_exa_rx
where 1=1
  and ped.dt_pedido >= to_date('01/01/2023','dd/mm/yyyy')
  and ped.dt_pedido <  to_date('31/01/2023','dd/mm/yyyy') -- dia seguinte ao fim (inclui 11/01 inteiro)
  and item.dt_realizado is not null
  and ped.cd_set_exa in (4,6,5)
group by ped.cd_convenio
order by quantidade desc;



