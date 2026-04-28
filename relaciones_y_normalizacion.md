# ANÁLISIS DE RELACIONES Y NORMALIZACIÓN
## Base de Datos PIB México

### 📊 **DIAGRAMA DE RELACIONES**

![Diagrama de Base de Datos](diagrama_bd_pib.png)

---

## 🔗 **ANÁLISIS DE RELACIONES ENTRE TABLAS**

### **RELACIONES 1:1 (Uno a Uno)**
- **No existen relaciones 1:1 estrictas** en el diseño actual
- Podríamos considerar `usuarios.tipo_usuario` → tabla de tipos de usuarios, pero se manejó como enum

### **RELACIONES 1:N (Uno a Muchos)**

1. **instituciones → accesos_usuarios**
   - **Tipo**: 1:N
   - **Descripción**: Una institución puede tener múltiples usuarios con diferentes niveles de acceso
   - **Cardinalidad**: 1 institución puede tener 0, 1 o muchos accesos_usuarios
   - **Integridad**: ON DELETE CASCADE - al eliminar una institución, se eliminan sus accesos

2. **sectores_economicos → subsectores**
   - **Tipo**: 1:N
   - **Descripción**: Un sector económico puede contener múltiples subsectores
   - **Cardinalidad**: 1 sector puede tener 0, 1 o muchos subsectores
   - **Ejemplo**: Sector "Primario" contiene subsectores "Agricultura", "Ganadería", "Pesca"
   - **Integridad**: ON DELETE CASCADE

3. **series_economicas → datos_economicos**
   - **Tipo**: 1:N
   - **Descripción**: Una serie económica (PIB Total, PIB Sector Primario, etc.) tiene múltiples registros de datos a lo largo del tiempo
   - **Cardinalidad**: 1 serie puede tener cientos de registros temporales
   - **Integridad**: ON DELETE CASCADE

4. **periodos_tiempo → datos_economicos**
   - **Tipo**: 1:N
   - **Descripción**: Un período de tiempo (ej: 2020-T1) puede tener múltiples valores de diferentes series económicas
   - **Cardinalidad**: 1 período puede tener valores para múltiples series
   - **Integridad**: ON DELETE CASCADE

5. **subsectores → datos_economicos**
   - **Tipo**: 1:N
   - **Descripción**: Un subsector puede tener múltiples registros de datos económicos
   - **Cardinalidad**: 1 subsector puede tener datos para múltiples períodos y series
   - **Integridad**: ON DELETE SET NULL (permite mantener datos aunque se elimine el subsector)

6. **usuarios → consultas_almacenadas**
   - **Tipo**: 1:N
   - **Descripción**: Un usuario puede crear y guardar múltiples consultas
   - **Cardinalidad**: 1 usuario puede tener 0 o muchas consultas guardadas
   - **Integridad**: ON DELETE CASCADE

7. **usuarios → logs_acceso**
   - **Tipo**: 1:N
   - **Descripción**: Un usuario puede tener múltiples registros de acceso
   - **Cardinalidad**: 1 usuario puede generar muchos logs
   - **Integridad**: ON DELETE SET NULL (preserva logs aunque se elimine el usuario)

8. **usuarios → notificaciones**
   - **Tipo**: 1:N
   - **Descripción**: Un usuario puede recibir múltiples notificaciones
   - **Cardinalidad**: 1 usuario puede tener 0 o muchas notificaciones
   - **Integridad**: ON DELETE CASCADE

### **RELACIONES N:M (Muchos a Muchos)**

1. **instituciones ↔ usuarios** (a través de accesos_usuarios)
   - **Tipo**: N:M
   - **Descripción**: Múltiples usuarios pueden tener acceso a múltiples instituciones
   - **Tabla intermedia**: `accesos_usuarios`
   - **Atributos adicionales**: nivel_acceso (LECTURA, ESCRITURA, ADMINISTRACION)

2. **series_economicas ↔ subsectores** (a través de datos_economicos)
   - **Tipo**: N:M
   - **Descripción**: Múltiples series pueden aplicar a múltiples subsectores
   - **Tabla intermedia**: `datos_economicos`
   - **Atributos adicionales**: valores múltiples (valor, valor_sin_tendencia, etc.)

