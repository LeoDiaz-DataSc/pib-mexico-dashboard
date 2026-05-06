-- =====================================================
-- DISEÑO Y MODELADO DEL ESQUEMA DE BASE DE DATOS
-- Producto Interno Bruto Trimestral de México (INEGI)
-- =====================================================

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS pib_mexico_db;
USE pib_mexico_db;

-- =====================================================
-- 1. TABLA: INSTITUCIONES
-- =====================================================
CREATE TABLE instituciones (
    id_institucion INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    siglas VARCHAR(50),
    pais VARCHAR(100) DEFAULT 'México',
    fecha_creacion DATE,
    descripcion TEXT
);

-- =====================================================
-- 2. TABLA: SERIES_ECONOMICAS
-- =====================================================
CREATE TABLE series_economicas (
    id_serie INT AUTO_INCREMENT PRIMARY KEY,
    codigo_serie VARCHAR(100) UNIQUE NOT NULL,
    nombre VARCHAR(500) NOT NULL,
    descripcion TEXT,
    unidad_medida VARCHAR(100),
    base_periodo VARCHAR(50),
    frecuencia ENUM('MENSUAL', 'TRIMESTRAL', 'SEMESTRAL', 'ANUAL') DEFAULT 'TRIMESTRAL',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- 3. TABLA: SECTORES_ECONOMICOS
-- =====================================================
CREATE TABLE sectores_economicos (
    id_sector INT AUTO_INCREMENT PRIMARY KEY,
    codigo_sector VARCHAR(50) UNIQUE NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    nivel ENUM('PRIMARIO', 'SECUNDARIO', 'TERCIARIO') NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

-- =====================================================
-- 4. TABLA: SUBSECTORES
-- =====================================================
CREATE TABLE subsectores (
    id_subsector INT AUTO_INCREMENT PRIMARY KEY,
    id_sector INT NOT NULL,
    codigo_subsector VARCHAR(50) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    orden_presentacion INT,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_sector) REFERENCES sectores_economicos(id_sector) ON DELETE CASCADE
);

-- =====================================================
-- 5. TABLA: PERIODOS_TIEMPO
-- =====================================================
CREATE TABLE periodos_tiempo (
    id_periodo INT AUTO_INCREMENT PRIMARY KEY,
    año INT NOT NULL,
    trimestre TINYINT CHECK (trimestre BETWEEN 1 AND 4),
    semestre TINYINT CHECK (semestre BETWEEN 1 AND 2),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    etiqueta_periodo VARCHAR(20) NOT NULL, -- ej: "2020-T1", "2020-S1"
    UNIQUE KEY unique_año_trimestre (año, trimestre)
);

-- =====================================================
-- 6. TABLA: DATOS_ECONOMICOS (Tabla de hechos principal)
-- =====================================================
CREATE TABLE datos_economicos (
    id_dato INT AUTO_INCREMENT PRIMARY KEY,
    id_serie INT NOT NULL,
    id_periodo INT NOT NULL,
    id_subsector INT,
    valor DECIMAL(15,3) NOT NULL,
    valor_sin_tendencia DECIMAL(15,3),
    valor_ciclico DECIMAL(15,3),
    valor_tendencia DECIMAL(15,3),
    valor_irregular DECIMAL(15,3),
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    fecha_liberacion TIMESTAMP NULL, -- Modulo Embargo
    fuente VARCHAR(255),
    
    FOREIGN KEY (id_serie) REFERENCES series_economicas(id_serie) ON DELETE CASCADE,
    FOREIGN KEY (id_periodo) REFERENCES periodos_tiempo(id_periodo) ON DELETE CASCADE,
    FOREIGN KEY (id_subsector) REFERENCES subsectores(id_subsector) ON DELETE SET NULL,
    
    UNIQUE KEY unique_serie_periodo_subsector (id_serie, id_periodo, id_subsector)
);

-- =====================================================
-- 7. TABLA: USUARIOS
-- =====================================================
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    contraseña_hash VARCHAR(255) NOT NULL,
    mfa_secret VARCHAR(100), -- ISO 27001 MFA
    mfa_enabled BOOLEAN DEFAULT FALSE,
    nombre_completo VARCHAR(255),
    institucion VARCHAR(255),
    tipo_usuario ENUM('ADMIN', 'ANALISTA', 'LECTOR', 'CONSULTA') DEFAULT 'LECTOR',
    activo BOOLEAN DEFAULT TRUE,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- 8. TABLA: ACCESOS_USUARIOS
-- =====================================================
CREATE TABLE accesos_usuarios (
    id_acceso INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_institucion INT NOT NULL,
    nivel_acceso ENUM('LECTURA', 'ESCRITURA', 'ADMINISTRACION') DEFAULT 'LECTURA',
    fecha_asignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_institucion) REFERENCES instituciones(id_institucion) ON DELETE CASCADE
);

