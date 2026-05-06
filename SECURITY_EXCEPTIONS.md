# Registro de Excepciones de Seguridad (ISO 27001)

## Sistema: Plataforma Analítica INEGI (Visualización)
**Fecha de Revisión:** 2026-05-04
**Estado:** APROBADO (Riesgo Residual Aceptado)

### Hallazgo: Dependencia sin mantenimiento activo (react-pivottable)
Durante el análisis de vulnerabilidades (`npm audit`), se identificó que la librería de Capa de Presentación `react-pivottable` no ha recibido actualizaciones activas desde el año 2021.

### Análisis de Riesgo Técnico
1. **Alcance de Ejecución:** La librería opera exclusivamente del lado del cliente (DOM / Browser), sin componentes de servidor (Node.js).
2. **Capacidades I/O:** El paquete carece de capacidades para iniciar conexiones de red salientes de forma autónoma (No XHR/Fetch injections comprobadas).
3. **Acceso a Datos Sensibles:** La librería no tiene acceso al local storage, cookies HttpOnly ni tokens JWT. Recibe un JSON en memoria (React State) proveniente del Backend (el cual ya ha aplicado los filtros de embargo `fecha_liberacion <= NOW()`).

### Estrategia de Mitigación y Decisión
Se determina que el vector de ataque está limitado a una potencial manipulación del DOM local en el contexto del usuario (XSS de bajo impacto), lo cual no compromete la integridad de la base de datos (Single Source of Truth) ni la confidencialidad de datos embargados.

**Dictamen:** Se acepta el riesgo de utilizar esta dependencia estrictamente para propósitos de análisis multidimensional (Pivot Tables) en la Capa 4 de la arquitectura, al no representar una amenaza de exfiltración de datos. Se sugiere congelar la versión en el `package-lock.json` para evitar inyecciones maliciosas futuras.
