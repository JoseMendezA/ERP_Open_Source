--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-08-13 20:10:50

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3367 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 1417311)
-- Name: CRM_lead; Type: TABLE; Schema: public; Owner: Comfe_owner
--

CREATE TABLE public."CRM_lead" (
    id_lead integer NOT NULL,
    external_id character varying(100) NOT NULL,
    nombre character varying(100) NOT NULL,
    "compañia_nombre" character varying(100) NOT NULL,
    nombre_contacto character varying(100),
    email_lead character varying(50),
    posicion_trabajo character varying(50),
    telefono integer,
    direccion character varying(100),
    websita character varying(100),
    notas character varying(300)
);


ALTER TABLE public."CRM_lead" OWNER TO "Comfe_owner";

--
-- TOC entry 3368 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE "CRM_lead"; Type: COMMENT; Schema: public; Owner: Comfe_owner
--

COMMENT ON TABLE public."CRM_lead" IS 'Información de clientes potenciales que ha mostrado interés en un producto o servicio de la empresa. Los leads pueden ser personas que han interactuado con contenidos de marca, han reaccionado a acciones de marketing o han dejado sus datos de contacto.';


--
-- TOC entry 221 (class 1259 OID 1417310)
-- Name: CRM_lead_id_lead_seq; Type: SEQUENCE; Schema: public; Owner: Comfe_owner
--

CREATE SEQUENCE public."CRM_lead_id_lead_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."CRM_lead_id_lead_seq" OWNER TO "Comfe_owner";

--
-- TOC entry 3369 (class 0 OID 0)
-- Dependencies: 221
-- Name: CRM_lead_id_lead_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public."CRM_lead_id_lead_seq" OWNED BY public."CRM_lead".id_lead;


--
-- TOC entry 216 (class 1259 OID 1417218)
-- Name: cliente; Type: TABLE; Schema: public; Owner: Comfe_owner
--

CREATE TABLE public.cliente (
    id integer NOT NULL,
    "tipo_compañia" integer NOT NULL,
    "nombre_compañia" character varying(50) NOT NULL,
    pais character(20) NOT NULL,
    ciudad character varying(20) NOT NULL,
    direccion character varying(100) NOT NULL,
    telefono integer,
    email character varying(100),
    nit integer NOT NULL,
    cuenta_banco integer NOT NULL,
    banco character(1) NOT NULL
);


ALTER TABLE public.cliente OWNER TO "Comfe_owner";

--
-- TOC entry 3370 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE cliente; Type: COMMENT; Schema: public; Owner: Comfe_owner
--

COMMENT ON TABLE public.cliente IS 'Información para el manejo de clientes de la empresa';


--
-- TOC entry 215 (class 1259 OID 1417217)
-- Name: cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: Comfe_owner
--

CREATE SEQUENCE public.cliente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cliente_id_seq OWNER TO "Comfe_owner";

--
-- TOC entry 3371 (class 0 OID 0)
-- Dependencies: 215
-- Name: cliente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public.cliente_id_seq OWNED BY public.cliente.id;


--
-- TOC entry 220 (class 1259 OID 1417272)
-- Name: inventario; Type: TABLE; Schema: public; Owner: Comfe_owner
--

CREATE TABLE public.inventario (
    id_inventario integer NOT NULL,
    codigo character varying(150) NOT NULL,
    cantidad double precision NOT NULL,
    ubicacion character varying(200) NOT NULL
);


ALTER TABLE public.inventario OWNER TO "Comfe_owner";

--
-- TOC entry 219 (class 1259 OID 1417271)
-- Name: inventario_id_inventario_seq; Type: SEQUENCE; Schema: public; Owner: Comfe_owner
--

CREATE SEQUENCE public.inventario_id_inventario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inventario_id_inventario_seq OWNER TO "Comfe_owner";

--
-- TOC entry 3372 (class 0 OID 0)
-- Dependencies: 219
-- Name: inventario_id_inventario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public.inventario_id_inventario_seq OWNED BY public.inventario.id_inventario;


--
-- TOC entry 218 (class 1259 OID 1417234)
-- Name: producto; Type: TABLE; Schema: public; Owner: Comfe_owner
--