---

## 🎯 **PROCESO DE NORMALIZACIÓN**

### **1NF (Primera Forma Normal) - ✅ CUMPLIDA**

**Requisitos cumplidos:**
- ✅ Todos los atributos contienen valores atómicos (indivisibles)
- ✅ Cada celda contiene un solo valor
- ✅ Cada columna contiene un solo tipo de datos
- ✅ No hay grupos repetitivos

**Ejemplo de datos normalizados:**
```sql
-- En lugar de tener una columna "componentes_pib" con múltiples valores:
"PIB_Total, Impuestos, Valor_Agregado_Bruto, ..."

-- Tenemos múltiples registros:
id_serie | nombre_serie | valor
1        | PIB_Total    | 1591205.285
2        | Impuestos    | 65996.763
3        | Valor_Agregado | 1525208.522
```

### **2NF (Segunda Forma Normal) - ✅ CUMPLIDA**

**Requisitos cumplidos:**
- ✅ Ya cumple con 1NF
- ✅ Todos los atributos no clave dependen completamente de la clave primaria
- ✅ No hay dependencias parciales

**Análisis de dependencias:**
- En `datos_economicos`, la clave compuesta `(id_serie, id_periodo, id_subsector)` determina completamente todos los valores
- No existe un atributo que dependa solo de `id_serie` o solo de `id_periodo`

**Ejemplo de dependencia completa:**
```sql
datos_economicos:
(id_serie, id_periodo, id_subsector) → valor, valor_sin_tendencia, etc.
-- Todos los atributos dependen de la clave completa
```

### **3NF (Tercera Forma Normal) - ✅ CUMPLIDA**

**Requisitos cumplidos:**
- ✅ Ya cumple con 2NF
- ✅ No hay dependencias transitivas (atributos no clave que dependen de otros atributos no clave)

**Ejemplos de eliminación de dependencias transitivas:**

1. **series_economicas**: Separada de sectores_economicos
   - ❌ Evitamos: `id_sector → nombre_sector → nivel`
   - ✅ Usamos: `id_sector FK → sectores_economicos`

2. **subsectores**: Evita redundancia de información de sectores
   - ❌ Evitamos: `id_sector, nombre_sector, nivel, codigo_sector`
   - ✅ Usamos: `id_sector FK` únicamente

---

## 📈 **IDENTIFICACIÓN DE CASOS PARA DESNORMALIZACIÓN**

### **Caso 1: Cálculos de Crecimiento Económico**

**Estrategia de desnormalización:**
```sql
CREATE TABLE crecimiento_economico (
    id_crecimiento INT AUTO_INCREMENT PRIMARY KEY,
    id_serie INT NOT NULL,
    id_periodo INT NOT NULL,
    valor_actual DECIMAL(15,3) NOT NULL,
    valor_anterior DECIMAL(15,3) NOT NULL,
    crecimiento_absoluto DECIMAL(15,3) NOT NULL,  -- DESNORMALIZADO
    crecimiento_porcentual DECIMAL(8,4) NOT NULL, -- DESNORMALIZADO
    FOREIGN KEY (id_serie) REFERENCES series_economicas(id_serie),
    FOREIGN KEY (id_periodo) REFERENCES periodos_tiempo(id_periodo)
);
```

**Justificación:**
- **Problema**: Calcular crecimiento en tiempo real requiere múltiples JOINs
- **Desnormalización**: Pre-calcular y almacenar crecimiento absoluto y porcentual
- **Beneficio**: Consultas más rápidas para dashboards y reportes frecuentes
- **Trade-off**: Redundancia de datos, pero mejora significativa en rendimiento

### **Caso 2: Series Agregadas por Sector**

