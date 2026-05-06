import { useState, useEffect, useRef } from 'react';
import gsap from 'gsap';
import { useGSAP } from '@gsap/react';

gsap.registerPlugin(useGSAP);

export default function CronStatus() {
    const container = useRef();
    const [status, setStatus] = useState(null);

    useEffect(() => {
        fetch('http://localhost:3000/api/admin/cron-logs')
            .then(res => res.json())
            .then(data => {
                if (data.success && data.data.length > 0) {
                    const lastLog = data.data[0];
                    const details = lastLog.detalles || {};
                    setStatus({
                        active: true,
                        lastRun: new Date(lastLog.fecha_accion).toLocaleString(),
                        nextRun: new Date(new Date().setHours(2, 0, 0, 0) + 86400000).toLocaleString(),
                        recordsSynced: lastLog.registros_afectados,
                        memoryUsage: details.memory || 'N/A',
                        status: lastLog.accion
                    });
                } else {
                    // Fallback si no ha corrido nunca
                    setStatus({ active: false, lastRun: 'Nunca', nextRun: '02:00 AM', recordsSynced: 0, memoryUsage: '0 MB' });
                }
            })
            .catch(err => console.error("Error fetching cron logs:", err));
    }, []);

    useGSAP(() => {
        if (!status) return;
        const tl = gsap.timeline();
        tl.from('.cron-card', { opacity: 0, scale: 0.95, duration: 0.5 })
          .from('.stat-item', { opacity: 0, x: -20, stagger: 0.1, duration: 0.4 }, '-=0.2');
    }, { scope: container, dependencies: [status] });

    return (
        <div ref={container} className="dashboard-container">
            <div className="page-header">
                <h1 className="page-title">Estado del ETL (Scheduler)</h1>
                <p className="page-subtitle">Capa 1: Monitoreo de ingesta de datos automatizada</p>
            </div>

            {!status ? (
                <div className="loading-spinner"><div className="spinner"></div></div>
            ) : (
                <div className="card cron-card" style={{ maxWidth: '600px', margin: '0 auto' }}>
                    <div className="card-header" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <h3 className="card-title">node-cron Monitor</h3>
                        <span className="badge" style={{ background: '#10b981', color: 'white' }}>RUNNING</span>
                    </div>
                    <div className="card-body">
                        <ul style={{ listStyle: 'none', padding: 0, margin: 0 }}>
                            <li className="stat-item" style={{ padding: '15px 0', borderBottom: '1px solid #1e293b', display: 'flex', justifyContent: 'space-between' }}>
                                <span style={{ color: '#94a3b8' }}>Servicio de Sincronización</span>
                                <span style={{ fontWeight: 'bold', color: '#f1f5f9' }}>etl_inegi.js</span>
                            </li>
                            <li className="stat-item" style={{ padding: '15px 0', borderBottom: '1px solid #1e293b', display: 'flex', justifyContent: 'space-between' }}>
                                <span style={{ color: '#94a3b8' }}>Última Ejecución</span>
                                <span style={{ fontWeight: 'bold', color: '#3b82f6' }}>{status.lastRun}</span>
                            </li>
                            <li className="stat-item" style={{ padding: '15px 0', borderBottom: '1px solid #1e293b', display: 'flex', justifyContent: 'space-between' }}>
                                <span style={{ color: '#94a3b8' }}>Registros Sincronizados (BIE)</span>
                                <span style={{ fontWeight: 'bold', color: '#10b981' }}>+{status.recordsSynced} nuevos</span>
                            </li>
                            <li className="stat-item" style={{ padding: '15px 0', borderBottom: '1px solid #1e293b', display: 'flex', justifyContent: 'space-between' }}>
                                <span style={{ color: '#94a3b8' }}>Uso de Memoria</span>
                                <span style={{ fontWeight: 'bold', color: '#f59e0b' }}>{status.memoryUsage}</span>
                            </li>
                            <li className="stat-item" style={{ padding: '15px 0', display: 'flex', justifyContent: 'space-between' }}>
                                <span style={{ color: '#94a3b8' }}>Próxima Ejecución (02:00 AM)</span>
                                <span style={{ fontWeight: 'bold', color: '#e11d48' }}>{status.nextRun}</span>
                            </li>
                        </ul>
                    </div>
                </div>
            )}
        </div>
    );
}