CREATE TABLE public.producto (
    id integer NOT NULL,
    referencia character varying(150) NOT NULL,
    unidad_medida character varying(150) NOT NULL,
    precio double precision NOT NULL,
    categoria integer NOT NULL,
    fabricar character(1) NOT NULL,
    codigo_barra integer NOT NULL,
    proveedor character varying(150) NOT NULL,
    codigo_proveedor integer NOT NULL,
    codigo_web character varying(150) NOT NULL
);


ALTER TABLE public.producto OWNER TO "Comfe_owner";

--
-- TOC entry 3373 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE producto; Type: COMMENT; Schema: public; Owner: Comfe_owner
--

COMMENT ON TABLE public.producto IS 'Tipos de productos que ofrece la empresa';


--
-- TOC entry 217 (class 1259 OID 1417233)
-- Name: producto_id_seq; Type: SEQUENCE; Schema: public; Owner: Comfe_owner
--

CREATE SEQUENCE public.producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.producto_id_seq OWNER TO "Comfe_owner";

--
-- TOC entry 3374 (class 0 OID 0)
-- Dependencies: 217
-- Name: producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public.producto_id_seq OWNED BY public.producto.id;


--
-- TOC entry 3198 (class 2604 OID 1417314)
-- Name: CRM_lead id_lead; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public."CRM_lead" ALTER COLUMN id_lead SET DEFAULT nextval('public."CRM_lead_id_lead_seq"'::regclass);


--
-- TOC entry 3195 (class 2604 OID 1417221)
-- Name: cliente id; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.cliente ALTER COLUMN id SET DEFAULT nextval('public.cliente_id_seq'::regclass);


--
-- TOC entry 3197 (class 2604 OID 1417275)
-- Name: inventario id_inventario; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.inventario ALTER COLUMN id_inventario SET DEFAULT nextval('public.inventario_id_inventario_seq'::regclass);


--
-- TOC entry 3196 (class 2604 OID 1417237)
-- Name: producto id; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.producto ALTER COLUMN id SET DEFAULT nextval('public.producto_id_seq'::regclass);


