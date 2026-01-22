 SELECT
  COUNT(DISTINCT at.seq) AS CONSULTAS_REALIZADAS
FROM agh.agh_atendimentos at
WHERE at.unf_seq = 22
  AND at.emp_id = 1
  AND EXISTS (
    SELECT 1
    FROM mam_evolucoes me
    JOIN mam_item_evolucoes mie
      ON mie.evo_seq = me.seq
    WHERE me.con_numero = at.con_numero
      AND mie.descricao IS NOT NULL
      AND me.dthr_criacao >= DATE '2025-01-01'
      AND me.dthr_criacao <  DATE '2026-01-01'
  );