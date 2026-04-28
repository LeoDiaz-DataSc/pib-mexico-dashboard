USE pib_mexico_db;


-- Descomenta las siguientes líneas si necesitas limpiar datos existentes
DELETE FROM datos_economicos;
DELETE FROM usuarios;
DELETE FROM periodos_tiempo;
DELETE FROM subsectores;
DELETE FROM sectores_economicos;
DELETE FROM series_economicas;
DELETE FROM instituciones;

-- Resetear autoincrement
ALTER TABLE datos_economicos AUTO_INCREMENT = 1;
ALTER TABLE usuarios AUTO_INCREMENT = 1;
ALTER TABLE periodos_tiempo AUTO_INCREMENT = 1;
ALTER TABLE subsectores AUTO_INCREMENT = 1;
ALTER TABLE sectores_economicos AUTO_INCREMENT = 1;
ALTER TABLE series_economicas AUTO_INCREMENT = 1;
ALTER TABLE instituciones AUTO_INCREMENT = 1;


INSERT INTO instituciones (nombre, siglas, pais, fecha_creacion, descripcion) VALUES
('Instituto Nacional de Estadística y Geografía', 'INEGI', 'México', '1983-01-25', 'Órgano autónomo responsable de la producción de estadísticas nacionales'),
('Banco de México', 'Banxico', 'México', '1925-09-01', 'Banco central de México'),
('Secretaría de Hacienda y Crédito Público', 'SHCP', 'México', '1821-11-17', 'Dependencia responsable de las finanzas públicas'),
('Confederación de Cámaras Industriales', 'CONCAMIN', 'México', '1918-12-01', 'Organismo empresarial nacional'),
('Consejo Nacional de Evaluación de la Política de Desarrollo Social', 'CONEVAL', 'México', '2004-01-06', 'Órgano técnico que evalúa la política social'),
('Instituto Nacional de Ciencias y Tecnología del Mar', 'INCMAR', 'México', '2018-07-01', 'Instituto especializado en ciencias marinas'),
('Centro de Investigación y Docencia Económicas', 'CIDE', 'México', '1974-02-01', 'Institución de investigación en ciencias sociales'),
('Fundación de Investigaciones Económicas Latinoamericanas', 'FIEL', 'Argentina', '1974-01-01', 'Centro de investigación económica regional'),
('Organización para la Cooperación y el Desarrollo Económicos', 'OCDE', 'Francia', '1961-09-30', 'Organización internacional de políticas económicas'),
('Banco Interamericano de Desarrollo', 'BID', 'Estados Unidos', '1959-12-26', 'Banco multilateral de desarrollo'),
('Comisión Económica para América Latina', 'CEPAL', 'Chile', '1948-06-25', 'Organismo regional de Naciones Unidas'),
('Instituto Mexicano del Seguro Social', 'IMSS', 'México', '1943-01-19', 'Institución de seguridad social mexicana'),
('Comisión Federal de Electricidad', 'CFE', 'México', '1937-08-14', 'Empresa eléctrica nacional'),
('Petróleos Mexicanos', 'PEMEX', 'México', '1938-03-18', 'Empresa petrolera estatal'),
('Grupo Financiero Banorte', 'Banorte', 'México', '1899-01-01', 'Institución financiera mexicana'),
('Universidad Nacional Autónoma de México', 'UNAM', 'México', '1910-09-21', 'Máxima casa de estudios de México'),
('Instituto Tecnológico de Monterrey', 'ITESM', 'México', '1943-07-07', 'Universidad privada de investigación'),
('Comisión de Supervisión Bancaria', 'CSB', 'México', '1998-01-01', 'Organismo de supervisión financiera'),
('Superintendencia de Valores', 'SV', 'México', '1996-01-01', 'Regulador del mercado de valores'),
('Instituto Federal de Telecomunicaciones', 'IFT', 'México', '2013-09-11', 'Órgano regulador de telecomunicaciones'),
('Comisión Nacional Bancaria y de Valores', 'CNBV', 'México', '1998-07-01', 'Regulador del sistema financiero'),
('Secretaría de Economía', 'SE', 'México', '2012-12-18', 'Dependencia de política económica industrial'),
('Instituto Nacional de la Propiedad Industrial', 'IMPI', 'México', '1993-07-11', 'Protección de la propiedad intelectual'),
('Servicio de Administración Tributaria', 'SAT', 'México', '1998-07-01', 'Administración tributaria federal'),
('Banco Nacional de Comercio Exterior', 'Bancomext', 'México', '1989-12-06', 'Banco de desarrollo exportador'),
('Nacional Financiera', 'Nafinsa', 'México', '1934-08-20', 'Sociedad Nacional de Crédito'),
('Corporación Mexicana de Inversiones en Bolsa', 'Mexbourse', 'México', '1995-01-01', 'Bolsa de valores'),
('Fondo Mexicano del Petróleo', 'FMP', 'México', '2013-01-01', 'Fondo de inversión en energía'),
('Instituto Nacional de Estadística y Geografía Internacional', 'INEGI-I', 'México', '2019-01-01', 'Extensión internacional de INEGI'),
('Academia Mexicana de Ciencias', 'AMC', 'México', '1940-04-25', 'Sociedad científica nacional'),
('Consejo de Ciencia y Tecnología', 'CONACYT', 'México', '1990-06-28', 'Consejo nacional de investigación'),
('Centro de Investigación en Alimentación y Desarrollo', 'CIAD', 'México', '1988-01-01', 'Centro de investigación alimentaria'),
('Instituto de Investigaciones de la Universidad Nacional de México', 'IIS-UNAM', 'México', '1968-01-01', 'Instituto de investigación social'),
('Universidad Veracruzana', 'UV', 'México', '1944-09-22', 'Universidad pública estatal'),
('Instituto Tecnológico de Calidad', 'ITEC', 'México', '2020-01-01', 'Instituto de investigación tecnológica'),
('Centro de Estudios Económicos', 'CEE', 'México', '1985-01-01', 'Centro de investigación económica aplicada'),
('Fundación por la Economía', 'FPE', 'México', '2000-01-01', 'Fundación de análisis económico'),
('Instituto Latinoamericano de Estadística', 'ILAE', 'México', '1995-01-01', 'Instituto regional de estadística'),
('Organización Mundial del Comercio', 'OMC', 'Suiza', '1995-01-01', 'Organización internacional comercial'),
('Fondo Monetario Internacional', 'FMI', 'Estados Unidos', '1944-12-27', 'Organización financiera internacional'),
('Banco Mundial', 'BM', 'Estados Unidos', '1944-07-01', 'Institución de desarrollo internacional'),
('Comisión de Industriales de México', 'CIM', 'México', '1965-01-01', 'Organismo empresarial nacional'),
('Confederación de Cámaras de Comercio', 'CONCANACO', 'México', '1963-01-01', 'Cámara de comercio nacional'),
('Asociación Nacional de Bancos de México', 'ANBM', 'México', '1950-01-01', 'Asociación bancaria nacional'),
('Instituto Mexicano de la Construcción', 'IMC', 'México', '1970-01-01', 'Instituto sectorial de construcción'),
('Centro de Estudios en Finanzas', 'CEF', 'México', '1980-01-01', 'Centro de investigación financiera'),
('Fundación de Investigación Económica y Social', 'FIES', 'México', '1990-01-01', 'Fundación de investigación'),
('Instituto Nacional de Estudios Regionales', 'INER', 'México', '1985-01-01', 'Instituto de estudios territoriales'),
('Centro Mexicano de Estudios Económicos', 'CMEE', 'México', '1975-01-01', 'Centro de análisis económico'),
('Academia de Ciencias Económicas', 'ACE', 'México', '1960-01-01', 'Academia de ciencias económicas'),
('Instituto de Estudios Financieros', 'IEF', 'México', '1980-01-01', 'Instituto de investigación financiera'),
('Red de Investigación Económica', 'RIE', 'México', '1995-01-01', 'Red de investigación regional');