-- =====================================================
-- 9. TABLA: CONSULTAS_ALMACENADAS
-- =====================================================
CREATE TABLE consultas_almacenadas (
    id_consulta INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    nombre_consulta VARCHAR(255) NOT NULL,
    descripcion TEXT,
    sql_consulta TEXT NOT NULL,
    tipo_resultado ENUM('TABLA', 'GRAFICO', 'REPORTE') DEFAULT 'TABLA',
    parametros JSON,
    uso_frecuencia INT DEFAULT 0,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_ultimo_uso TIMESTAMP NULL,
    
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- =====================================================
-- 10. TABLA: LOGS_ACCESO
-- =====================================================
CREATE TABLE logs_acceso (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    ip_usuario VARCHAR(45),
    accion VARCHAR(100) NOT NULL,
    tabla_afectada VARCHAR(100),
    registros_afectados INT,
    fecha_accion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    detalles JSON,
    
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE SET NULL
);

-- =====================================================
-- 11. TABLA: NOTIFICACIONES
-- =====================================================
CREATE TABLE notificaciones (
    id_notificacion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo ENUM('INFO', 'ALERTA', 'ERROR', 'ACTUALIZACION') DEFAULT 'INFO',
    titulo VARCHAR(255) NOT NULL,
    mensaje TEXT NOT NULL,
    leida BOOLEAN DEFAULT FALSE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_lectura TIMESTAMP NULL,
    
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- =====================================================
-- 12. TABLA: METADATOS
-- =====================================================
CREATE TABLE metadatos (
    id_metadato INT AUTO_INCREMENT PRIMARY KEY,
    tabla_nombre VARCHAR(100) NOT NULL,
    campo_nombre VARCHAR(100) NOT NULL,
    valor_metadato TEXT NOT NULL,
    descripcion TEXT,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    UNIQUE KEY unique_tabla_campo (tabla_nombre, campo_nombre)
);

-- =====================================================
-- ÍNDICES PARA OPTIMIZACIÓN
-- =====================================================

-- Índices en datos_economicos para consultas frecuentes
CREATE INDEX idx_datos_serie_periodo ON datos_economicos(id_serie, id_periodo);
CREATE INDEX idx_datos_año_trimestre ON datos_economicos(id_periodo, id_serie);
CREATE INDEX idx_datos_subsector ON datos_economicos(id_subsector);
CREATE INDEX idx_datos_valor ON datos_economicos(valor);

-- Índices en periodos_tiempo
CREATE INDEX idx_periodos_año ON periodos_tiempo(año);
CREATE INDEX idx_periodos_etiqueta ON periodos_tiempo(etiqueta_periodo);

-- Índices en series_economicas
CREATE INDEX idx_series_codigo ON series_economicas(codigo_serie);
CREATE INDEX idx_series_frecuencia ON series_economicas(frecuencia);

-- Índices en usuarios
CREATE INDEX idx_usuarios_email ON usuarios(email);
CREATE INDEX idx_usuarios_tipo ON usuarios(tipo_usuario);

-- =====================================================
-- VISTAS PARA CONSULTAS FRECUENTES
-- =====================================================

-- Vista para datos del PIB por trimestre
CREATE VIEW vista_pib_trimestral AS
SELECT 
    p.etiqueta_periodo,
    p.año,
    p.trimestre,
    s.codigo_serie,
    s.nombre as nombre_serie,
    de.valor,
    de.valor_sin_tendencia,
    COALESCE(su.nombre, 'N/A') as subsector
FROM datos_economicos de
JOIN periodos_tiempo p ON de.id_periodo = p.id_periodo
JOIN series_economicas s ON de.id_serie = s.id_serie
LEFT JOIN subsectores su ON de.id_subsector = su.id_subsector
WHERE (s.codigo_serie LIKE '%PIB%' OR s.nombre LIKE '%Producto interno bruto%')
  AND (de.fecha_liberacion <= CURRENT_TIMESTAMP OR de.fecha_liberacion IS NULL)
ORDER BY p.año DESC, p.trimestre DESC;

-- Vista para series por sector económico
CREATE VIEW vista_series_por_sector AS
SELECT 
    se.id_sector,
    se.codigo_sector,
    se.nombre as nombre_sector,
    COUNT(serie_count.total_series) as total_series
FROM sectores_economicos se
LEFT JOIN (
    SELECT 
        su.id_sector,
        COUNT(*) as total_series
    FROM subsectores su
    JOIN datos_economicos de ON su.id_subsector = de.id_subsector
    GROUP BY su.id_sector
) serie_count ON se.id_sector = serie_count.id_sector
GROUP BY se.id_sector, se.codigo_sector, se.nombre;

-- =====================================================
-- PROCEDIMIENTOS ALMACENADOS
-- =====================================================

DELIMITER //

-- Procedimiento para obtener datos del PIB por rango de años
CREATE PROCEDURE obtener_pib_por_anos(
    IN año_inicio INT,
    IN año_fin INT
)
BEGIN
    SELECT 
        p.año,
        p.trimestre,
        p.etiqueta_periodo,
        s.nombre as serie,
        de.valor
    FROM datos_economicos de
    JOIN periodos_tiempo p ON de.id_periodo = p.id_periodo
    JOIN series_economicas s ON de.id_serie = s.id_serie
    WHERE p.año BETWEEN año_inicio AND año_fin
        AND (s.codigo_serie LIKE '%PIB%' OR s.nombre LIKE '%Producto interno bruto%')
    ORDER BY p.año, p.trimestre;
END //

-- Procedimiento para calcular crecimiento trimestral
CREATE PROCEDURE calcular_crecimiento_trimestral(
    IN serie_codigo VARCHAR(100)
)
BEGIN
    WITH datos_con_orden AS (
        SELECT 
            de.id_dato,
            de.valor,
            p.año,
            p.trimestre,
            p.etiqueta_periodo,
            ROW_NUMBER() OVER (ORDER BY p.año, p.trimestre) as fila_num
        FROM datos_economicos de
        JOIN periodos_tiempo p ON de.id_periodo = p.id_periodo
        JOIN series_economicas s ON de.id_serie = s.id_serie
        WHERE s.codigo_serie = serie_codigo
    )
    SELECT 
        dco.año,
        dco.trimestre,
        dco.etiqueta_periodo,
        dco.valor,
        dco.valor - dpa.valor as crecimiento_absoluto,
        ROUND(((dco.valor - dpa.valor) / dpa.valor) * 100, 2) as crecimiento_porcentual
    FROM datos_con_orden dco
    JOIN datos_con_orden dpa ON dco.fila_num = dpa.fila_num + 1
    ORDER BY dco.año, dco.trimestre;
END //

DELIMITER ;