--
-- TOC entry 3361 (class 0 OID 1417311)
-- Dependencies: 222
-- Data for Name: CRM_lead; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public."CRM_lead" (id_lead, external_id, nombre, "compañia_nombre", nombre_contacto, email_lead, posicion_trabajo, telefono, direccion, websita, notas) FROM stdin;
1	EXT001	Juan Pérez	TechSolutions SA	María García	juan.perez@techsolutions.com	Gerente de Ventas	912345678	Calle Principal 123, Madrid	www.techsolutions.com	Interesado en software de gestión
2	EXT002	Ana Martínez	InnovaSoft SL	Carlos Rodríguez	ana.martinez@innovasoft.es	Directora de Marketing	934567890	Avenida Central 45, Barcelona	www.innovasoft.es	Busca soluciones de análisis de datos
3	EXT003	Luis Fernández	GlobalTrade Corp	Sofía López	luis.fernandez@globaltrade.com	CEO	911223344	Plaza Mayor 7, Sevilla	www.globaltrade.com	Expansión internacional
4	EXT004	Elena Gómez	EcoEnergy SL	Javier Sánchez	elena.gomez@ecoenergy.es	Ingeniera Jefe	955667788	Calle Verde 22, Valencia	www.ecoenergy.es	Interés en energías renovables
5	EXT005	Roberto Díaz	FoodTech SA	Carmen Ruiz	roberto.diaz@foodtech.com	Director de Operaciones	923456789	Avenida del Parque 56, Bilbao	www.foodtech.com	Automatización de procesos
6	EXT006	Isabel Torres	HealthCare Plus	Miguel Álvarez	isabel.torres@healthcareplus.es	Directora de Investigación	912345677	Calle Hospital 89, Málaga	www.healthcareplus.es	Desarrollo de nuevos tratamientos
7	EXT007	Francisco Moreno	ConstruPro SL	Laura Jiménez	francisco.moreno@construpro.com	Jefe de Proyectos	934567891	Avenida Constructora 34, Zaragoza	www.construpro.com	Búsqueda de proveedores
8	EXT008	Marta Serrano	FinanzaSegura SA	Andrés Muñoz	marta.serrano@finanzasegura.es	Analista Financiero	911223355	Calle Bolsa 12, Madrid	www.finanzasegura.es	Asesoramiento en inversiones
9	EXT009	Alberto Ramos	TechnoFuture Corp	Lucía Ortega	alberto.ramos@technofuture.com	CTO	955667799	Plaza Innovación 3, Barcelona	www.technofuture.com	Desarrollo de IA
10	EXT010	Cristina Navarro	EcoFashion SL	Daniel Delgado	cristina.navarro@ecofashion.es	Diseñadora Jefe	923456790	Calle Moda 78, Valencia	www.ecofashion.es	Moda sostenible
11	EXT011	Javier López	SmartHome Systems	Patricia Herrera	javier.lopez@smarthome.com	Ingeniero de Sistemas	912345679	Avenida Inteligente 90, Sevilla	www.smarthome.com	Integración de IoT
12	EXT012	Silvia Romero	GreenAgro SA	Raúl Vargas	silvia.romero@greenagro.es	Gerente de Producto	934567892	Calle Campo 23, Murcia	www.greenagro.es	Agricultura sostenible
13	EXT013	Diego Sanz	CyberSec Solutions	Eva Molina	diego.sanz@cybersec.com	Consultor de Seguridad	911223366	Plaza Digital 5, Bilbao	www.cybersec.com	Protección contra ciberataques
14	EXT014	Nuria Castro	EduTech Innovations	Óscar Medina	nuria.castro@edutech.es	Coordinadora Pedagógica	955667800	Avenida Educación 67, Granada	www.edutech.es	Plataformas de e-learning
15	EXT015	Rubén Flores	BioMed Research	Marina Vega	ruben.flores@biomed.com	Investigador Principal	923456791	Calle Ciencia 45, Valencia	www.biomed.com	Ensayos clínicos
16	EXT016	Carmen Ortiz	LogisTrans SL	Alejandro Reyes	carmen.ortiz@logistrans.es	Jefa de Logística	912345680	Avenida Transporte 89, Alicante	www.logistrans.es	Optimización de rutas
17	EXT017	Antonio Mendez	CloudServe SA	Beatriz Campos	antonio.mendez@cloudserve.com	Arquitecto de Soluciones	934567893	Calle Nube 34, Madrid	www.cloudserve.com	Migración a la nube
18	EXT018	Laura Guerrero	EcoTourism Adventures	Hugo Vera	laura.guerrero@ecotourism.es	Directora de Experiencias	911223377	Plaza Naturaleza 7, Tenerife	www.ecotourism.es	Turismo sostenible
19	EXT019	Pablo Ibáñez	RoboTech Industries	Celia Duran	pablo.ibanez@robotech.com	Ingeniero de Robótica	955667811	Avenida Autómata 56, Barcelona	www.robotech.com	Automatización industrial
20	EXT020	Beatriz Luna	ArtificialMinds Corp	Víctor Prieto	beatriz.luna@artificialminds.es	Data Scientist	923456792	Calle Algoritmo 78, Málaga	www.artificialminds.es	Modelos de machine learning
\.