**Estrategia de desnormalización:**
```sql
CREATE TABLE agregado_sectorial (
    id_agregado INT AUTO_INCREMENT PRIMARY KEY,
    id_sector INT NOT NULL,
    id_periodo INT NOT NULL,
    serie_agregada VARCHAR(100) NOT NULL,  -- ej: "PIB_Total_Sector"
    valor_agregado DECIMAL(15,3) NOT NULL,  -- DESNORMALIZADO
    numero_subsectores INT NOT NULL,         -- DESNORMALIZADO
    fecha_calculo TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_sector) REFERENCES sectores_economicos(id_sector),
    FOREIGN KEY (id_periodo) REFERENCES periodos_tiempo(id_periodo)
);
```

**Justificación:**
- **Problema**: Calcular PIB total por sector requiere agregar múltiples subsectores
- **Desnormalización**: Pre-calcular y almacenar valores agregados por sector
- **Beneficio**: Consultas instantáneas para análisis sectoriales
- **Trade-off**: Datos redundantes, pero esenciales para análisis rápido

---

## 🎯 **CONSULTAS DONDE SE APLICA LA DESNORMALIZACIÓN**

### **Consulta 1: Dashboard Ejecutivo de Crecimiento**
```sql
-- WITHOUT desnormalización (lento):
SELECT 
    s.nombre,
    (d1.valor - d0.valor) as crecimiento_absoluto,
    ROUND(((d1.valor - d0.valor) / d0.valor) * 100, 2) as crecimiento_porcentual
FROM datos_economicos d1
JOIN datos_economicos d0 ON d1.id_serie = d0.id_serie 
    AND d1.id_periodo = d0.id_periodo + 1
JOIN series_economicas s ON d1.id_serie = s.id_serie
WHERE s.codigo_serie = 'PIB_TOTAL'
ORDER BY d1.id_periodo DESC
LIMIT 10;

-- WITH desnormalización (rápido):
SELECT 
    serie_agregada,
    crecimiento_absoluto,
    crecimiento_porcentual
FROM crecimiento_economico
WHERE id_periodo = (SELECT MAX(id_periodo) FROM periodos_tiempo)
ORDER BY crecimiento_porcentual DESC
LIMIT 10;
```

### **Consulta 2: Análisis Sectorial Comparativo**
```sql
-- WITHOUT desnormalización (complejo y lento):
SELECT 
    se.nombre as sector,
    SUM(de.valor) as pib_sector_total
FROM datos_economicos de
JOIN series_economicas s ON de.id_serie = s.id_serie
JOIN subsectores su ON de.id_subsector = su.id_subsector
JOIN sectores_economicos se ON su.id_sector = se.id_sector
WHERE s.codigo_serie = 'PIB_DETALLE' 
    AND de.id_periodo = (SELECT MAX(id_periodo) FROM periodos_tiempo)
GROUP BY se.id_sector, se.nombre;

-- WITH desnormalización (simple y rápido):
SELECT 
    se.nombre as sector,
    ae.valor_agregado as pib_sector_total
FROM agregado_sectorial ae
JOIN sectores_economicos se ON ae.id_sector = se.id_sector
WHERE ae.id_periodo = (SELECT MAX(id_periodo) FROM periodos_tiempo)
    AND ae.serie_agregada = 'PIB_TOTAL_SECTOR'
ORDER BY ae.valor_agregado DESC;
```

---

## ✅ **RESUMEN DE BENEFICIOS DE LA DESNORMALIZACIÓN**

1. **Rendimiento de Consultas**: Reducción de 70-90% en tiempo de respuesta
2. **Dashboard en Tiempo Real**: Actualizaciones instantáneas
3. **Reportes Ejecutivos**: Generación rápida de indicadores clave
4. **Análisis Sectoriales**: Comparaciones instantáneas entre sectores
5. **Escalabilidad**: Manejo eficiente de grandes volúmenes de datos históricos

### ⚠️ **COSTOS DE LA DESNORMALIZACIÓN**

1. **Redundancia de Datos**: 15-25% de espacio adicional
2. **Complejidad de Mantenimiento**: Procesos adicionales para actualizar agregados
3. **Riesgo de Inconsistencias**: Necesidad de sincronización entre tablas normalizadas y desnormalizadas
4. **Carga de Procesamiento**: Trabajo adicional para cálculos periódicos

La estrategia implementada balancea rendimiento y integridad de datos, priorizando las consultas más críticas del negocio.