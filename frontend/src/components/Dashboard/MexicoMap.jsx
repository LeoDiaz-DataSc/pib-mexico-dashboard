import React, { useState, useEffect, useRef } from 'react';
import { ComposableMap, Geographies, Geography } from 'react-simple-maps';
import { scaleQuantize } from 'd3-scale';
import gsap from 'gsap';
import { useGSAP } from '@gsap/react';

gsap.registerPlugin(useGSAP);

// TopoJSON/GeoJSON de México público
const geoUrl = "https://raw.githubusercontent.com/superjose/mx-geojson/master/mexicoHigh.json";

// Datos MOCK de aportación al PIB por estado (Para propósitos demostrativos)
// En producción, esto vendría del endpoint /api/economic-data?agrupado=estado
const pibData = [
  { id: "MX-CMX", name: "Ciudad de México", value: 15.3 },
  { id: "MX-MEX", name: "Estado de México", value: 9.1 },
  { id: "MX-NLE", name: "Nuevo León", value: 8.3 },
  { id: "MX-JAL", name: "Jalisco", value: 7.3 },
  { id: "MX-VER", name: "Veracruz", value: 4.5 },
  { id: "MX-GUA", name: "Guanajuato", value: 4.2 },
  { id: "MX-CHH", name: "Chihuahua", value: 3.8 },
  { id: "MX-COA", name: "Coahuila", value: 3.8 },
  { id: "MX-BCN", name: "Baja California", value: 3.7 },
  { id: "MX-SON", name: "Sonora", value: 3.6 },
  // Los demás estados tendrían valores menores
];

// Escala de colores azules-verdes
const colorScale = scaleQuantize()
  .domain([1, 16]) // Rango de 1% a 16% del PIB
  .range([
    "#0f172a", // Muy bajo
    "#1e293b",
    "#334155",
    "#475569",
    "#64748b",
    "#3b82f6", // Medio
    "#2563eb",
    "#1d4ed8",
    "#1e40af",
    "#1e3a8a"  // Muy alto (CDMX)
  ]);

export default function MexicoMap() {
  const [tooltipContent, setTooltipContent] = useState("");
  const container = useRef();

  useGSAP(() => {
    gsap.from('.map-container', { opacity: 0, scale: 0.9, duration: 0.8, ease: 'power2.out' });
  }, { scope: container });

  return (
    <div ref={container} className="dashboard-container">
      <div className="page-header">
        <h1 className="page-title">Mapa Coroplético: PIB por Entidad</h1>
        <p className="page-subtitle">Aportación porcentual al Producto Interno Bruto Nacional</p>
      </div>

      <div className="card map-container" style={{ padding: '20px', position: 'relative' }}>
        <div style={{ position: 'absolute', top: 20, right: 20, background: 'rgba(15, 23, 42, 0.8)', padding: '10px', borderRadius: '8px' }}>
          <h4 style={{ margin: 0, color: '#f8fafc' }}>Aportación %</h4>
          <div style={{ display: 'flex', alignItems: 'center', marginTop: 10 }}>
            <div style={{ width: 15, height: 15, background: '#1e3a8a', marginRight: 5 }}></div>
            <span style={{ color: '#94a3b8', fontSize: '0.8rem' }}>&gt; 10% (Muy Alto)</span>
          </div>
          <div style={{ display: 'flex', alignItems: 'center', marginTop: 5 }}>
            <div style={{ width: 15, height: 15, background: '#2563eb', marginRight: 5 }}></div>
            <span style={{ color: '#94a3b8', fontSize: '0.8rem' }}>5% - 10% (Medio)</span>
          </div>
          <div style={{ display: 'flex', alignItems: 'center', marginTop: 5 }}>
            <div style={{ width: 15, height: 15, background: '#1e293b', marginRight: 5 }}></div>
            <span style={{ color: '#94a3b8', fontSize: '0.8rem' }}>&lt; 5% (Bajo)</span>
          </div>
        </div>

        <ComposableMap
          projection="geoMercator"
          projectionConfig={{ scale: 1200, center: [-102, 24] }}
          width={800}
          height={600}
        >
          <Geographies geography={geoUrl}>
            {({ geographies }) =>
              geographies.map(geo => {
                const stateId = `MX-${geo.properties.state_code}`;
                const cur = pibData.find(s => s.id === stateId);
                return (
                  <Geography
                    key={geo.rsmKey}
                    geography={geo}
                    fill={cur ? colorScale(cur.value) : "#0f172a"}
                    stroke="#1e293b"
                    strokeWidth={0.5}
                    onMouseEnter={() => {
                      setTooltipContent(`${geo.properties.state_name}: ${cur ? cur.value + '%' : 'Datos no disp.'}`);
                    }}
                    onMouseLeave={() => {
                      setTooltipContent("");
                    }}
                    style={{
                      default: { outline: "none" },
                      hover: { fill: "#10b981", outline: "none", cursor: 'pointer' },
                      pressed: { outline: "none" }
                    }}
                  />
                );
              })
            }
          </Geographies>
        </ComposableMap>

        {tooltipContent && (
          <div style={{
            position: 'absolute',
            bottom: 20,
            left: 20,
            background: '#10b981',
            color: '#fff',
            padding: '10px 15px',
            borderRadius: '4px',
            fontWeight: 'bold',
            boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)'
          }}>
            {tooltipContent}
          </div>
        )}
      </div>
    </div>
  );
}
