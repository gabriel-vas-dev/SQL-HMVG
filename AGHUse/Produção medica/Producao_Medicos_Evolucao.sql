SELECT 
    e.seq AS codigo_evolucao,
    e.dthr_criacao AS data_evolucao,
    COALESCE(p.nome, 'Profissional não identificado') AS profissional,
    COALESCE(oc.descricao, 'Cargo não identificado') AS tipo_profissional
FROM 
    agh.mam_evolucoes e
    LEFT JOIN agh.rap_servidores s ON e.ser_matricula = s.matricula 
        AND e.ser_vin_codigo = s.vin_codigo
    LEFT JOIN agh.rap_pessoas_fisicas p ON s.pes_codigo = p.codigo
    LEFT JOIN agh.rap_ocupacoes_cargo oc ON s.oca_codigo = oc.codigo
WHERE  
    (
        UPPER(COALESCE(p.nome, '')) LIKE UPPER('%EDUARDO REIMANN%')
        OR UPPER(COALESCE(p.nome, '')) LIKE UPPER('%LUAN FERREIRA SALDIVAR DE CASTRO%')
        OR UPPER(COALESCE(p.nome, '')) LIKE UPPER('%DALBA GABRIELA BARROS BORGES%')
         OR UPPER(COALESCE(p.nome, '')) LIKE UPPER('%HELIO HENRIQUE SILVA PINTO RESENDE DO NASCIMENTO%')
         OR UPPER(COALESCE(p.nome, '')) LIKE UPPER('%DIEGO ANTONIO DA GUIA SEMEDO FERNANDES%')
        -- OR UPPER(COALESCE(p.nome, '')) LIKE UPPER('%NOME_PROFISSIONAL_5%')
    )
    
    -- OPÇÃO A: Filtrar por período (descomente e ajuste as datas)
     AND e.dthr_criacao >= '2025-12-01 00:00:00'::timestamp
     AND e.dthr_criacao <= '2025-12-31 23:59:59'::timestamp
    
    -- OPÇÃO B: Filtrar por data específica (descomente e ajuste a data)
    -- AND DATE(e.dthr_criacao) = '2025-12-12'::date
  
ORDER BY 
    e.dthr_criacao DESC;
