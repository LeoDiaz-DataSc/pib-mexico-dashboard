const express = require('express');
const router = express.Router();
const db = require('../config/database');
const pdfMakePrinter = require('pdfmake');

// Configuración de fuentes estándar para pdfmake (utilizando fuentes base de Node)
const fonts = {
    Roboto: {
        normal: 'Helvetica',
        bold: 'Helvetica-Bold',
        italics: 'Helvetica-Oblique',
        bolditalics: 'Helvetica-BoldOblique'
    }
};

const printer = new pdfMakePrinter(fonts);

/**
 * GET /api/report/pdf
 * Genera un reporte PDF inviolable Server-Side para cumplimiento ISO 27001.
 */
router.get('/pdf', async (req, res) => {
    try {
        // Obtenemos los datos aplicando el filtro de embargo
        const [rows] = await db.query(`
            SELECT 
                p.año, 
                p.trimestre, 
                s.codigo_serie,
                de.valor
            FROM datos_economicos de
            JOIN periodos_tiempo p ON de.id_periodo = p.id_periodo
            JOIN series_economicas s ON de.id_serie = s.id_serie
            WHERE (de.fecha_liberacion <= NOW() OR de.fecha_liberacion IS NULL)
            ORDER BY p.año DESC, p.trimestre DESC
            LIMIT 50
        `);

        // Estructurar la tabla para el PDF
        const tableBody = [
            // Cabeceras
            [{ text: 'Año', style: 'tableHeader' }, { text: 'Trimestre', style: 'tableHeader' }, { text: 'Serie Económica', style: 'tableHeader' }, { text: 'Valor Oficial', style: 'tableHeader' }]
        ];

        // Rellenar filas
        rows.forEach(row => {
            tableBody.push([
                row.año.toString(),
                row.trimestre.toString(),
                row.codigo_serie,
                `$${Number(row.valor).toLocaleString()}`
            ]);
        });

        const docDefinition = {
            info: {
                title: 'Reporte Oficial INEGI',
                author: 'Sistema Automatizado INEGI',
                subject: 'Reporte Económico',
                keywords: 'INEGI, PIB, Economía',
            },
            header: function(currentPage, pageCount) {
                return { text: `Reporte Generado Server-Side - ISO 27001 Compliance`, margin: [40, 20], fontSize: 8, color: 'gray' };
            },
            footer: function(currentPage, pageCount) {
                return { text: `Página ${currentPage} de ${pageCount}`, alignment: 'center', fontSize: 8, color: 'gray', margin: [0, 20] };
            },
            content: [
                { text: 'Instituto Nacional de Estadística y Geografía', style: 'header' },
                { text: 'Reporte Ejecutivo de Indicadores Económicos', style: 'subheader' },
                { text: `Fecha de Emisión (Servidor): ${new Date().toLocaleString()}`, margin: [0, 0, 0, 20] },
                { text: 'Declaración de Integridad: Este documento ha sido generado directamente desde la base de datos central. Las cifras mostradas ya han superado el periodo de embargo oficial.', style: 'quote' },
                {
                    style: 'tableExample',
                    table: {
                        headerRows: 1,
                        widths: ['*', 'auto', '*', '*'],
                        body: tableBody
                    },
                    layout: 'lightHorizontalLines'
                }
            ],
            styles: {
                header: { fontSize: 18, bold: true, margin: [0, 0, 0, 10], color: '#1e293b' },
                subheader: { fontSize: 14, bold: true, margin: [0, 10, 0, 5], color: '#334155' },
                quote: { italics: true, margin: [0, 10, 0, 20], color: '#64748b' },
                tableExample: { margin: [0, 5, 0, 15] },
                tableHeader: { bold: true, fontSize: 12, color: 'black', fillColor: '#f1f5f9' }
            },
            defaultStyle: {
                font: 'Roboto'
            }
        };

        const pdfDoc = printer.createPdfKitDocument(docDefinition);
        
        res.setHeader('Content-Type', 'application/pdf');
        res.setHeader('Content-Disposition', 'attachment; filename="Reporte_Oficial_INEGI.pdf"');
        
        pdfDoc.pipe(res);
        pdfDoc.end();

    } catch (error) {
        console.error('Error generando PDF en el servidor:', error.message);
        res.status(500).json({ error: 'Error interno generando reporte seguro' });
    }
});

module.exports = router;
