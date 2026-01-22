SELECT
  at.seq        AS ATENDIMENTO,
  at.pac_codigo AS CODIGO,
  ap.nome       AS PACIENTE
FROM agh.agh_atendimentos at
JOIN aip_pacientes ap
  ON ap.codigo = at.pac_codigo
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
      AND me.dthr_criacao <  DATE '2025-12-31'
  );