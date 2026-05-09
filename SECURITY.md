# Security Policy (ISO 27001 Alignment)

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| v2.0.x  | :white_check_mark: |
| v1.0.x  | :x:                |

## Reporting a Vulnerability
Por favor, envíe un correo a [security@example.com](mailto:security@example.com).

## Enterprise Security Features
- **MFA (2FA)**: Autenticación de múltiples factores obligatoria para accesos a datos económicos sensibles.
- **JWT**: Rotación de tokens y protección robusta para sesiones.
- **Auditoría (ISO 27001)**: Módulo de bitácoras de acceso (IP, Usuario, Endpoint) centralizado y de solo lectura para auditores.
- **Integridad de Datos**: Triggers a nivel de base de datos (`pib_logs`) para asegurar inmutabilidad de la información oficial de INEGI.
