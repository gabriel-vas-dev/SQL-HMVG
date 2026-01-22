  SELECT
  COUNT(DISTINCT at.seq) AS CONSULTAS_REALIZADAS
FROM agh.agh_atendimentos at
WHERE at.unf_seq IN (27, 25)
  AND at.emp_id = 1
  AND EXISTS (
    SELECT 1
    FROM mam_evolucoes
    JOIN mam_item_evolucoes mie
      ON mie.evo_seq = mam_evolucoes.seq
    WHERE mam_evolucoes.con_numero = at.con_numero
      AND mie.descricao IS NOT NULL
      AND mam_evolucoes.dthr_criacao >= DATE '2025-01-01'
      AND mam_evolucoes.dthr_criacao <  DATE '2026-01-01'
	  --[[AND {{periodo}}]]
  );