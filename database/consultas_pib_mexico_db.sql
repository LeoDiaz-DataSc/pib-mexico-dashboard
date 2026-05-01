USE pib_mexico_db;

SELECT 
    i.nombre AS institucion,
    i.siglas,
    i.pais,
    i.fecha_creacion,
    i.descripcion
FROM instituciones i
ORDER BY i.pais, i.nombre;

SELECT 
    pais,
    COUNT(*) AS total_instituciones,
    GROUP_CONCAT(siglas ORDER BY siglas SEPARATOR ', ') AS siglas_instituciones
FROM instituciones
GROUP BY pais
ORDER BY total_instituciones DESC;

SELECT 
    CASE 
        WHEN fecha_creacion < '1950-01-01' THEN 'Muy Anteriores (antes 1950)'
        WHEN fecha_creacion < '2000-01-01' THEN 'Anteriores (1950-1999)'
        ELSE 'Recientes (2000 en adelante)'
    END AS periodo_creacion,
    COUNT(*) AS total_instituciones,
    GROUP_CONCAT(nombre ORDER BY fecha_creacion SEPARATOR '; ') AS instituciones
FROM instituciones
WHERE pais = 'México'
GROUP BY periodo_creacion
ORDER BY MIN(fecha_creacion);


SELECT 
    CASE 
        WHEN institucion LIKE '%Banco%' OR institucion LIKE '%Financiero%' OR institucion LIKE '%Seguros%' OR institucion LIKE '%Banca%' THEN 'Sector Financiero'
        WHEN institucion LIKE '%Universidad%' OR institucion LIKE '%Instituto%' AND institucion LIKE '%Educación%' THEN 'Sector Educativo'
        WHEN institucion LIKE '%INEGI%' OR institucion LIKE '%CONEVAL%' OR institucion LIKE '%Banco de México%' THEN 'Estadísticas/Gobierno'
        WHEN institucion LIKE '%PEMEX%' OR institucion LIKE '%CFE%' OR institucion LIKE '%Energía%' THEN 'Sector Energético'
        WHEN institucion LIKE '%Cámara%' OR institucion LIKE '%Confederación%' THEN 'Sector Empresarial'
        ELSE 'Otros'
    END AS sector_institucion,
    COUNT(*) AS total_usuarios,
    GROUP_CONCAT(nombre_completo ORDER BY nombre_completo SEPARATOR '; ') AS usuarios
FROM usuarios
GROUP BY sector_institucion
ORDER BY total_usuarios DESC;

SELECT 
    u.nombre_completo,
    u.email,
    u.institucion,
    u.tipo_usuario,
    i.siglas AS sigla_institucion,
    i.pais
FROM usuarios u
JOIN instituciones i ON u.institucion = i.nombre
WHERE u.tipo_usuario IN ('ADMIN', 'ANALISTA')
ORDER BY u.tipo_usuario, u.nombre_completo;


-- Consulta 6, 7 , 8: Resumen ejecutivo de la base de datos
SELECT 
    'Instituciones' AS categoria,
    COUNT(*) AS total_registros,
    COUNT(DISTINCT pais) AS categorias_diferentes
FROM instituciones

UNION ALL

SELECT 
    'Series Económicas' AS categoria,
    COUNT(*) AS total_registros,
    COUNT(DISTINCT base_periodo) AS categorias_diferentes
FROM series_economicas
UNION ALL

SELECT 
    'Sectores Económicos' AS categoria,
    COUNT(*) AS total_registros,
    COUNT(DISTINCT nivel) AS categorias_diferentes
FROM sectores_economicos
UNION ALL
SELECT 
    'Subsectores' AS categoria,
    COUNT(*) AS total_registros,
    (SELECT COUNT(DISTINCT s.nivel) FROM sectores_economicos s WHERE s.id_sector IN (SELECT DISTINCT id_sector FROM subsectores)) AS categorias_diferentes
FROM subsectores
UNION ALL

SELECT 
    'Períodos Temporales' AS categoria,
    COUNT(*) AS total_registros,
    COUNT(DISTINCT año) AS categorias_diferentes
FROM periodos_tiempo
UNION ALL
SELECT 
    'Usuarios' AS categoria,
    COUNT(*) AS total_registros,
    COUNT(DISTINCT tipo_usuario) AS categorias_diferentes
FROM usuarios;

-- Consulta : Mapeo completo de estructura económica
SELECT 
    se.nivel AS categoria_principal,
    se.nombre AS sector,
    COUNT(sub.id_subsector) AS subsectores,
    COUNT(ser.codigo_serie) AS series_asociadas,
    GROUP_CONCAT(DISTINCT sub.nombre ORDER BY sub.nombre SEPARATOR ' | ') AS detalle_subsectores
