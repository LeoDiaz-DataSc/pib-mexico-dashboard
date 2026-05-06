import { useState, useEffect, useRef } from 'react';
import gsap from 'gsap';
import { useGSAP } from '@gsap/react';

gsap.registerPlugin(useGSAP);

export default function LogsViewer() {
    const container = useRef();
    const [logs, setLogs] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        // En producción esto iría en services/api.js
        fetch('http://localhost:3000/api/admin/logs')
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    setLogs(data.data);
                } else {
                    setError('Error al cargar logs');
                }
            })
            .catch(err => setError(err.message))
            .finally(() => setLoading(false));
    }, []);

    useGSAP(() => {
        if (loading) return;
        const tl = gsap.timeline();
        tl.from('.logs-title', { y: -20, opacity: 0, duration: 0.5 })
          .from('.logs-card', { y: 30, opacity: 0, duration: 0.6 }, '-=0.2')
          .from('.log-row', { x: -10, opacity: 0, stagger: 0.05, duration: 0.3 }, '-=0.2');
    }, { scope: container, dependencies: [loading] });

    if (loading) return <div className="loading-spinner"><div className="spinner"></div></div>;

    return (
        <div ref={container} className="dashboard-container">
            <div className="page-header">
                <h1 className="page-title logs-title">Auditoría y Seguridad (ISO 27001)</h1>
                <p className="page-subtitle">Bitácora de Accesos y Trazabilidad del Sistema</p>
            </div>

            {error && <div className="alert alert-danger">{error}</div>}

            <div className="card logs-card">
                <div className="card-header" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <h3 className="card-title">Registros Recientes</h3>
                    <span className="badge badge-warning">Top 100</span>
                </div>
                
                {logs.length === 0 ? (
                    <div className="card-body" style={{ textAlign: 'center', padding: 40, color: '#94a3b8' }}>
                        <p style={{ fontSize: '2rem' }}>🛡️</p>
                        <p>No hay registros de auditoría aún.</p>
                    </div>
                ) : (
                    <table className="data-table">
                        <thead>
                            <tr>
                                <th>Fecha y Hora</th>
                                <th>Usuario</th>
                                <th>Rol</th>
                                <th>Acción</th>
                                <th>Tabla Afectada</th>
                                <th>Dirección IP</th>
                            </tr>
                        </thead>
                        <tbody>
                            {logs.map(log => (
                                <tr key={log.id_log} className="log-row">
                                    <td style={{ color: '#94a3b8' }}>{new Date(log.fecha_accion).toLocaleString()}</td>
                                    <td style={{ fontWeight: 600, color: '#f1f5f9' }}>{log.nombre_usuario || 'Sistema'}</td>
                                    <td><span className={`badge ${log.tipo_usuario === 'ADMIN' ? 'badge-danger' : 'badge-info'}`}>{log.tipo_usuario || 'AUTO'}</span></td>
                                    <td>{log.accion}</td>
                                    <td><span style={{ fontFamily: 'monospace', color: '#10b981' }}>{log.tabla_afectada}</span></td>
                                    <td style={{ fontFamily: 'monospace' }}>{log.ip_usuario}</td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                )}
            </div>
        </div>
    );
}
