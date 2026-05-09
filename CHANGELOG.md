# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-05-08

### Added
- **MFA Security**: Integración de Multi-Factor Authentication (Speakeasy) en el proceso de Login.
- **JWT Authorization**: Rutas de administrador (`/api/admin/logs`, `/api/admin/cron-logs`) aseguradas mediante middlewares de JWT y roles.
- **GSAP UI**: Nueva interfaz de Login con animaciones premium y ruteo seguro (`PrivateRoute`).
- **Documentación**: Estándares corporativos ISO 27001 (Security) e ISO 9001 (Quality Policy).

### Changed
- El Frontend (React) ahora envía encabezados de autorización Bearer de forma automática mediante un interceptor de Axios.
- Consolidación del repositorio bajo la arquitectura Enterprise 12-módulos y preparación para CI/CD.
