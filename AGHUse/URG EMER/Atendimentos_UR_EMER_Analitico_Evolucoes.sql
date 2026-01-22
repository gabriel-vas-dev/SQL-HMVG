 SELECT
  at.seq        AS ATENDIMENTO,
  at.pac_codigo AS CODIGO,
  ap.nome       AS PACIENTE,
  auf.descricao as UNIDADE,
  at.dthr_inicio as DATA
FROM agh.agh_atendimentos at
JOIN aip_pacientes ap
  ON ap.codigo = at.pac_codigo
join agh_unidades_funcionais auf 
	on at.unf_seq = auf.seq 
where at.emp_id = 1 
  AND at.unf_seq in (25,27)
  AND EXISTS (
    SELECT 1
    FROM mam_evolucoes
    JOIN mam_item_evolucoes mie
      ON mie.evo_seq = mam_evolucoes.seq
    WHERE mam_evolucoes.con_numero = at.con_numero
      AND mie.descricao IS NOT NULL
      --AND me.dthr_criacao >= DATE '2025-01-01'
      --AND me.dthr_criacao <  DATE '2025-12-31'
	 -- [[AND {{periodo}}]]
	  
  );