--
-- TOC entry 3355 (class 0 OID 1417218)
-- Dependencies: 216
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.cliente (id, "tipo_compañia", "nombre_compañia", pais, ciudad, direccion, telefono, email, nit, cuenta_banco, banco) FROM stdin;
1	1	TechSolutions SA	Colombia            	Bogotá	Calle 100 #15-20	3101234	info@techsolutions.com	900123456	123456789	1
2	2	GreenEnergy LTDA	México              	Ciudad de México	Av. Reforma 222	5551234	contacto@greenenergy.mx	901234567	234567890	2
3	1	FoodExpress SAS	Argentina           	Buenos Aires	Av. Corrientes 1234	1123456	ventas@foodexpress.ar	902345678	345678901	3
4	3	GlobalTrade Inc	Estados Unidos      	Miami	123 Ocean Drive	3051234	info@globaltrade.com	903456789	456789012	1
5	2	EcoFashion CO	España              	Barcelona	Paseo de Gracia 43	934567	hola@ecofashion.es	904567890	567890123	2
6	1	DataPro SRL	Chile               	Santiago	Av. Providencia 1550	2234567	info@datapro.cl	905678901	678901234	3
7	3	AutoParts SA	Brasil              	São Paulo	Av. Paulista 1000	1198765	vendas@autoparts.br	906789012	789012345	1
8	2	SmartHome LTDA	Perú                	Lima	Av. Larco 400	5114567	info@smarthome.pe	907890123	890123456	2
9	1	FitnessGear CO	Colombia            	Medellín	Cra. 43A #1-50	3201234	ventas@fitnessgear.co	908901234	901234567	3
10	3	CoffeeWorld SA	Costa Rica          	San José	Calle 5, Av. Central	5062345	info@coffeeworld.cr	909012345	12345678	1
11	2	BeautySupply SAS	Uruguay             	Montevideo	Av. 18 de Julio 1234	5982345	contacto@beautysupply.uy	910123456	23456789	2
12	1	TechGadgets LTDA	México              	Guadalajara	Av. Vallarta 3000	3331234	ventas@techgadgets.mx	911234567	34567890	3
13	3	GreenConstruct SA	Ecuador             	Quito	Av. Amazonas N36-152	2234567	info@greenconstruct.ec	912345678	45678901	1
14	2	FashionTrends CO	Colombia            	Cali	Calle 9 #66-10	3401234	moda@fashiontrends.co	913456789	56789012	2
15	1	HealthCare SRL	Argentina           	Córdoba	Av. Colón 5000	3514567	info@healthcare.ar	914567890	67890123	3
16	3	LogisticsPro SA	Panamá              	Ciudad de Panamá	Calle 50, PH Global Plaza	5072345	info@logisticspro.pa	915678901	78901234	1
17	2	EcoClean LTDA	Chile               	Viña del Mar	Av. San Martín 1000	3224567	contacto@ecoclean.cl	916789012	89012345	2
18	1	DigitalMarketing SAS	Colombia            	Barranquilla	Cra. 54 #72-142	3501234	info@digitalmarketing.co	917890123	90123456	3
19	3	IndustrialTools SA	México              	Monterrey	Av. Constitución 1500	8181234	ventas@industrialtools.mx	918901234	1234567	1
20	2	OrganicFoods CO	Perú                	Cusco	Av. Sol 345	8423456	info@organicfoods.pe	919012345	2345678	2
\.


--
-- TOC entry 3359 (class 0 OID 1417272)
-- Dependencies: 220
-- Data for Name: inventario; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.inventario (id_inventario, codigo, cantidad, ubicacion) FROM stdin;
1	TECH-001	500	Almacén Central Madrid
2	INNO-001	250	Almacén Barcelona
3	GLOB-001	1000	Puerto de Sevilla
4	ECO-001	150	Planta Valencia
5	FOOD-001	750	Centro Logístico Bilbao
6	HEAL-001	300	Laboratorio Málaga
7	CONS-001	2000	Depósito Zaragoza
8	FIN-001	100	Oficina Central Madrid
9	TECH-002	450	Centro I+D Barcelona
10	ECO-002	200	Tienda Valencia
11	SMART-001	350	Almacén Sevilla
12	GREEN-001	1500	Invernadero Murcia
13	CYBER-001	50	Oficina Seguridad Bilbao
14	EDU-001	1000	Centro Distribución Granada
15	BIO-001	75	Laboratorio Valencia
16	LOGI-001	3000	Centro Logístico Alicante
17	CLOUD-001	25	Servidor Madrid
18	ECO-003	500	Almacén Tenerife
19	ROBO-001	100	Fábrica Barcelona
20	AI-001	200	Centro de Datos Málaga
\.