FROM sectores_economicos se
LEFT JOIN subsectores sub ON se.id_sector = sub.id_sector
LEFT JOIN series_economicas ser ON ser.nombre LIKE CONCAT('%', se.nombre, '%')
GROUP BY se.id_sector, se.nivel, se.nombre
ORDER BY se.nivel, subsectores DESC;

-- Consulta: Análisis de cobertura temporal por sector
SELECT 
    p.año,
    p.trimestre,
    p.etiqueta_periodo,
    COUNT(DISTINCT se.id_sector) AS sectores_representados,
    COUNT(DISTINCT sub.id_subsector) AS subsectores_representados
FROM periodos_tiempo p
CROSS JOIN sectores_economicos se
LEFT JOIN subsectores sub ON se.id_sector = sub.id_sector
WHERE p.año BETWEEN 2020 AND 2025
GROUP BY p.id_periodo, p.año, p.trimestre, p.etiqueta_periodo
ORDER BY p.año DESC, p.trimestre DESC;

-- Consulta 20: Dashboard de métricas clave para análisis económico
SELECT 
    'Cobertura Temporal' AS metrica,
    CONCAT('Desde ', MIN(año), ' hasta ', MAX(año), ' (', COUNT(DISTINCT año), ' años)') AS valor,
    COUNT(DISTINCT año) AS valor_numerico
FROM periodos_tiempo

UNION ALL

SELECT 
    'Diversidad Sectorial' AS metrica,
    CONCAT(COUNT(DISTINCT nivel), ' niveles: ', GROUP_CONCAT(DISTINCT nivel SEPARATOR ', ')) AS valor,
    COUNT(DISTINCT nivel) AS valor_numerico
FROM sectores_economicos

UNION ALL

SELECT 
    'Series Temporales' AS metrica,
    CONCAT(COUNT(DISTINCT base_periodo), ' bases temporales') AS valor,
    COUNT(DISTINCT base_periodo) AS valor_numerico
FROM series_economicas

UNION ALL

SELECT 
    'Instituciones' AS metrica,
    CONCAT(COUNT(DISTINCT pais), ' países, ', COUNT(*), ' instituciones') AS valor,
    COUNT(*) AS valor_numerico
FROM instituciones

UNION ALL

SELECT 
    'Usuarios Activos' AS metrica,
    CONCAT(COUNT(DISTINCT tipo_usuario), ' tipos de usuario') AS valor,
    COUNT(*) AS valor_numerico
FROM usuarios;

SELECT 
    p.etiqueta_periodo,
    p.año,
    p.trimestre,
    se.codigo_serie,
    se.nombre AS serie_nombre,
    sec.nombre AS sector_nombre,
    sec.nivel,
    sub.nombre AS subsector_nombre,
    de.valor,
    de.valor_sin_tendencia
FROM datos_economicos de
INNER JOIN series_economicas se ON de.id_serie = se.id_serie
INNER JOIN periodos_tiempo p ON de.id_periodo = p.id_periodo
LEFT JOIN subsectores sub ON de.id_subsector = sub.id_subsector
LEFT JOIN sectores_economicos sec ON sub.id_sector = sec.id_sector
WHERE p.año >= 2020
    AND de.valor IS NOT NULL
ORDER BY p.año DESC, p.trimestre DESC, sec.nivel
LIMIT 100;


-- CONSULTA: Promedio de valores económicos por sector con GROUP BY
-- Calcula estadísticas agregadas por sector económico
SELECT 
    sec.codigo_sector,
    sec.nombre AS sector_nombre,
    sec.nivel,
    COUNT(DISTINCT de.id_dato) AS total_registros,
    ROUND(AVG(de.valor), 2) AS promedio_valor,
    ROUND(MIN(de.valor), 2) AS valor_minimo,
    ROUND(MAX(de.valor), 2) AS valor_maximo,
    ROUND(STDDEV(de.valor), 2) AS desviacion_estandar
FROM datos_economicos de
INNER JOIN subsectores sub ON de.id_subsector = sub.id_subsector
INNER JOIN sectores_economicos sec ON sub.id_sector = sec.id_sector
WHERE sec.activo = TRUE
    AND de.valor > 0
GROUP BY sec.id_sector, sec.codigo_sector, sec.nombre, sec.nivel
HAVING COUNT(DISTINCT de.id_dato) >= 10
ORDER BY promedio_valor DESC;


