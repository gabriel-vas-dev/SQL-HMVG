-----------------analitico-------------------

SELECT
 exa_lab.nm_exa_lab           as "Exame"
 ,count(itped_lab.cd_ped_lab)  as "QTD" --de exames no pedido
 ,exa_lab.nm_mnemonico         as "Sigla"
 ,PED_LAB.CD_CONVENIO 			AS "CONVENIO"
FROM
  dbamv.Ped_lab
 ,dbamv.itPed_lab
 ,dbamv.exa_lab_set_exa
 ,dbamv.exa_lab
WHERE
  ped_lab.cd_ped_lab          = itPed_lab.cd_ped_lab
  AND itPed_lab.cd_exa_lab    = exa_lab_set_exa.cd_exa_lab(+)
  AND itPed_lab.cd_set_exa    = exa_lab_set_exa.cd_set_exa(+)
  AND itPed_lab.cd_exa_lab    = exa_lab.cd_exa_lab
  and itPed_lab.dt_laudo between '01/01/2024' and '12/12/2024' --per�do dos exames com laudos                       
 Group by
 exa_lab.nm_exa_lab
 ,exa_lab.nm_mnemonico
 ,PED_LAB.CD_CONVENIO 
 order by QTD DESC--, exa_lab.nm_exa_lab; --ordem pela data do laudo
 

-------------------SINTETICO----------------------
 
select
  ped_lab.cd_convenio as convenio,
  count(*) as quantidade_exames
from dbamv.ped_lab ped_lab,
     dbamv.itped_lab itped_lab,
     dbamv.exa_lab_set_exa exa_lab_set_exa,
     dbamv.exa_lab exa_lab
where ped_lab.cd_ped_lab       = itped_lab.cd_ped_lab
  and itped_lab.cd_exa_lab     = exa_lab_set_exa.cd_exa_lab(+)
  and itped_lab.cd_set_exa     = exa_lab_set_exa.cd_set_exa(+)
  and itped_lab.cd_exa_lab     = exa_lab.cd_exa_lab
  and itped_lab.dt_laudo      >= date '2023-01-01'
  and itped_lab.dt_laudo      <  date '2023-12-31'
group by ped_lab.cd_convenio
order by quantidade_exames desc;