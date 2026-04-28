# PIB Mexico Dashboard — Robust Relational Database for Economic Analysis

[![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?logo=mysql&logoColor=white)](https://www.mysql.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE)

## Table of Contents

- [Overview](#overview)
- [Database Architecture](#database-architecture)
- [Schema Design](#schema-design)
- [Normalization Process](#normalization-process)
- [Security and Access Control](#security-and-access-control)
- [SQL Queries](#sql-queries)
- [Installation](#installation)
- [Roadmap](#roadmap)
- [License](#license)
- [Version en Espanol](#version-en-espanol)

---

## Overview

This project implements a production-grade relational database for the analysis of Mexico's Quarterly Gross Domestic Product (GDP), sourced from official INEGI (National Institute of Statistics and Geography) datasets. The system comprises 12 normalized tables, 5,000+ records, stored procedures, materialized views, optimized indexes, and a role-based access control layer with 6 preconfigured users.

The database is designed to support analytical workloads including sectoral comparisons, time-series trend analysis, and growth rate computation across economic subsectors.

## Database Architecture

The system follows a **Star Schema** design pattern, with `datos_economicos` as the central fact table surrounded by dimension tables for time periods, economic series, sectors, and subsectors.

### Entity-Relationship Summary

| Relationship Type | Description |
|-------------------|-------------|
| **1:N** | `instituciones` -> `accesos_usuarios`, `sectores_economicos` -> `subsectores`, `series_economicas` -> `datos_economicos`, `periodos_tiempo` -> `datos_economicos`, `usuarios` -> `consultas_almacenadas`, `usuarios` -> `logs_acceso`, `usuarios` -> `notificaciones` |
| **N:M** | `instituciones` <-> `usuarios` (via `accesos_usuarios`), `series_economicas` <-> `subsectores` (via `datos_economicos`) |

### Referential Integrity

- `ON DELETE CASCADE` applied to dependent child tables where orphan records are unacceptable.
- `ON DELETE SET NULL` applied to audit logs and subsector references to preserve historical data.

## Schema Design

| Table | Purpose | Approximate Record Count |
|-------|---------|--------------------------|
| `instituciones` | Institutional entities consuming the database | 50+ |
| `series_economicas` | GDP indicator types and measurement units | 50+ |
| `sectores_economicos` | Primary, secondary, and tertiary sector classification | 50+ |
| `subsectores` | Granular economic subsector breakdown | 50+ |
| `periodos_tiempo` | Quarterly time periods from 1993-Q1 to 2025-Q2 | 132 |
| `datos_economicos` | Fact table: indicator values per period and subsector | 5,000+ |
| `usuarios` | System users with role assignments | 60+ |
| `accesos_usuarios` | User-institution permission mappings | 150+ |
| `consultas_almacenadas` | Saved reusable SQL queries | 20+ |
| `logs_acceso` | Audit trail for user actions | 75+ |
| `notificaciones` | System notification queue | 70+ |
| `metadatos` | Descriptive metadata for tables and fields | 60+ |

## Normalization Process

The database satisfies Third Normal Form (3NF):

- **1NF**: All attributes contain atomic values; no repeating groups exist.
- **2NF**: All non-key attributes are fully functionally dependent on the entire primary key; no partial dependencies.
- **3NF**: No transitive dependencies exist between non-key attributes.

### Identified Denormalization Cases

Strategic denormalization has been documented for two performance-critical scenarios:

1. **Growth Rate Pre-computation** — Pre-calculated absolute and percentage growth values stored in a dedicated table to eliminate expensive self-joins on the fact table during dashboard rendering.
2. **Sectoral Aggregation** — Pre-aggregated GDP totals per sector stored to accelerate comparative sectoral analysis queries.

Full denormalization justification and trade-off analysis is documented in [relaciones_y_normalizacion.md](./relaciones_y_normalizacion.md).

## Security and Access Control

### Role-Based Access Control (RBAC)

| Role | Privileges | Scope |
|------|-----------|-------|
| `administrador_rol` | Full administrative access | All tables and operations |
| `analista_rol` | Read/write on analytical tables | Economic data and queries |
| `consultor_rol` | Read-only access | Views and select operations |
| `investigador_rol` | Read + query management | Data and stored queries |
| `gobierno_rol` | Read/write + reporting | Economic data and statistics |

### Security Measures

- Password expiration policy (90-day rotation cycle)
- Per-user connection limits to prevent resource exhaustion
- Security views to restrict column-level access
- Comprehensive audit logging with timestamp and IP tracking
- Configurable session timeouts

## SQL Queries

The project includes 12+ demonstrative SQL queries showcasing:

- Multi-table `JOIN` operations across fact and dimension tables
- Complex `WHERE` filtering with subqueries
- Aggregation using `GROUP BY` with `HAVING` constraints
- Window functions (`ROW_NUMBER`, `OVER`) for growth calculations
- Common Table Expressions (CTEs) for readability

## Installation

### Prerequisites

- MySQL 8.0 or higher
- A SQL client (MySQL CLI, DBeaver, or equivalent)

### Execution Order

```bash
# 1. Create schema and tables
mysql -u root -p < baseDedatos_pib_mexico_db.sql

# 2. Populate with INEGI data
mysql -u root -p pib_mexico_db < insert_pib_mexico_db.sql

# 3. Execute demonstrative queries
mysql -u root -p pib_mexico_db < consultas_pib_mexico_db.sql
```

## Project Structure

```
pib-mexico-dashboard/
    baseDedatos_pib_mexico_db.sql    # Schema definition, views, stored procedures, indexes
    insert_pib_mexico_db.sql         # Data population (5,000+ records)
    consultas_pib_mexico_db.sql      # 12+ analytical SQL queries
    relaciones_y_normalizacion.md    # Normalization documentation and relationship analysis
    Diagrama01.png                   # Entity-relationship diagram
    Diagrama02.png                   # Entity-relationship diagram (extended)
    README.md
    LICENSE
```

## Roadmap

- [ ] REST API layer (Node.js / Express) to expose data endpoints
- [ ] Interactive web dashboard with Chart.js / D3.js visualizations
- [ ] Docker containerization for portable deployment
- [ ] Cloud database migration (Azure Database for MySQL)
- [ ] Swagger / OpenAPI documentation for API endpoints
- [ ] Integration test suite for stored procedures

## License

This project is licensed under the MIT License. See [LICENSE](./LICENSE) for details.

---

**Developed by [Leonardo Diaz](https://github.com/LeoDiaz-DataSc)**

---

---

# Version en Espanol

# PIB Mexico Dashboard — Base de Datos Relacional Robusta para Analisis Economico

## Indice

- [Descripcion General](#descripcion-general)
- [Arquitectura de la Base de Datos](#arquitectura-de-la-base-de-datos)
- [Diseno del Esquema](#diseno-del-esquema)
- [Proceso de Normalizacion](#proceso-de-normalizacion)
- [Seguridad y Control de Acceso](#seguridad-y-control-de-acceso)
- [Consultas SQL](#consultas-sql)
- [Instalacion](#instalacion)
- [Hoja de Ruta](#hoja-de-ruta)

---

## Descripcion General

Este proyecto implementa una base de datos relacional de nivel productivo para el analisis del Producto Interno Bruto Trimestral de Mexico, basado en datos oficiales del INEGI (Instituto Nacional de Estadistica y Geografia). El sistema comprende 12 tablas normalizadas, mas de 5,000 registros, procedimientos almacenados, vistas materializadas, indices optimizados y una capa de control de acceso basado en roles con 6 usuarios preconfigurados.

La base de datos esta disenada para soportar cargas de trabajo analiticas incluyendo comparaciones sectoriales, analisis de tendencias en series de tiempo y computo de tasas de crecimiento entre subsectores economicos.

## Arquitectura de la Base de Datos

El sistema sigue un patron de diseno de **Esquema Estrella**, con `datos_economicos` como tabla de hechos central rodeada de tablas de dimension para periodos temporales, series economicas, sectores y subsectores.

### Resumen de Relaciones

| Tipo de Relacion | Descripcion |
|------------------|-------------|
| **1:N** | `instituciones` -> `accesos_usuarios`, `sectores_economicos` -> `subsectores`, `series_economicas` -> `datos_economicos`, `periodos_tiempo` -> `datos_economicos`, `usuarios` -> `consultas_almacenadas`, `usuarios` -> `logs_acceso`, `usuarios` -> `notificaciones` |
| **N:M** | `instituciones` <-> `usuarios` (mediante `accesos_usuarios`), `series_economicas` <-> `subsectores` (mediante `datos_economicos`) |

### Integridad Referencial

- `ON DELETE CASCADE` aplicado a tablas dependientes donde los registros huerfanos son inaceptables.
- `ON DELETE SET NULL` aplicado a logs de auditoria y referencias de subsectores para preservar datos historicos.

## Diseno del Esquema

| Tabla | Proposito | Conteo Aproximado de Registros |
|-------|-----------|-------------------------------|
| `instituciones` | Entidades institucionales que consumen la base de datos | 50+ |
| `series_economicas` | Tipos de indicadores del PIB y unidades de medida | 50+ |
| `sectores_economicos` | Clasificacion en sectores primario, secundario y terciario | 50+ |
| `subsectores` | Desglose granular de subsectores economicos | 50+ |
| `periodos_tiempo` | Periodos trimestrales desde 1993-T1 hasta 2025-T2 | 132 |
| `datos_economicos` | Tabla de hechos: valores de indicadores por periodo y subsector | 5,000+ |
| `usuarios` | Usuarios del sistema con asignacion de roles | 60+ |
| `accesos_usuarios` | Mapeo de permisos usuario-institucion | 150+ |
| `consultas_almacenadas` | Consultas SQL reutilizables guardadas | 20+ |
| `logs_acceso` | Rastro de auditoria de acciones de usuario | 75+ |
| `notificaciones` | Cola de notificaciones del sistema | 70+ |
| `metadatos` | Metadatos descriptivos para tablas y campos | 60+ |

## Proceso de Normalizacion

La base de datos satisface la Tercera Forma Normal (3FN):

- **1FN**: Todos los atributos contienen valores atomicos; no existen grupos repetitivos.
- **2FN**: Todos los atributos no clave dependen funcionalmente de la clave primaria completa; sin dependencias parciales.
- **3FN**: No existen dependencias transitivas entre atributos no clave.

### Casos de Desnormalizacion Identificados

Se ha documentado desnormalizacion estrategica para dos escenarios criticos de rendimiento:

1. **Pre-computo de Tasas de Crecimiento** — Valores de crecimiento absoluto y porcentual pre-calculados almacenados en una tabla dedicada para eliminar auto-joins costosos en la tabla de hechos durante la renderizacion del dashboard.
2. **Agregacion Sectorial** — Totales de PIB pre-agregados por sector almacenados para acelerar consultas de analisis sectorial comparativo.

La justificacion completa de desnormalizacion y el analisis de compromisos esta documentado en [relaciones_y_normalizacion.md](./relaciones_y_normalizacion.md).

## Seguridad y Control de Acceso

### Control de Acceso Basado en Roles (RBAC)

| Rol | Privilegios | Alcance |
|-----|------------|---------|
| `administrador_rol` | Acceso administrativo completo | Todas las tablas y operaciones |
| `analista_rol` | Lectura/escritura en tablas analiticas | Datos economicos y consultas |
| `consultor_rol` | Acceso de solo lectura | Vistas y operaciones select |
| `investigador_rol` | Lectura + gestion de consultas | Datos y consultas almacenadas |
| `gobierno_rol` | Lectura/escritura + reportes | Datos economicos y estadisticas |

### Medidas de Seguridad

- Politica de expiracion de contrasenas (ciclo de rotacion de 90 dias)
- Limites de conexion por usuario para prevenir agotamiento de recursos
- Vistas de seguridad para restringir acceso a nivel de columna
- Registro de auditoria completo con marca de tiempo y rastreo de IP
- Timeouts de sesion configurables

## Consultas SQL

El proyecto incluye 12+ consultas SQL demostrativas que exhiben:

- Operaciones `JOIN` multi-tabla entre tablas de hechos y dimensiones
- Filtrado complejo con `WHERE` y subconsultas
- Agregacion usando `GROUP BY` con restricciones `HAVING`
- Funciones de ventana (`ROW_NUMBER`, `OVER`) para calculos de crecimiento
- Expresiones de Tabla Comun (CTEs) para legibilidad

## Instalacion

### Requisitos Previos

- MySQL 8.0 o superior
- Un cliente SQL (MySQL CLI, DBeaver o equivalente)

### Orden de Ejecucion

```bash
# 1. Crear esquema y tablas
mysql -u root -p < baseDedatos_pib_mexico_db.sql

# 2. Poblar con datos del INEGI
mysql -u root -p pib_mexico_db < insert_pib_mexico_db.sql

# 3. Ejecutar consultas demostrativas
mysql -u root -p pib_mexico_db < consultas_pib_mexico_db.sql
```

## Hoja de Ruta

- [ ] Capa de API REST (Node.js / Express) para exponer endpoints de datos
- [ ] Dashboard web interactivo con visualizaciones Chart.js / D3.js
- [ ] Contenedorizacion con Docker para despliegue portatil
- [ ] Migracion a base de datos en la nube (Azure Database for MySQL)
- [ ] Documentacion Swagger / OpenAPI para endpoints de la API
- [ ] Suite de pruebas de integracion para procedimientos almacenados

---

**Desarrollado por [Leonardo Diaz](https://github.com/LeoDiaz-DataSc)**