-- CONSULTA : Análisis temporal de datos por año con HAVING
-- Muestra años con alta actividad de registro de datos
SELECT 
    p.año,
    COUNT(DISTINCT de.id_dato) AS total_datos,
    COUNT(DISTINCT de.id_serie) AS series_utilizadas,
    COUNT(DISTINCT de.id_subsector) AS subsectores_involucrados,
    ROUND(AVG(de.valor), 2) AS promedio_anual,
    ROUND(SUM(de.valor), 2) AS suma_total
FROM datos_economicos de
INNER JOIN periodos_tiempo p ON de.id_periodo = p.id_periodo
WHERE de.valor IS NOT NULL
GROUP BY p.año
HAVING COUNT(DISTINCT de.id_dato) >= 50
ORDER BY p.año DESC;


-- CONSULTA : Actividad de usuarios con consultas almacenadas
-- Analiza usuarios más activos con sus consultas y accesos
{


-- CONSULTA : Series económicas más utilizadas con datos reales
-- Identifica las series con mayor cantidad de registros históricos
SELECT 
    se.codigo_serie,
    se.nombre AS serie_nombre,
    se.frecuencia,
    se.base_periodo,
    se.unidad_medida,
    COUNT(DISTINCT de.id_dato) AS total_registros,
    COUNT(DISTINCT de.id_periodo) AS periodos_cubiertos,
    MIN(p.año) AS año_inicial,
    MAX(p.año) AS año_final
FROM series_economicas se
LEFT JOIN datos_economicos de ON se.id_serie = de.id_serie
LEFT JOIN periodos_tiempo p ON de.id_periodo = p.id_periodo
WHERE se.frecuencia = 'TRIMESTRAL'
GROUP BY se.id_serie, se.codigo_serie, se.nombre, se.frecuencia, se.base_periodo, se.unidad_medida
HAVING COUNT(DISTINCT de.id_dato) > 0
ORDER BY total_registros DESC, periodos_cubiertos DESC
LIMIT 20;


-- CONSULTA : Comparativa de sectores por nivel económico con JOIN complejo
-- Analiza distribución de subsectores y datos por nivel económico
SELECT 
    sec.nivel,
    COUNT(DISTINCT sec.id_sector) AS total_sectores,
    COUNT(DISTINCT sub.id_subsector) AS total_subsectores,
    COUNT(DISTINCT de.id_dato) AS total_datos_registrados,
    ROUND(AVG(de.valor), 2) AS promedio_valores,
    COUNT(DISTINCT de.id_serie) AS series_distintas
FROM sectores_economicos sec
LEFT JOIN subsectores sub ON sec.id_sector = sub.id_sector AND sub.activo = TRUE
LEFT JOIN datos_economicos de ON sub.id_subsector = de.id_subsector
WHERE sec.activo = TRUE
GROUP BY sec.nivel
ORDER BY 
    CASE sec.nivel
        WHEN 'PRIMARIO' THEN 1
        WHEN 'SECUNDARIO' THEN 2
        WHEN 'TERCIARIO' THEN 3
    END;


-- CONSULTA : Análisis de logs de acceso con filtros complejos
-- Muestra actividad de usuarios en el sistema con estadísticas
SELECT 
    u.nombre_usuario,
    u.tipo_usuario,
    u.institucion,
    COUNT(DISTINCT la.id_log) AS total_accesos,
    COUNT(DISTINCT la.tabla_afectada) AS tablas_consultadas,
    SUM(la.registros_afectados) AS registros_totales_afectados,
    MAX(la.fecha_accion) AS ultima_accion,
    MIN(la.fecha_accion) AS primera_accion,
    GROUP_CONCAT(DISTINCT la.accion ORDER BY la.accion SEPARATOR ', ') AS tipos_acciones
FROM logs_acceso la
INNER JOIN usuarios u ON la.id_usuario = u.id_usuario
WHERE la.fecha_accion >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    AND u.activo = TRUE
GROUP BY u.id_usuario, u.nombre_usuario, u.tipo_usuario, u.institucion
HAVING COUNT(DISTINCT la.id_log) >= 5
ORDER BY total_accesos DESC, registros_totales_afectados DESC
LIMIT 30;


-- CONSULTA BONUS : Instituciones internacionales vs nacionales
SELECT 
    CASE 
        WHEN pais = 'México' THEN 'Nacional'
        ELSE 'Internacional'
    END AS tipo_institucion,
    COUNT(*) AS total_instituciones,
    MIN(fecha_creacion) AS institucion_mas_antigua,
    MAX(fecha_creacion) AS institucion_mas_reciente
FROM instituciones
GROUP BY tipo_institucion
ORDER BY tipo_institucion;
