import React, { useState, useEffect, useRef } from 'react';
import PivotTableUI from 'react-pivottable/PivotTableUI';
import 'react-pivottable/pivottable.css';
import createPlotlyRenderers from 'react-pivottable/PlotlyRenderers';
import Plot from 'react-plotly.js';
import gsap from 'gsap';
import { useGSAP } from '@gsap/react';
import { getEconomicData } from '../../services/api';

gsap.registerPlugin(useGSAP);
const PlotlyRenderers = createPlotlyRenderers(Plot);

export default function PivotView() {
    const container = useRef();
    const [state, setState] = useState({});
    const [data, setData] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        // Obtenemos los datos multidimensionales
        getEconomicData({ startYear: '2020', endYear: '2024' })
            .then(res => {
                if (res.success) {
                    // Formatear datos para el pivot
                    const formatted = res.data.map(item => ({
                        Año: item.año,
                        Trimestre: item.trimestre,
                        Sector: item.subsector_nombre || 'No especificado',
                        Serie: item.serie_nombre,
                        Valor: Number(item.valor)
                    }));
                    setData(formatted);
                }
            })
            .catch(err => console.error(err))
            .finally(() => setLoading(false));
    }, []);

    useGSAP(() => {
        if (loading) return;
        gsap.from('.pivot-container', { opacity: 0, y: 30, duration: 0.8, ease: 'power3.out' });
    }, { scope: container, dependencies: [loading] });

    if (loading) return <div className="loading-spinner"><div className="spinner"></div></div>;

    return (
        <div ref={container} className="dashboard-container">
            <div className="page-header">
                <h1 className="page-title">Análisis Dinámico (Pivot Table)</h1>
                <p className="page-subtitle">Arrastra y suelta variables para cruzar dimensiones</p>
            </div>

            <div className="card pivot-container" style={{ padding: '20px', background: '#f8fafc', overflowX: 'auto' }}>
                <PivotTableUI
                    data={data}
                    onChange={s => setState(s)}
                    renderers={Object.assign({}, PlotlyRenderers)}
                    {...state}
                />
            </div>
        </div>
    );
}
