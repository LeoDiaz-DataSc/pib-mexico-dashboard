import { useState, useEffect, useRef } from 'react';
import gsap from 'gsap';
import { useGSAP } from '@gsap/react';
import { getSeries, getSectors } from '../../services/api';

gsap.registerPlugin(useGSAP);

export default function QueryBuilder() {
    const container = useRef();
    const [series, setSeries] = useState([]);
    const [sectors, setSectors] = useState([]);
    const [loading, setLoading] = useState(true);
    
    // Form state
    const [selectedSerie, setSelectedSerie] = useState('');
    const [selectedSector, setSelectedSector] = useState('');
    const [startYear, setStartYear] = useState('2018');
    const [endYear, setEndYear] = useState('2024');

    useEffect(() => {
        Promise.all([getSeries(), getSectors()])
            .then(([resSeries, resSectors]) => {
                if (resSeries.success) setSeries(resSeries.data);
                if (resSectors.success) setSectors(resSectors.data);
            })
            .catch(err => console.error("Error loading builder data:", err))
            .finally(() => setLoading(false));
    }, []);

    useGSAP(() => {
        if (loading) return;
        const tl = gsap.timeline();
        tl.from('.builder-title', { y: -20, opacity: 0, duration: 0.5 })
          .from('.builder-panel', { x: -20, opacity: 0, duration: 0.5 }, '-=0.2')
          .from('.form-group', { y: 10, opacity: 0, stagger: 0.1, duration: 0.4 }, '-=0.3');
    }, { scope: container, dependencies: [loading] });

    const handleExecute = (e) => {
        e.preventDefault();
        // Here we would typically trigger a fetch to the backend or pass to a parent component
        alert(`Ejecutando consulta para Serie: ${selectedSerie || 'Todas'}, Sector: ${selectedSector || 'Todos'}, Periodo: ${startYear} - ${endYear}`);
    };

    if (loading) return <div className="loading-spinner"><div className="spinner"></div></div>;

    return (
        <div ref={container} className="dashboard-container">
            <div className="page-header">
                <h1 className="page-title builder-title">Constructor Visual de Consultas</h1>
                <p className="page-subtitle">Exploración multidimensional de datos económicos</p>
            </div>

            <div className="card builder-panel" style={{ maxWidth: '800px' }}>
                <div className="card-header">
                    <h3 className="card-title">Parámetros de Búsqueda</h3>
                </div>
                <div className="card-body">
                    <form onSubmit={handleExecute} style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>
                        
                        <div className="form-group">
                            <label style={{ display: 'block', marginBottom: '8px', color: '#94a3b8' }}>Serie Económica</label>
                            <select 
                                value={selectedSerie} 
                                onChange={(e) => setSelectedSerie(e.target.value)}
                                style={{ width: '100%', padding: '10px', background: '#0f172a', border: '1px solid #334155', color: '#f8fafc', borderRadius: '4px' }}
                            >
                                <option value="">Todas las series</option>
                                {series.map(s => (
                                    <option key={s.id_serie} value={s.id_serie}>{s.codigo_serie} - {s.nombre}</option>
                                ))}
                            </select>
                        </div>

                        <div className="form-group">
                            <label style={{ display: 'block', marginBottom: '8px', color: '#94a3b8' }}>Sector Económico (SCIAN)</label>
                            <select 
                                value={selectedSector} 
                                onChange={(e) => setSelectedSector(e.target.value)}
                                style={{ width: '100%', padding: '10px', background: '#0f172a', border: '1px solid #334155', color: '#f8fafc', borderRadius: '4px' }}
                            >
                                <option value="">Todos los sectores</option>
                                {sectors.map(s => (
                                    <option key={s.id_sector} value={s.id_sector}>{s.codigo_sector} - {s.nombre}</option>
                                ))}
                            </select>
                        </div>

                        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '20px' }}>
                            <div className="form-group">
                                <label style={{ display: 'block', marginBottom: '8px', color: '#94a3b8' }}>Año Inicio</label>
                                <input 
                                    type="number" 
                                    value={startYear} 
                                    onChange={(e) => setStartYear(e.target.value)}
                                    style={{ width: '100%', padding: '10px', background: '#0f172a', border: '1px solid #334155', color: '#f8fafc', borderRadius: '4px' }}
                                />
                            </div>
                            <div className="form-group">
                                <label style={{ display: 'block', marginBottom: '8px', color: '#94a3b8' }}>Año Fin</label>
                                <input 
                                    type="number" 
                                    value={endYear} 
                                    onChange={(e) => setEndYear(e.target.value)}
                                    style={{ width: '100%', padding: '10px', background: '#0f172a', border: '1px solid #334155', color: '#f8fafc', borderRadius: '4px' }}
                                />
                            </div>
                        </div>

                        <div style={{ marginTop: '20px', display: 'flex', gap: '10px' }}>
                            <button type="submit" style={{ padding: '10px 20px', background: '#6366f1', color: '#fff', border: 'none', borderRadius: '4px', cursor: 'pointer', fontWeight: 'bold' }}>
                                Ejecutar Consulta
                            </button>
                            <button type="button" style={{ padding: '10px 20px', background: '#334155', color: '#f1f5f9', border: 'none', borderRadius: '4px', cursor: 'pointer' }}>
                                Guardar Consulta
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    );
}
