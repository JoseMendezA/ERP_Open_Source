--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-08-13 19:33:21

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
\.


--
-- TOC entry 3355 (class 0 OID 1417218)
-- Dependencies: 216
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.cliente (id, "tipo_compañia", "nombre_compañia", pais, ciudad, direccion, telefono, email, nit, cuenta_banco, banco) FROM stdin;
\.


--
-- TOC entry 3359 (class 0 OID 1417272)
-- Dependencies: 220
-- Data for Name: inventario; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.inventario (id_inventario, codigo, cantidad, ubicacion) FROM stdin;
\.


--
-- TOC entry 3357 (class 0 OID 1417234)
-- Dependencies: 218
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.producto (id, referencia, unidad_medida, precio, categoria, fabricar, codigo_barra, proveedor, codigo_proveedor, codigo_web) FROM stdin;
\.


--
-- TOC entry 3375 (class 0 OID 0)
-- Dependencies: 221
-- Name: CRM_lead_id_lead_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public."CRM_lead_id_lead_seq"', 1, false);


--
-- TOC entry 3376 (class 0 OID 0)
-- Dependencies: 215
-- Name: cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.cliente_id_seq', 1, false);


--
-- TOC entry 3377 (class 0 OID 0)
-- Dependencies: 219
-- Name: inventario_id_inventario_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.inventario_id_inventario_seq', 1, false);


--
-- TOC entry 3378 (class 0 OID 0)
-- Dependencies: 217
-- Name: producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.producto_id_seq', 1, false);


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


-- Completed on 2024-08-13 19:33:31

--
-- PostgreSQL database dump complete
--

