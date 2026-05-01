import { useState, useEffect } from 'react';
import { getEconomicData, getSeries } from '../../services/api';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

export default function Dashboard() {
    const [data, setData] = useState([]);
    const [series, setSeries] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchData = async () => {
            try {
                const seriesRes = await getSeries();
                if (seriesRes.success) {
                    setSeries(seriesRes.data);
                }

                // Fetch data for the first available series or a default
                const defaultSerieId = seriesRes.data[0]?.id_serie || 1; 
                const dataRes = await getEconomicData({ serieId: defaultSerieId });
                
                if (dataRes.success) {
                    // Format data for Recharts (reverse to get chronological order)
                    const formattedData = dataRes.data.reverse().map(item => ({
                        periodo: item.etiqueta_periodo,
                        valor: Number(item.valor),
                        valor_sin_tendencia: Number(item.valor_sin_tendencia)
                    }));
                    setData(formattedData);
                }
            } catch (error) {
                console.error("Error fetching data:", error);
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, []);

    if (loading) return <div className="loading-spinner"><div className="spinner"></div></div>;

    return (
        <div className="dashboard-container">
            <h1 className="page-title">INEGI Dashboard</h1>
            <p className="page-subtitle">Producto Interno Bruto Trimestral de México</p>

            <div className="card">
                <div className="card-header">
                    <h2 className="card-title">Evolución del PIB</h2>
                </div>
                <div style={{ width: '100%', height: 400 }}>
                    <ResponsiveContainer>
                        <LineChart data={data} margin={{ top: 5, right: 30, left: 20, bottom: 5 }}>
                            <CartesianGrid strokeDasharray="3 3" stroke="#1e293b" />
                            <XAxis dataKey="periodo" stroke="#94a3b8" />
                            <YAxis stroke="#94a3b8" domain={['auto', 'auto']} />
                            <Tooltip 
                                contentStyle={{ backgroundColor: '#1a2332', borderColor: '#1e293b' }}
                                itemStyle={{ color: '#f1f5f9' }}
                            />
                            <Legend />
                            <Line type="monotone" dataKey="valor" name="Valor Real" stroke="#6366f1" strokeWidth={2} dot={false} />
                            <Line type="monotone" dataKey="valor_sin_tendencia" name="Valor Sin Tendencia" stroke="#10b981" strokeWidth={2} dot={false} />
                        </LineChart>
                    </ResponsiveContainer>
                </div>
            </div>
        </div>
    );
}