INSERT INTO series_economicas (codigo_serie, nombre, descripcion, unidad_medida, base_periodo, frecuencia) VALUES
('PIB_2018_BASE', 'Producto Interno Bruto Total', 'PIB total de México a precios de 2018', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_2013_BASE', 'Producto Interno Bruto Total Base 2013', 'PIB total con base 2013', 'Millones de pesos', '2013', 'TRIMESTRAL'),
('PIB_AGRICOLA', 'PIB Actividades Primarias', 'PIB del sector agrícola, ganadero, silvícola y pesquero', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_INDUSTRIA', 'PIB Actividades Secundarias', 'PIB del sector industrial', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_SERVICIOS', 'PIB Actividades Terciarias', 'PIB del sector de servicios', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_MINERO', 'PIB Sector Minero', 'PIB de la industria minera', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_CONSTRUCCION', 'PIB Sector Construcción', 'PIB de la industria de la construcción', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_MANUFACTURAS', 'PIB Industria Manufacturera', 'PIB de las industrias manufactureras', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_ALIMENTARIA', 'PIB Industria Alimentaria', 'PIB de la industria alimentaria', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_QUIMICA', 'PIB Industria Química', 'PIB de la industria química', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_AUTOMOTRIZ', 'PIB Industria Automotriz', 'PIB de la industria automotriz', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_TEXTIL', 'PIB Industria Textil', 'PIB de la industria textil', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_PAPEL', 'PIB Industria del Papel', 'PIB de la industria papelera', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_HIDROCARBUROS', 'PIB Hidrocarburos', 'PIB del sector de hidrocarburos', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_PETROLEO', 'PIB Petróleo', 'PIB de la industria petrolera', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_GAS', 'PIB Gas Natural', 'PIB de la industria del gas natural', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_ELECTRICIDAD', 'PIB Electricidad', 'PIB de la industria eléctrica', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_CONSTRUCCION_RESIDENCIAL', 'PIB Construcción Residencial', 'PIB de la construcción residencial', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_COMERCIO', 'PIB Comercio', 'PIB del sector comercial', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_TRANSPORTES', 'PIB Transportes', 'PIB del sector de transportes', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_SERVICIOS_FINANCIEROS', 'PIB Servicios Financieros', 'PIB del sector financiero', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_SEGUROS', 'PIB Seguros', 'PIB del sector de seguros', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_INMOBILIARIO', 'PIB Servicios Inmobiliarios', 'PIB del sector inmobiliario', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_SERVICIOS_PROFESIONALES', 'PIB Servicios Profesionales', 'PIB de servicios profesionales', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_GOBIERNO', 'PIB Servicios Gubernamentales', 'PIB del sector gubernamental', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_EDUCACION', 'PIB Educación', 'PIB del sector educativo', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_SALUD', 'PIB Servicios de Salud', 'PIB del sector salud', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_ENTRETENIMIENTO', 'PIB Entretenimiento', 'PIB del sector de entretenimiento', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_TURISMO', 'PIB Turismo', 'PIB del sector turístico', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_COMUNICACIONES', 'PIB Comunicaciones', 'PIB del sector de comunicaciones', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_RESTURANTES', 'PIB Restaurantes', 'PIB de restaurantes y hoteles', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_AGRICULTURA_CEREALES', 'PIB Agricultura - Cereales', 'PIB de producción de cereales', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_AGRICULTURA_FRUTAS', 'PIB Agricultura - Frutas', 'PIB de producción de frutas', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_GANADERIA', 'PIB Ganadería', 'PIB de la industria ganadera', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_ACUACULTURA', 'PIB Acuacultura', 'PIB de la acuacultura', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_PESCA', 'PIB Pesca', 'PIB de la industria pesquera', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_SILVICULTURA', 'PIB Silvicultura', 'PIB de la industria forestal', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_MINERIA_METAL', 'PIB Minería - Metales', 'PIB de la minería de metales', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_MINERIA_NO_METAL', 'PIB Minería - No Metales', 'PIB de la minería no metálica', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_ACERO', 'PIB Industria del Acero', 'PIB de la industria siderúrgica', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_CEMENTO', 'PIB Industria del Cemento', 'PIB de la industria cementera', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_VIDRIO', 'PIB Industria del Vidrio', 'PIB de la industria del vidrio', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_CAUCHO', 'PIB Industria del Caucho', 'PIB de la industria del caucho', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_PLASTICOS', 'PIB Industria Plásticos', 'PIB de la industria de plásticos', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_MAQUINARIA', 'PIB Maquinaria Industrial', 'PIB de la industria de maquinaria', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_ELECTRONICA', 'PIB Industria Electrónica', 'PIB de la industria electrónica', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_INSTRUMENTOS', 'PIB Instrumentos Médicos', 'PIB de instrumentos médicos', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_AERONAUTICA', 'PIB Industria Aeronáutica', 'PIB de la industria aeronáutica', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_BEVERAGE', 'PIB Industria de Bebidas', 'PIB de la industria de bebidas', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_TABACO', 'PIB Industria del Tabaco', 'PIB de la industria tabacalera', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_CARNE', 'PIB Industria Cárnica', 'PIB de la industria cárnica', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_LACTEOS', 'PIB Industria Láctea', 'PIB de la industria láctea', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_HARINA', 'PIB Industria de Harina', 'PIB de la industria harinera', 'Millones de pesos', '2018', 'TRIMESTRAL'),
('PIB_AZUCAR', 'PIB Industria Azucarera', 'PIB de la industria azucarera', 'Millones de pesos', '2018', 'TRIMESTRAL');


INSERT INTO sectores_economicos (codigo_sector, nombre, descripcion, nivel, activo) VALUES
('AGRICOLA', 'Agricultura', 'Sector de actividades agrícolas primarias', 'PRIMARIO', TRUE),
('GANADERIA', 'Ganadería', 'Sector ganadero de producción animal', 'PRIMARIO', TRUE),
('PESCA', 'Pesca', 'Sector pesquero marítimo y de agua dulce', 'PRIMARIO', TRUE),
('SILVICULTURA', 'Silvicultura', 'Sector forestal y de explotación de bosques', 'PRIMARIO', TRUE),
('ACUACULTURA', 'Acuacultura', 'Sector de cría de especies acuáticas', 'PRIMARIO', TRUE),
('MINERIA_METAL', 'Minería de Metales', 'Extracción de minerales metálicos', 'PRIMARIO', TRUE),
('MINERIA_NO_METAL', 'Minería No Metálica', 'Extracción de minerales no metálicos', 'PRIMARIO', TRUE),
('PETROLEO', 'Petróleo', 'Exploración y extracción de petróleo', 'PRIMARIO', TRUE),
('GAS_NATURAL', 'Gas Natural', 'Exploración y extracción de gas natural', 'PRIMARIO', TRUE),
('CARBON', 'Carbón', 'Minería de carbón', 'PRIMARIO', TRUE),
('ALIMENTARIA', 'Industria Alimentaria', 'Procesamiento de alimentos', 'SECUNDARIO', TRUE),
('BEBIDAS', 'Bebidas', 'Producción de bebidas', 'SECUNDARIO', TRUE),
('TABACO', 'Tabaco', 'Procesamiento de tabaco', 'SECUNDARIO', TRUE),
('TEXTIL', 'Textil', 'Industria textil y confección', 'SECUNDARIO', TRUE),
('VESTIMENTA', 'Vestimenta', 'Confección de prendas de vestir', 'SECUNDARIO', TRUE),
('CUERO', 'Cuero y Calzado', 'Industria del cuero y calzado', 'SECUNDARIO', TRUE),
('MADERA', 'Madera', 'Industria maderera', 'SECUNDARIO', TRUE),
('PAPEL', 'Papel', 'Industria papelera', 'SECUNDARIO', TRUE),
('IMPRESION', 'Impresión', 'Industria gráfica e impresión', 'SECUNDARIO', TRUE),
('PETROQUIMICA', 'Petroquímica', 'Industria petroquímica', 'SECUNDARIO', TRUE),
('QUIMICA', 'Química', 'Industria química básica', 'SECUNDARIO', TRUE),
('FARMACEUTICA', 'Farmacéutica', 'Industria farmacéutica', 'SECUNDARIO', TRUE),
('PLASTICOS', 'Plásticos', 'Industria de plásticos', 'SECUNDARIO', TRUE),
('CAUCHO', 'Caucho', 'Industria del caucho', 'SECUNDARIO', TRUE),
('VIDRIO', 'Vidrio', 'Industria del vidrio', 'SECUNDARIO', TRUE),
('CEMENTO', 'Cemento', 'Industria del cemento', 'SECUNDARIO', TRUE),
('CERAMICA', 'Cerámica', 'Industria cerámica', 'SECUNDARIO', TRUE),
('ACERO', 'Siderurgia', 'Industria siderúrgica', 'SECUNDARIO', TRUE),
('METALES_NO_FERROSOS', 'Metales No Ferrosos', 'Industria de metales no ferrosos', 'SECUNDARIO', TRUE),
('MAQUINARIA', 'Maquinaria', 'Fabricación de maquinaria', 'SECUNDARIO', TRUE),
('ELECTRICA', 'Eléctrica', 'Maquinaria eléctrica', 'SECUNDARIO', TRUE),
('ELECTRONICA', 'Electrónica', 'Industria electrónica', 'SECUNDARIO', TRUE),
('TELECOMUNICACIONES', 'Telecomunicaciones', 'Equipo de telecomunicaciones', 'SECUNDARIO', TRUE),
('AUTOMOTRIZ', 'Automotriz', 'Industria automotriz', 'SECUNDARIO', TRUE),
('AERONAUTICA', 'Aeronáutica', 'Industria aeronáutica', 'SECUNDARIO', TRUE),
('CONSTRUCCION', 'Construcción', 'Industria de la construcción', 'SECUNDARIO', TRUE),
('SERVICIOS_INMOBILIARIOS', 'Servicios Inmobiliarios', 'Servicios inmobiliarios', 'TERCIARIO', TRUE),
('COMERCIO', 'Comercio', 'Comercio al por mayor y menor', 'TERCIARIO', TRUE),
('TRANSPORTE', 'Transporte', 'Servicios de transporte', 'TERCIARIO', TRUE),
('ALMACENAMIENTO', 'Almacenamiento', 'Servicios de almacenamiento', 'TERCIARIO', TRUE),
('COMUNICACIONES', 'Comunicaciones', 'Servicios de comunicaciones', 'TERCIARIO', TRUE),
('FINANCIERO', 'Financiero', 'Servicios financieros', 'TERCIARIO', TRUE),
('SEGUROS', 'Seguros', 'Servicios de seguros', 'TERCIARIO', TRUE),
('INMOBILIARIO', 'Inmobiliario', 'Servicios inmobiliarios', 'TERCIARIO', TRUE),
('ARRENDAMIENTO', 'Arrendamiento', 'Servicios de arrendamiento', 'TERCIARIO', TRUE),
('PROFESIONAL', 'Profesional', 'Servicios profesionales', 'TERCIARIO', TRUE),
('TECNOLOGICO', 'Tecnológico', 'Servicios tecnológicos', 'TERCIARIO', TRUE),
('EDUCACION', 'Educación', 'Servicios educativos', 'TERCIARIO', TRUE),
('SALUD', 'Salud', 'Servicios de salud', 'TERCIARIO', TRUE),
('ENTRETENIMIENTO', 'Entretenimiento', 'Servicios de entretenimiento', 'TERCIARIO', TRUE),
('TURISMO', 'Turismo', 'Servicios turísticos', 'TERCIARIO', TRUE),
('GOBIERNO', 'Gobierno', 'Servicios gubernamentales', 'TERCIARIO', TRUE),
('DOMESTICO', 'Doméstico', 'Servicios domésticos', 'TERCIARIO', TRUE),
('OTROS_SERVICIOS', 'Otros Servicios', 'Otros servicios diversos', 'TERCIARIO', TRUE);


INSERT INTO subsectores (id_sector, codigo_subsector, nombre, descripcion, orden_presentacion, activo) VALUES
-- Subsectores de Agricultura (sector 1)
(1, 'AG_CEREALES', 'Cereales', 'Producción de maíz, trigo, cebada, sorgo', 1, TRUE),
(1, 'AG_HORTICULTURA', 'Horticultura', 'Producción de frutas y verduras', 2, TRUE),
(1, 'AG_FIBRA', 'Fibras', 'Producción de algodón y otras fibras', 3, TRUE),
(1, 'AG_ENERGIA', 'Cultivos Energéticos', 'Jatropha, canola para biocombustibles', 4, TRUE),
(1, 'AG_ORNAMENTAL', 'Ornamentales', 'Plantas y flores para ornamentación', 5, TRUE),

-- Subsectores de Ganadería (sector 2)
(2, 'GAN_BOVINO', 'Bovino', 'Ganado bovino', 1, TRUE),
(2, 'GAN_PORCINO', 'Porcino', 'Ganado porcino', 2, TRUE),
(2, 'GAN_OVINO', 'Ovino', 'Ganado ovino', 3, TRUE),
(2, 'GAN_CAPRINO', 'Caprino', 'Ganado caprino', 4, TRUE),
(2, 'GAN_AVICOLA', 'Avícola', 'Aves de corral', 5, TRUE),
(2, 'GAN_APICOLA', 'Apícola', 'Abejas y productos apícolas', 6, TRUE),
(2, 'GAN_ACUICULTURA', 'Acuícola', 'Piscicultura y crustáceos', 7, TRUE),

-- Subsectores de Pesca (sector 3)
(3, 'PES_MARITIMA', 'Pesca Marítima', 'Pesca en aguas marinas', 1, TRUE),
(3, 'PES_FLUVIAL', 'Pesca Fluvial', 'Pesca en ríos y lagos', 2, TRUE),
(3, 'PES_DEPORTIVA', 'Pesca Deportiva', 'Pesca deportiva y recreativa', 3, TRUE),
(3, 'PES_COMERCIAL', 'Pesca Comercial', 'Pesca comercial', 4, TRUE),

-- Subsectores de Silvicultura (sector 4)
(4, 'SILV_MADERA', 'Explotación Maderera', 'Extracción de madera', 1, TRUE),
(4, 'SILV_NO_MADERA', 'Productos No Maderables', 'Resinas, gomas, medicamentos', 2, TRUE),
(4, 'SILV_REFORESTACION', 'Reforestación', 'Plantación de bosques', 3, TRUE),

-- Subsectores de Minería de Metales (sector 6)
(6, 'MIN_HIERRO', 'Hierro', 'Extracción de mineral de hierro', 1, TRUE),
(6, 'MIN_COBRE', 'Cobre', 'Extracción de cobre', 2, TRUE),
(6, 'MIN_PLAGIO', 'Plagio', 'Extracción de plomo', 3, TRUE),
(6, 'MIN_ZINC', 'Zinc', 'Extracción de zinc', 4, TRUE),
(6, 'MIN_PRECiosos', 'Metales Preciosos', 'Oro, plata, platino', 5, TRUE),

-- Subsectores de Minería No Metálica (sector 7)
(7, 'MIN_SAL', 'Sal', 'Extracción de sal marina y de mina', 1, TRUE),
(7, 'MIN_CALIZA', 'Caliza', 'Extracción de caliza', 2, TRUE),
(7, 'MIN_ARENA', 'Arena y Grava', 'Extracción de arena y grava', 3, TRUE),
(7, 'MIN_YESO', 'Yeso', 'Extracción de yeso', 4, TRUE),
(7, 'MIN_BARITA', 'Barita', 'Extracción de barita', 5, TRUE),

-- Subsectores de Petróleo (sector 8)
(8, 'PET_EXTRACCION', 'Extracción de Petróleo', 'Pozos petroleros', 1, TRUE),
(8, 'PET_REFINO', 'Refinación', 'Refinerías de petróleo', 2, TRUE),
(8, 'PET_PETroquimica', 'Petroquímica Básica', 'Productos petroquímicos', 3, TRUE),
(8, 'PET_PETroquimica_SEC', 'Petroquímica Secundaria', 'Productos petroquímicos secundarios', 4, TRUE),

-- Subsectores de Gas Natural (sector 9)
(9, 'GAS_EXTRACCION', 'Extracción de Gas', 'Pozos de gas natural', 1, TRUE),
(9, 'GAS_TRANSPORTE', 'Transporte de Gas', 'Ductos y distribución', 2, TRUE),
(9, 'GAS_DISTRIBUCION', 'Distribución de Gas', 'Redes de distribución', 3, TRUE),
(9, 'GAS_LICUADO', 'Gas Licuado', 'Producción de gas licuado', 4, TRUE),

-- Subsectores de Industria Alimentaria (sector 11)
(11, 'AL_CARNES', 'Carnes', 'Procesamiento de carnes', 1, TRUE),
(11, 'AL_LACTEOS', 'Lácteos', 'Productos lácteos', 2, TRUE),
(11, 'AL_CONSERVAS', 'Conservas', 'Enlatados y conservas', 3, TRUE),
(11, 'AL_BEBIDAS_ALC', 'Bebidas Alcohólicas', 'Cerveza, vino, licores', 4, TRUE),
(11, 'AL_BEBIDAS_NO_ALC', 'Bebidas No Alcohólicas', 'Refrescos, jugos', 5, TRUE),
(11, 'AL_PANADERIA', 'Panadería y Confitería', 'Pan, pasteles, dulces', 6, TRUE),
(11, 'AL_ALMIDON', 'Almidón y Feculas', 'Producción de almidones', 7, TRUE),
(11, 'AL_MOLINOS', 'Molinos de Granos', 'Molienda de granos', 8, TRUE),

-- Subsectores de Industria Química (sector 16)
(16, 'QUI_BASICA', 'Química Básica', 'Químicos básicos', 1, TRUE),
(16, 'QUI_FERTILIZANTES', 'Fertilizantes', 'Producción de fertilizantes', 2, TRUE),
(16, 'QUI_PESTICIDAS', 'Pesticidas', 'Producción de pesticidas', 3, TRUE),
(16, 'QUI_ADITIVOS', 'Aditivos', 'Aditivos químicos', 4, TRUE),
(16, 'QUI_CATALIZADORES', 'Catalizadores', 'Catalizadores industriales', 5, TRUE),

-- Subsectores de Industria Automotriz (sector 34)
(34, 'AUT_MOTOS', 'Motocicletas', 'Producción de motocicletas', 1, TRUE),
(34, 'AUT_CAMIONES', 'Camiones', 'Producción de camiones', 2, TRUE),
(34, 'AUT_AUTOBUSES', 'Autobuses', 'Producción de autobuses', 3, TRUE),
(34, 'AUT_PARTES', 'Partes y Accesorios', 'Partes automotrices', 4, TRUE),
(34, 'AUT_MOTORES', 'Motores', 'Motores de combustión', 5, TRUE),
(34, 'AUT_TRASMISION', 'Transmisiones', 'Cajas de transmisión', 6, TRUE),
(34, 'AUT_ELECTRICOS', 'Componentes Eléctricos', 'Sistema eléctrico automotriz', 7, TRUE),

-- Subsectores de Servicios Financieros (sector 41)
(41, 'FIN_BANCOS', 'Bancos', 'Servicios bancarios', 1, TRUE),
(41, 'FIN_BURSATIL', 'Bursátil', 'Servicios de bolsa', 2, TRUE),
(41, 'FIN_CAMBIOS', 'Casas de Cambio', 'Intercambio de divisas', 3, TRUE),
(41, 'FIN_TARJETAS', 'Tarjetas de Crédito', 'Servicios de tarjetas', 4, TRUE),
(41, 'FIN_FACTORING', 'Factoraje', 'Servicios de factoraje', 5, TRUE),
(41, 'FIN_LEASING', 'Arrendamiento Financiero', 'Leasing financiero', 6, TRUE),
(41, 'FIN_MICROFINANZAS', 'Microfinanzas', 'Microfinanzas', 7, TRUE),

-- Subsectores de Transporte (sector 38)
(38, 'TRA_TERRESTRE', 'Transporte Terrestre', 'Autobuses, trenes, camiones', 1, TRUE),
(38, 'TRA_AEREO', 'Transporte Aéreo', 'Aviación comercial', 2, TRUE),
(38, 'TRA_MARITIMO', 'Transporte Marítimo', 'Transporte marítimo', 3, TRUE),
(38, 'TRA_LOGISTICA', 'Logística', 'Servicios logísticos', 4, TRUE),
(38, 'TRA_COURIER', 'Courier', 'Mensajería y paquetería', 5, TRUE),
(38, 'TRA_ESPECIALIZADO', 'Transporte Especializado', 'Transporte especializado', 6, TRUE),

-- Subsectores de Comercio (sector 37)
(37, 'COM_MAYORISTA', 'Comercio Mayorista', 'Venta al por mayor', 1, TRUE),
(37, 'COM_MINORISTA', 'Comercio Minorista', 'Venta al por menor', 2, TRUE),
(37, 'COM_ONLINE', 'Comercio Electrónico', 'Ventas en línea', 3, TRUE),
(37, 'COM_HIPERMERCADOS', 'Hipermercados', 'Hipermercados y supermercados', 4, TRUE),
(37, 'COM_AUTOMOTRIZ', 'Comercio Automotriz', 'Venta de vehículos', 5, TRUE),
(37, 'COM_FARMACEUTICO', 'Comercio Farmacéutico', 'Farmacias y droguerías', 6, TRUE),
(37, 'COM_TEXTIL', 'Comercio Textil', 'Ropa y accesorios', 7, TRUE);


INSERT INTO periodos_tiempo (año, trimestre, semestre, fecha_inicio, fecha_fin, etiqueta_periodo) VALUES
-- 2025 (4 trimestres)
(2025, 1, 1, '2025-01-01', '2025-03-31', '2025-T1'),
(2025, 2, 1, '2025-04-01', '2025-06-30', '2025-T2'),
(2025, 3, 2, '2025-07-01', '2025-09-30', '2025-T3'),
(2025, 4, 2, '2025-10-01', '2025-12-31', '2025-T4'),
-- 2024 (4 trimestres)
(2024, 1, 1, '2024-01-01', '2024-03-31', '2024-T1'),
(2024, 2, 1, '2024-04-01', '2024-06-30', '2024-T2'),
(2024, 3, 2, '2024-07-01', '2024-09-30', '2024-T3'),
(2024, 4, 2, '2024-10-01', '2024-12-31', '2024-T4'),
-- 2023 (4 trimestres)
(2023, 1, 1, '2023-01-01', '2023-03-31', '2023-T1'),
(2023, 2, 1, '2023-04-01', '2023-06-30', '2023-T2'),
(2023, 3, 2, '2023-07-01', '2023-09-30', '2023-T3'),
(2023, 4, 2, '2023-10-01', '2023-12-31', '2023-T4'),
-- 2022 (4 trimestres)
(2022, 1, 1, '2022-01-01', '2022-03-31', '2022-T1'),
(2022, 2, 1, '2022-04-01', '2022-06-30', '2022-T2'),
(2022, 3, 2, '2022-07-01', '2022-09-30', '2022-T3'),
(2022, 4, 2, '2022-10-01', '2022-12-31', '2022-T4'),
-- 2021 (4 trimestres)
(2021, 1, 1, '2021-01-01', '2021-03-31', '2021-T1'),
(2021, 2, 1, '2021-04-01', '2021-06-30', '2021-T2'),
(2021, 3, 2, '2021-07-01', '2021-09-30', '2021-T3'),
(2021, 4, 2, '2021-10-01', '2021-12-31', '2021-T4'),
-- 2020 (4 trimestres)
(2020, 1, 1, '2020-01-01', '2020-03-31', '2020-T1'),
(2020, 2, 1, '2020-04-01', '2020-06-30', '2020-T2'),
(2020, 3, 2, '2020-07-01', '2020-09-30', '2020-T3'),
(2020, 4, 2, '2020-10-01', '2020-12-31', '2020-T4'),
-- 2019 (4 trimestres)
(2019, 1, 1, '2019-01-01', '2019-03-31', '2019-T1'),
(2019, 2, 1, '2019-04-01', '2019-06-30', '2019-T2'),
(2019, 3, 2, '2019-07-01', '2019-09-30', '2019-T3'),
(2019, 4, 2, '2019-10-01', '2019-12-31', '2019-T4'),
-- 2018 (4 trimestres)
(2018, 1, 1, '2018-01-01', '2018-03-31', '2018-T1'),
(2018, 2, 1, '2018-04-01', '2018-06-30', '2018-T2'),
(2018, 3, 2, '2018-07-01', '2018-09-30', '2018-T3'),
(2018, 4, 2, '2018-10-01', '2018-12-31', '2018-T4'),
-- 2017 (4 trimestres)
(2017, 1, 1, '2017-01-01', '2017-03-31', '2017-T1'),
(2017, 2, 1, '2017-04-01', '2017-06-30', '2017-T2'),
(2017, 3, 2, '2017-07-01', '2017-09-30', '2017-T3'),
(2017, 4, 2, '2017-10-01', '2017-12-31', '2017-T4'),
-- 2016 (4 trimestres)
(2016, 1, 1, '2016-01-01', '2016-03-31', '2016-T1'),
(2016, 2, 1, '2016-04-01', '2016-06-30', '2016-T2'),
(2016, 3, 2, '2016-07-01', '2016-09-30', '2016-T3'),
(2016, 4, 2, '2016-10-01', '2016-12-31', '2016-T4'),
-- 2015 (4 trimestres)
(2015, 1, 1, '2015-01-01', '2015-03-31', '2015-T1'),
(2015, 2, 1, '2015-04-01', '2015-06-30', '2015-T2'),
(2015, 3, 2, '2015-07-01', '2015-09-30', '2015-T3'),
(2015, 4, 2, '2015-10-01', '2015-12-31', '2015-T4'),
-- 2014 (4 trimestres)
(2014, 1, 1, '2014-01-01', '2014-03-31', '2014-T1'),
(2014, 2, 1, '2014-04-01', '2014-06-30', '2014-T2'),
(2014, 3, 2, '2014-07-01', '2014-09-30', '2014-T3'),
(2014, 4, 2, '2014-10-01', '2014-12-31', '2014-T4'),
-- 2013 (4 trimestres)
(2013, 1, 1, '2013-01-01', '2013-03-31', '2013-T1'),
(2013, 2, 1, '2013-04-01', '2013-06-30', '2013-T2'),
(2013, 3, 2, '2013-07-01', '2013-09-30', '2013-T3'),
(2013, 4, 2, '2013-10-01', '2013-12-31', '2013-T4'),
-- 2012 (4 trimestres)
(2012, 1, 1, '2012-01-01', '2012-03-31', '2012-T1'),
(2012, 2, 1, '2012-04-01', '2012-06-30', '2012-T2'),
(2012, 3, 2, '2012-07-01', '2012-09-30', '2012-T3'),
(2012, 4, 2, '2012-10-01', '2012-12-31', '2012-T4'),
-- 2011 (4 trimestres)
(2011, 1, 1, '2011-01-01', '2011-03-31', '2011-T1'),
(2011, 2, 1, '2011-04-01', '2011-06-30', '2011-T2'),
(2011, 3, 2, '2011-07-01', '2011-09-30', '2011-T3'),
(2011, 4, 2, '2011-10-01', '2011-12-31', '2011-T4'),
-- 2010 (4 trimestres)
(2010, 1, 1, '2010-01-01', '2010-03-31', '2010-T1'),
(2010, 2, 1, '2010-04-01', '2010-06-30', '2010-T2'),
(2010, 3, 2, '2010-07-01', '2010-09-30', '2010-T3'),
(2010, 4, 2, '2010-10-01', '2010-12-31', '2010-T4'),
-- 2009 (4 trimestres)
(2009, 1, 1, '2009-01-01', '2009-03-31', '2009-T1'),
(2009, 2, 1, '2009-04-01', '2009-06-30', '2009-T2'),
(2009, 3, 2, '2009-07-01', '2009-09-30', '2009-T3'),
(2009, 4, 2, '2009-10-01', '2009-12-31', '2009-T4'),
-- 2008 (4 trimestres)
(2008, 1, 1, '2008-01-01', '2008-03-31', '2008-T1'),
(2008, 2, 1, '2008-04-01', '2008-06-30', '2008-T2'),
(2008, 3, 2, '2008-07-01', '2008-09-30', '2008-T3'),
(2008, 4, 2, '2008-10-01', '2008-12-31', '2008-T4'),
-- 2007 (4 trimestres)
(2007, 1, 1, '2007-01-01', '2007-03-31', '2007-T1'),
(2007, 2, 1, '2007-04-01', '2007-06-30', '2007-T2'),
(2007, 3, 2, '2007-07-01', '2007-09-30', '2007-T3'),
(2007, 4, 2, '2007-10-01', '2007-12-31', '2007-T4'),
-- 2006 (4 trimestres)
(2006, 1, 1, '2006-01-01', '2006-03-31', '2006-T1'),
(2006, 2, 1, '2006-04-01', '2006-06-30', '2006-T2'),
(2006, 3, 2, '2006-07-01', '2006-09-30', '2006-T3'),
(2006, 4, 2, '2006-10-01', '2006-12-31', '2006-T4'),
-- 2005 (4 trimestres)
(2005, 1, 1, '2005-01-01', '2005-03-31', '2005-T1'),
(2005, 2, 1, '2005-04-01', '2005-06-30', '2005-T2'),
(2005, 3, 2, '2005-07-01', '2005-09-30', '2005-T3'),
(2005, 4, 2, '2005-10-01', '2005-12-31', '2005-T4'),
-- 2004 (4 trimestres)
(2004, 1, 1, '2004-01-01', '2004-03-31', '2004-T1'),
(2004, 2, 1, '2004-04-01', '2004-06-30', '2004-T2'),
(2004, 3, 2, '2004-07-01', '2004-09-30', '2004-T3'),
(2004, 4, 2, '2004-10-01', '2004-12-31', '2004-T4'),
-- 2003 (4 trimestres)
(2003, 1, 1, '2003-01-01', '2003-03-31', '2003-T1'),
(2003, 2, 1, '2003-04-01', '2003-06-30', '2003-T2'),
(2003, 3, 2, '2003-07-01', '2003-09-30', '2003-T3'),
(2003, 4, 2, '2003-10-01', '2003-12-31', '2003-T4'),
-- 2002 (4 trimestres)
(2002, 1, 1, '2002-01-01', '2002-03-31', '2002-T1'),
(2002, 2, 1, '2002-04-01', '2002-06-30', '2002-T2'),
(2002, 3, 2, '2002-07-01', '2002-09-30', '2002-T3'),
(2002, 4, 2, '2002-10-01', '2002-12-31', '2002-T4'),
-- 2001 (4 trimestres)
(2001, 1, 1, '2001-01-01', '2001-03-31', '2001-T1'),
(2001, 2, 1, '2001-04-01', '2001-06-30', '2001-T2'),
(2001, 3, 2, '2001-07-01', '2001-09-30', '2001-T3'),
(2001, 4, 2, '2001-10-01', '2001-12-31', '2001-T4'),
-- 2000 (4 trimestres)
(2000, 1, 1, '2000-01-01', '2000-03-31', '2000-T1'),
(2000, 2, 1, '2000-04-01', '2000-06-30', '2000-T2'),
(2000, 3, 2, '2000-07-01', '2000-09-30', '2000-T3'),
(2000, 4, 2, '2000-10-01', '2000-12-31', '2000-T4'),
-- 1999 (4 trimestres)
(1999, 1, 1, '1999-01-01', '1999-03-31', '1999-T1'),
(1999, 2, 1, '1999-04-01', '1999-06-30', '1999-T2'),
(1999, 3, 2, '1999-07-01', '1999-09-30', '1999-T3'),
(1999, 4, 2, '1999-10-01', '1999-12-31', '1999-T4'),
-- 1998 (4 trimestres)
(1998, 1, 1, '1998-01-01', '1998-03-31', '1998-T1'),
(1998, 2, 1, '1998-04-01', '1998-06-30', '1998-T2'),
(1998, 3, 2, '1998-07-01', '1998-09-30', '1998-T3'),
(1998, 4, 2, '1998-10-01', '1998-12-31', '1998-T4'),
-- 1997 (4 trimestres)
(1997, 1, 1, '1997-01-01', '1997-03-31', '1997-T1'),
(1997, 2, 1, '1997-04-01', '1997-06-30', '1997-T2'),
(1997, 3, 2, '1997-07-01', '1997-09-30', '1997-T3'),
(1997, 4, 2, '1997-10-01', '1997-12-31', '1997-T4'),
-- 1996 (4 trimestres)
(1996, 1, 1, '1996-01-01', '1996-03-31', '1996-T1'),
(1996, 2, 1, '1996-04-01', '1996-06-30', '1996-T2'),
(1996, 3, 2, '1996-07-01', '1996-09-30', '1996-T3'),
(1996, 4, 2, '1996-10-01', '1996-12-31', '1996-T4'),
-- 1995 (4 trimestres)
(1995, 1, 1, '1995-01-01', '1995-03-31', '1995-T1'),
(1995, 2, 1, '1995-04-01', '1995-06-30', '1995-T2'),
(1995, 3, 2, '1995-07-01', '1995-09-30', '1995-T3'),
(1995, 4, 2, '1995-10-01', '1995-12-31', '1995-T4'),
-- 1994 (4 trimestres)
(1994, 1, 1, '1994-01-01', '1994-03-31', '1994-T1'),
(1994, 2, 1, '1994-04-01', '1994-06-30', '1994-T2'),
(1994, 3, 2, '1994-07-01', '1994-09-30', '1994-T3'),
(1994, 4, 2, '1994-10-01', '1994-12-31', '1994-T4'),
-- 1993 (4 trimestres)
(1993, 1, 1, '1993-01-01', '1993-03-31', '1993-T1'),
(1993, 2, 1, '1993-04-01', '1993-06-30', '1993-T2'),
(1993, 3, 2, '1993-07-01', '1993-09-30', '1993-T3'),
(1993, 4, 2, '1993-10-01', '1993-12-31', '1993-T4');


INSERT INTO usuarios (nombre_usuario, email, contraseña_hash, nombre_completo, institucion, tipo_usuario) VALUES
('admin_inegi', 'admin@inegi.gob.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrador INEGI', 'Instituto Nacional de Estadística y Geografía', 'ADMIN'),
('analista1', 'maria.garcia@banxico.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'María García López', 'Banco de México', 'ANALISTA'),
('economista1', 'carlos.rodriguez@shcp.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Carlos Rodríguez Martínez', 'SHCP', 'ANALISTA'),
('investigador1', 'ana.lopez@coneal.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Ana López Hernández', 'CONEVAL', 'ANALISTA'),
('consultor1', 'jose.martinez@banorte.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'José Martínez Silva', 'Grupo Financiero Banorte', 'LECTOR'),
('profesor1', 'lucia.hernandez@unam.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Lucía Hernández Pérez', 'UNAM', 'LECTOR'),
('estudiante1', 'diego.ramirez@itesm.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Diego Ramírez Flores', 'ITESM', 'LECTOR'),
('consultor2', 'patricia.morales@cif.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Patricia Morales Torres', 'Centro de Investigación en Finanzas', 'LECTOR'),
('investigador2', 'ricardo.jimenez@cide.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Ricardo Jiménez Cruz', 'CIDE', 'ANALISTA'),
('economista2', 'sandra.ruiz@fiel.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Sandra Ruiz Díaz', 'FIEL', 'ANALISTA'),
('analista2', 'miguel.santos@ocde.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Miguel Santos Vargas', 'OCDE', 'LECTOR'),
('consultor3', 'elena.castro@imss.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Elena Castro Moreno', 'IMSS', 'LECTOR'),
('investigador3', 'alberto.mendoza@cfe.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Alberto Mendoza Ortiz', 'CFE', 'LECTOR'),
('economista3', 'valeria.munoz@pemex.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Valeria Muñoz Ríos', 'PEMEX', 'ANALISTA'),
('analista3', 'francisco.vega@cnby.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Francisco Vega Romero', 'CNBV', 'ANALISTA'),
('profesor2', 'gabriela.lara@uv.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Gabriela Lara Paz', 'Universidad Veracruzana', 'LECTOR'),
('consultor4', 'adrian.cortes@amc.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Adrián Cortés González', 'Academia Mexicana de Ciencias', 'LECTOR'),
('investigador4', 'beatriz.salinas@conacyt.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Beatriz Salinas Delgado', 'CONACYT', 'ANALISTA'),
('economista4', 'rafael.dominguez@cie.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Rafael Domínguez Herrera', 'Centro de Investigación en Energía', 'LECTOR'),
('analista4', 'lilian.vazquez@imc.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Lilian Vázquez Pérez', 'Instituto Mexicano de la Construcción', 'LECTOR'),
('profesor3', 'alejandro.torres@uam.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Alejandro Torres Ramos', 'UAM', 'LECTOR'),
('consultor5', 'carolina.moreno@banca.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Carolina Moreno Estrada', 'Asociación Nacional de Bancos', 'LECTOR'),
('investigador5', 'rodrigo.aguilar@ims.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Rodrigo Aguilar Martínez', 'Instituto Mexicano de los Seguros', 'LECTOR'),
('economista5', 'paola.ruvalcaba@finanzas.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Paola Ruvalcaba Castro', 'Finanzas Públicas', 'LECTOR'),
('analista5', 'oscar.medina@comercio.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Oscar Medina Blanco', 'Secretaría de Comercio', 'LECTOR'),
('profesor4', 'denise.martinez@politecnico.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Denise Martínez Fernández', 'IPN', 'LECTOR'),
('consultor6', 'ignacio.ramirez@industria.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Ignacio Ramírez León', 'Cámara de la Industria', 'LECTOR'),
('investigador6', 'marina.espinosa@biomedica.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Marina Espinosa Torres', 'Instituto Biomédico', 'LECTOR'),
('economista6', 'german.rodriguez@industrial.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Germán Rodríguez Vásquez', 'Fundación Industrial', 'LECTOR'),
('analista6', 'diana.murillo@logistica.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Diana Murillo Aguilar', 'Asociación Logística', 'LECTOR'),
('profesor5', 'mauricio.garcia@udlap.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Mauricio García Molina', 'UDLAP', 'LECTOR'),
('consultor7', 'andrea.estrada@agropecuario.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Andrea Estrada Moreno', 'Sector Agropecuario', 'LECTOR'),
('investigador7', 'hector.salazar@ambiental.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Héctor Salazar Jiménez', 'Instituto Ambiental', 'LECTOR'),
('economista7', 'patricia.lopez@turismo.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Patricia López Sánchez', 'Secretaría de Turismo', 'LECTOR'),
('analista7', 'renato.cortes@energia.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Renato Cortés Delgado', 'Secretaría de Energía', 'LECTOR'),
('profesor6', 'olga.perez@colmex.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Olga Pérez Hernández', 'El Colegio de México', 'LECTOR'),
('consultor8', 'carlos.morales@consultoria.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Carlos Morales Torres', 'Consultoría Económica', 'LECTOR'),
('investigador8', 'liliana.hernandez@finanzas.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Liliana Hernández Ruiz', 'Instituto de Finanzas', 'LECTOR'),
('economista8', 'alejandro.silva@seguridad.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Alejandro Silva Martínez', 'Instituto de Seguridad', 'LECTOR'),
('analista8', 'carmen.ramirez@desarrollo.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Carmen Ramírez López', 'Instituto de Desarrollo', 'LECTOR'),
('profesor7', 'rafael.castro@ciencias.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Rafael Castro Morales', 'Academia de Ciencias', 'LECTOR'),
('consultor9', 'claudia.diaz@empresarial.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Claudia Díaz Gutiérrez', 'Confederación Empresarial', 'LECTOR'),
('investigador9', 'juan.moreno@estudios.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Juan Moreno Vázquez', 'Centro de Estudios', 'LECTOR'),
('economista9', 'silvia.flores@innovacion.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Silvia Flores Ortega', 'Instituto de Innovación', 'LECTOR'),
('analista9', 'arturo.mendoza@tecnologia.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Arturo Mendoza Jiménez', 'Instituto de Tecnología', 'LECTOR'),
('profesor8', 'maria.rodriguez@educacion.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'María Rodríguez Sánchez', 'Educación Superior', 'LECTOR'),
('consultor10', 'roberto.martinez@analisis.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Roberto Martínez Delgado', 'Centro de Análisis', 'LECTOR'),
('investigador10', 'leticia.gutierrez@investigacion.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Leticia Gutiérrez Torres', 'Centro de Investigación', 'LECTOR'),
('economista10', 'jorge.silva@estrategia.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Jorge Silva Herrera', 'Consultoría Estratégica', 'LECTOR'),
('analista10', 'andrea.lopez@proyecciones.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Andrea López Pérez', 'Proyecciones Económicas', 'LECTOR'),
('profesor9', 'luis.morales@metodologia.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Luis Morales Hernández', 'Metodología Estadística', 'LECTOR'),
('consultor11', 'marisol.espinosa@calidad.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Marisol Espinosa Guerrero', 'Control de Calidad', 'LECTOR'),
('investigador11', 'fernando.ramirez@proceso.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Fernando Ramírez Cortés', 'Optimización de Procesos', 'LECTOR'),
('economista11', 'daniela.flores@benchmarking.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Daniela Flores Castro', 'Benchmarking', 'LECTOR'),
('analista11', 'guillermo.salazar@auditoria.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Guillermo Salazar Vega', 'Auditoría Económica', 'LECTOR'),
('profesor10', 'angelica.martinez@evaluacion.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Angélica Martínez Ruiz', 'Evaluación de Políticas', 'LECTOR'),
('consultor12', 'osvaldo.perez@estrategico.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Osvaldo Pérez Jiménez', 'Planificación Estratégica', 'LECTOR'),
('investigador12', 'dora.cruz@vision.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Dora Cruz Morales', 'Visión de Futuro', 'LECTOR'),
('economista12', 'ernesto.mendoza@prospectiva.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Ernesto Mendoza Torres', 'Estudios de Prospectiva', 'LECTOR'),
('analista12', 'isabel.ruiz@scenario.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Isabel Ruiz Delgado', 'Análisis de Escenarios', 'LECTOR');

SELECT 'INFORMACIÓN DE POBLACIÓN DE TABLAS' AS info;

SELECT 'Tabla: Instituciones' AS tabla, COUNT(*) AS total_registros FROM instituciones
UNION ALL
SELECT 'Tabla: Series Económicas', COUNT(*) FROM series_economicas
UNION ALL
SELECT 'Tabla: Sectores Económicos', COUNT(*) FROM sectores_economicos
UNION ALL
SELECT 'Tabla: Subsectores', COUNT(*) FROM subsectores
UNION ALL
SELECT 'Tabla: Períodos de Tiempo', COUNT(*) FROM periodos_tiempo
UNION ALL
SELECT 'Tabla: Usuarios', COUNT(*) FROM usuarios;


SELECT 'VERIFICACIÓN DE RELACIONES' AS info;

-- Verificar rangos de años
SELECT 
    'Período más antiguo' AS tipo,
    MIN(año) AS valor
FROM periodos_tiempo
UNION ALL
SELECT 
    'Período más reciente',
    MAX(año)
FROM periodos_tiempo;

SELECT 'POBLACIÓN COMPLETADA EXITOSAMENTE' AS mensaje;