--
-- TOC entry 3357 (class 0 OID 1417234)
-- Dependencies: 218
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.producto (id, referencia, unidad_medida, precio, categoria, fabricar, codigo_barra, proveedor, codigo_proveedor, codigo_web) FROM stdin;
1	TECH-001	Unidad	499.99	1	N	123456789	TechSolutions SA	1001	TS-TECH001
2	INNO-001	Licencia	199.99	2	N	234567890	InnovaSoft SL	1002	IS-INNO001
3	GLOB-001	Kg	10.5	3	N	345678901	GlobalTrade Corp	1003	GT-GLOB001
4	ECO-001	Unidad	1299.99	4	S	456789012	EcoEnergy SL	1004	EE-ECO001
5	FOOD-001	Caja	79.99	5	S	567890123	FoodTech SA	1005	FT-FOOD001
6	HEAL-001	Unidad	599.99	6	S	678901234	HealthCare Plus	1006	HC-HEAL001
7	CONS-001	Metro cúbico	150	7	N	789012345	ConstruPro SL	1007	CP-CONS001
8	FIN-001	Paquete	299.99	8	N	890123456	FinanzaSegura SA	1008	FS-FIN001
9	TECH-002	Unidad	899.99	1	S	901234567	TechnoFuture Corp	1009	TF-TECH002
10	ECO-002	Unidad	59.99	9	S	123123123	EcoFashion SL	1010	EF-ECO002
11	SMART-001	Kit	399.99	10	S	234234234	SmartHome Systems	1011	SH-SMART001
12	GREEN-001	Litro	24.99	11	N	345345345	GreenAgro SA	1012	GA-GREEN001
13	CYBER-001	Licencia	149.99	12	N	456456456	CyberSec Solutions	1013	CS-CYBER001
14	EDU-001	Suscripción	9.99	13	N	567567567	EduTech Innovations	1014	ET-EDU001
15	BIO-001	Unidad	999.99	14	S	678678678	BioMed Research	1015	BR-BIO001
16	LOGI-001	Servicio	199.99	15	N	789789789	LogisTrans SL	1016	LT-LOGI001
17	CLOUD-001	GB	0.05	16	N	890890890	CloudServe SA	1017	CS-CLOUD001
18	ECO-003	Paquete	299.99	17	N	987654321	EcoTourism Adventures	1018	EA-ECO003
19	ROBO-001	Unidad	4999.99	18	S	876543210	RoboTech Industries	1019	RT-ROBO001
20	AI-001	Licencia	1999.99	19	N	765432109	ArtificialMinds Corp	1020	AM-AI001
\.


--
-- TOC entry 3375 (class 0 OID 0)
-- Dependencies: 221
-- Name: CRM_lead_id_lead_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public."CRM_lead_id_lead_seq"', 20, true);


--
-- TOC entry 3376 (class 0 OID 0)
-- Dependencies: 215
-- Name: cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.cliente_id_seq', 20, true);


--
-- TOC entry 3377 (class 0 OID 0)
-- Dependencies: 219
-- Name: inventario_id_inventario_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.inventario_id_inventario_seq', 20, true);


--
-- TOC entry 3378 (class 0 OID 0)
-- Dependencies: 217
-- Name: producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.producto_id_seq', 20, true);


--
-- TOC entry 3210 (class 2606 OID 1417318)
-- Name: CRM_lead CRM_lead_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public."CRM_lead"
    ADD CONSTRAINT "CRM_lead_pkey" PRIMARY KEY (id_lead);


--
-- TOC entry 3200 (class 2606 OID 1417223)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 3204 (class 2606 OID 1417241)
-- Name: producto codigo_barra; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT codigo_barra UNIQUE (codigo_barra) INCLUDE (codigo_barra);


--
-- TOC entry 3379 (class 0 OID 0)
-- Dependencies: 3204
-- Name: CONSTRAINT codigo_barra ON producto; Type: COMMENT; Schema: public; Owner: Comfe_owner
--

COMMENT ON CONSTRAINT codigo_barra ON public.producto IS 'codigo de barra del producto';


--
-- TOC entry 3208 (class 2606 OID 1417277)
-- Name: inventario inventario_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_pkey PRIMARY KEY (id_inventario);


--
-- TOC entry 3202 (class 2606 OID 1417225)
-- Name: cliente nit; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT nit UNIQUE (nit) INCLUDE (nit);


--
-- TOC entry 3380 (class 0 OID 0)
-- Dependencies: 3202
-- Name: CONSTRAINT nit ON cliente; Type: COMMENT; Schema: public; Owner: Comfe_owner
--

COMMENT ON CONSTRAINT nit ON public.cliente IS 'Registro único ';


--
-- TOC entry 3206 (class 2606 OID 1417239)
-- Name: producto producto_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (id);


--
-- TOC entry 2054 (class 826 OID 1425411)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- TOC entry 2053 (class 826 OID 1425410)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


-- Completed on 2024-08-13 20:11:02

--
-- PostgreSQL database dump complete
--

