--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-08-13 21:48:17

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
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 252 (class 1255 OID 1450280)
-- Name: actualizar_stock_orden_produccion(); Type: FUNCTION; Schema: public; Owner: Comfe_owner
--

CREATE FUNCTION public.actualizar_stock_orden_produccion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE public.producto_web
    SET stock_disponible = stock_disponible - NEW.cantidad
    WHERE id_producto = NEW.id_producto;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.actualizar_stock_orden_produccion() OWNER TO "Comfe_owner";

--
-- TOC entry 251 (class 1255 OID 1450279)
-- Name: calcular_costo_orden_produccion(integer); Type: FUNCTION; Schema: public; Owner: Comfe_owner
--

CREATE FUNCTION public.calcular_costo_orden_produccion(id_orden integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    costo_total DECIMAL(12, 2);
BEGIN
    SELECT SUM(tc.monto) INTO costo_total
    FROM public.transaccion_contable tc
    WHERE tc.id_orden_produccion = id_orden AND tc.tipo = 'Costo';
    
    RETURN COALESCE(costo_total, 0);
END;
$$;


ALTER FUNCTION public.calcular_costo_orden_produccion(id_orden integer) OWNER TO "Comfe_owner";

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
    notas character varying(300),
    codigo_proveedor integer
);


ALTER TABLE public."CRM_lead" OWNER TO "Comfe_owner";

--
-- TOC entry 3535 (class 0 OID 0)
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
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 221
-- Name: CRM_lead_id_lead_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public."CRM_lead_id_lead_seq" OWNED BY public."CRM_lead".id_lead;


--
-- TOC entry 236 (class 1259 OID 1450161)
-- Name: alarma; Type: TABLE; Schema: public; Owner: Comfe_owner
--

CREATE TABLE public.alarma (
    id integer NOT NULL,
    id_sensor integer,
    condicion character varying(50),
    valor_umbral numeric(10,2),
    mensaje text
);


ALTER TABLE public.alarma OWNER TO "Comfe_owner";

--
-- TOC entry 235 (class 1259 OID 1450160)
-- Name: alarma_id_seq; Type: SEQUENCE; Schema: public; Owner: Comfe_owner
--

CREATE SEQUENCE public.alarma_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.alarma_id_seq OWNER TO "Comfe_owner";

--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 235
-- Name: alarma_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public.alarma_id_seq OWNED BY public.alarma.id;


--
-- TOC entry 226 (class 1259 OID 1450078)
-- Name: carrito_compra; Type: TABLE; Schema: public; Owner: Comfe_owner
--

CREATE TABLE public.carrito_compra (
    id integer NOT NULL,
    id_cliente integer,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    estado character varying(20)
);


ALTER TABLE public.carrito_compra OWNER TO "Comfe_owner";

--
-- TOC entry 225 (class 1259 OID 1450077)
-- Name: carrito_compra_id_seq; Type: SEQUENCE; Schema: public; Owner: Comfe_owner
--

CREATE SEQUENCE public.carrito_compra_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carrito_compra_id_seq OWNER TO "Comfe_owner";

--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 225
-- Name: carrito_compra_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public.carrito_compra_id_seq OWNED BY public.carrito_compra.id;


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
-- TOC entry 3539 (class 0 OID 0)
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
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 215
-- Name: cliente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public.cliente_id_seq OWNED BY public.cliente.id;


--
-- TOC entry 230 (class 1259 OID 1450108)
-- Name: control_calidad; Type: TABLE; Schema: public; Owner: Comfe_owner
--

CREATE TABLE public.control_calidad (
    id integer NOT NULL,
    id_producto integer,
    fecha_inspeccion date,
    responsable character varying(100),
    resultado character varying(20),
    notas text
);


ALTER TABLE public.control_calidad OWNER TO "Comfe_owner";

--
-- TOC entry 229 (class 1259 OID 1450107)
-- Name: control_calidad_id_seq; Type: SEQUENCE; Schema: public; Owner: Comfe_owner
--

CREATE SEQUENCE public.control_calidad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.control_calidad_id_seq OWNER TO "Comfe_owner";

--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 229
-- Name: control_calidad_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public.control_calidad_id_seq OWNED BY public.control_calidad.id;


--
-- TOC entry 250 (class 1259 OID 1450259)
-- Name: documento_producto; Type: TABLE; Schema: public; Owner: Comfe_owner
--

CREATE TABLE public.documento_producto (
    id integer NOT NULL,
    id_version_producto integer,
    tipo_documento character varying(50),
    url_documento character varying(200),
    fecha_creacion date
);


ALTER TABLE public.documento_producto OWNER TO "Comfe_owner";

--
-- TOC entry 249 (class 1259 OID 1450258)
-- Name: documento_producto_id_seq; Type: SEQUENCE; Schema: public; Owner: Comfe_owner
--

CREATE SEQUENCE public.documento_producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.documento_producto_id_seq OWNER TO "Comfe_owner";

--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 249
-- Name: documento_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public.documento_producto_id_seq OWNED BY public.documento_producto.id;


--
-- TOC entry 238 (class 1259 OID 1450175)
-- Name: estacion_trabajo; Type: TABLE; Schema: public; Owner: Comfe_owner
--

CREATE TABLE public.estacion_trabajo (
    id integer NOT NULL,
    nombre character varying(100),
    tipo character varying(50),
    capacidad integer
);


ALTER TABLE public.estacion_trabajo OWNER TO "Comfe_owner";

--
-- TOC entry 237 (class 1259 OID 1450174)
-- Name: estacion_trabajo_id_seq; Type: SEQUENCE; Schema: public; Owner: Comfe_owner
--

CREATE SEQUENCE public.estacion_trabajo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estacion_trabajo_id_seq OWNER TO "Comfe_owner";

--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 237
-- Name: estacion_trabajo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public.estacion_trabajo_id_seq OWNED BY public.estacion_trabajo.id;


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
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 219
-- Name: inventario_id_inventario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public.inventario_id_inventario_seq OWNED BY public.inventario.id_inventario;


--
-- TOC entry 228 (class 1259 OID 1450091)
-- Name: item_carrito; Type: TABLE; Schema: public; Owner: Comfe_owner
--

CREATE TABLE public.item_carrito (
    id integer NOT NULL,
    id_carrito integer,
    id_producto_web integer,
    cantidad integer,
    precio_unitario numeric(10,2)
);


ALTER TABLE public.item_carrito OWNER TO "Comfe_owner";

--
-- TOC entry 227 (class 1259 OID 1450090)
-- Name: item_carrito_id_seq; Type: SEQUENCE; Schema: public; Owner: Comfe_owner
--

CREATE SEQUENCE public.item_carrito_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.item_carrito_id_seq OWNER TO "Comfe_owner";

--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 227
-- Name: item_carrito_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public.item_carrito_id_seq OWNED BY public.item_carrito.id;


--
-- TOC entry 234 (class 1259 OID 1450148)
-- Name: lectura_sensor; Type: TABLE; Schema: public; Owner: Comfe_owner
--

CREATE TABLE public.lectura_sensor (
    id integer NOT NULL,
    id_sensor integer,
    valor numeric(10,2),
    fecha_lectura timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.lectura_sensor OWNER TO "Comfe_owner";

--
-- TOC entry 233 (class 1259 OID 1450147)
-- Name: lectura_sensor_id_seq; Type: SEQUENCE; Schema: public; Owner: Comfe_owner
--

CREATE SEQUENCE public.lectura_sensor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lectura_sensor_id_seq OWNER TO "Comfe_owner";

--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 233
-- Name: lectura_sensor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public.lectura_sensor_id_seq OWNED BY public.lectura_sensor.id;


--
-- TOC entry 240 (class 1259 OID 1450189)
-- Name: orden_produccion; Type: TABLE; Schema: public; Owner: Comfe_owner
--

CREATE TABLE public.orden_produccion (
    id integer NOT NULL,
    nombre_producto character varying(100),
    cantidad integer,
    id_producto integer
);


ALTER TABLE public.orden_produccion OWNER TO "Comfe_owner";

--
-- TOC entry 239 (class 1259 OID 1450188)
-- Name: orden_produccion_id_seq; Type: SEQUENCE; Schema: public; Owner: Comfe_owner
--

CREATE SEQUENCE public.orden_produccion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orden_produccion_id_seq OWNER TO "Comfe_owner";

--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 239
-- Name: orden_produccion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public.orden_produccion_id_seq OWNED BY public.orden_produccion.id;


--
-- TOC entry 244 (class 1259 OID 1450221)
-- Name: pedido; Type: TABLE; Schema: public; Owner: Comfe_owner
--

CREATE TABLE public.pedido (
    id_pedido integer NOT NULL,
    fecha_pedido date,
    cliente character varying(100),
    total numeric(12,2)
);


ALTER TABLE public.pedido OWNER TO "Comfe_owner";

--
-- TOC entry 243 (class 1259 OID 1450220)
-- Name: pedido_id_pedido_seq; Type: SEQUENCE; Schema: public; Owner: Comfe_owner
--

CREATE SEQUENCE public.pedido_id_pedido_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pedido_id_pedido_seq OWNER TO "Comfe_owner";

--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 243
-- Name: pedido_id_pedido_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public.pedido_id_pedido_seq OWNED BY public.pedido.id_pedido;


--
-- TOC entry 242 (class 1259 OID 1450196)
-- Name: proceso_manufactura; Type: TABLE; Schema: public; Owner: Comfe_owner
--

CREATE TABLE public.proceso_manufactura (
    id integer NOT NULL,
    id_orden_produccion integer,
    id_estacion_trabajo integer,
    fecha_inicio timestamp without time zone,
    fecha_fin timestamp without time zone,
    estado character varying(20)
);


ALTER TABLE public.proceso_manufactura OWNER TO "Comfe_owner";

--
-- TOC entry 241 (class 1259 OID 1450195)
-- Name: proceso_manufactura_id_seq; Type: SEQUENCE; Schema: public; Owner: Comfe_owner
--

CREATE SEQUENCE public.proceso_manufactura_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.proceso_manufactura_id_seq OWNER TO "Comfe_owner";

--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 241
-- Name: proceso_manufactura_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public.proceso_manufactura_id_seq OWNED BY public.proceso_manufactura.id;


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
-- TOC entry 3550 (class 0 OID 0)
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
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 217
-- Name: producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public.producto_id_seq OWNED BY public.producto.id;


--
-- TOC entry 224 (class 1259 OID 1450064)
-- Name: producto_web; Type: TABLE; Schema: public; Owner: Comfe_owner
--

CREATE TABLE public.producto_web (
    id integer NOT NULL,
    id_producto integer,
    descripcion_web text,
    imagenes text[],
    precio_web numeric(10,2),
    stock_disponible integer,
    categoria_web character varying(50),
    tags text[]
);


ALTER TABLE public.producto_web OWNER TO "Comfe_owner";

--
-- TOC entry 223 (class 1259 OID 1450063)
-- Name: producto_web_id_seq; Type: SEQUENCE; Schema: public; Owner: Comfe_owner
--

CREATE SEQUENCE public.producto_web_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.producto_web_id_seq OWNER TO "Comfe_owner";

--
-- TOC entry 3552 (class 0 OID 0)
-- Dependencies: 223
-- Name: producto_web_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public.producto_web_id_seq OWNED BY public.producto_web.id;


--
-- TOC entry 232 (class 1259 OID 1450141)
-- Name: sensor; Type: TABLE; Schema: public; Owner: Comfe_owner
--

CREATE TABLE public.sensor (
    id integer NOT NULL,
    tipo character varying(50),
    ubicacion character varying(100),
    unidad_medida character varying(20)
);


ALTER TABLE public.sensor OWNER TO "Comfe_owner";

--
-- TOC entry 231 (class 1259 OID 1450140)
-- Name: sensor_id_seq; Type: SEQUENCE; Schema: public; Owner: Comfe_owner
--

CREATE SEQUENCE public.sensor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sensor_id_seq OWNER TO "Comfe_owner";

--
-- TOC entry 3553 (class 0 OID 0)
-- Dependencies: 231
-- Name: sensor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public.sensor_id_seq OWNED BY public.sensor.id;


--
-- TOC entry 246 (class 1259 OID 1450228)
-- Name: transaccion_contable; Type: TABLE; Schema: public; Owner: Comfe_owner
--

CREATE TABLE public.transaccion_contable (
    id integer NOT NULL,
    fecha date,
    tipo character varying(50),
    monto numeric(12,2),
    cuenta_debe character varying(50),
    cuenta_haber character varying(50),
    id_pedido integer,
    id_orden_produccion integer
);


ALTER TABLE public.transaccion_contable OWNER TO "Comfe_owner";

--
-- TOC entry 245 (class 1259 OID 1450227)
-- Name: transaccion_contable_id_seq; Type: SEQUENCE; Schema: public; Owner: Comfe_owner
--

CREATE SEQUENCE public.transaccion_contable_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transaccion_contable_id_seq OWNER TO "Comfe_owner";

--
-- TOC entry 3554 (class 0 OID 0)
-- Dependencies: 245
-- Name: transaccion_contable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public.transaccion_contable_id_seq OWNED BY public.transaccion_contable.id;


--
-- TOC entry 248 (class 1259 OID 1450245)
-- Name: version_producto; Type: TABLE; Schema: public; Owner: Comfe_owner
--

CREATE TABLE public.version_producto (
    id integer NOT NULL,
    id_producto integer,
    numero_version character varying(20),
    fecha_lanzamiento date,
    cambios text,
    estado character varying(20)
);


ALTER TABLE public.version_producto OWNER TO "Comfe_owner";

--
-- TOC entry 247 (class 1259 OID 1450244)
-- Name: version_producto_id_seq; Type: SEQUENCE; Schema: public; Owner: Comfe_owner
--

CREATE SEQUENCE public.version_producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.version_producto_id_seq OWNER TO "Comfe_owner";

--
-- TOC entry 3555 (class 0 OID 0)
-- Dependencies: 247
-- Name: version_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Comfe_owner
--

ALTER SEQUENCE public.version_producto_id_seq OWNED BY public.version_producto.id;


--
-- TOC entry 3270 (class 2604 OID 1417314)
-- Name: CRM_lead id_lead; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public."CRM_lead" ALTER COLUMN id_lead SET DEFAULT nextval('public."CRM_lead_id_lead_seq"'::regclass);


--
-- TOC entry 3279 (class 2604 OID 1450164)
-- Name: alarma id; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.alarma ALTER COLUMN id SET DEFAULT nextval('public.alarma_id_seq'::regclass);


--
-- TOC entry 3272 (class 2604 OID 1450081)
-- Name: carrito_compra id; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.carrito_compra ALTER COLUMN id SET DEFAULT nextval('public.carrito_compra_id_seq'::regclass);


--
-- TOC entry 3267 (class 2604 OID 1417221)
-- Name: cliente id; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.cliente ALTER COLUMN id SET DEFAULT nextval('public.cliente_id_seq'::regclass);


--
-- TOC entry 3275 (class 2604 OID 1450111)
-- Name: control_calidad id; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.control_calidad ALTER COLUMN id SET DEFAULT nextval('public.control_calidad_id_seq'::regclass);


--
-- TOC entry 3286 (class 2604 OID 1450262)
-- Name: documento_producto id; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.documento_producto ALTER COLUMN id SET DEFAULT nextval('public.documento_producto_id_seq'::regclass);


--
-- TOC entry 3280 (class 2604 OID 1450178)
-- Name: estacion_trabajo id; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.estacion_trabajo ALTER COLUMN id SET DEFAULT nextval('public.estacion_trabajo_id_seq'::regclass);


--
-- TOC entry 3269 (class 2604 OID 1417275)
-- Name: inventario id_inventario; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.inventario ALTER COLUMN id_inventario SET DEFAULT nextval('public.inventario_id_inventario_seq'::regclass);


--
-- TOC entry 3274 (class 2604 OID 1450094)
-- Name: item_carrito id; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.item_carrito ALTER COLUMN id SET DEFAULT nextval('public.item_carrito_id_seq'::regclass);


--
-- TOC entry 3277 (class 2604 OID 1450151)
-- Name: lectura_sensor id; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.lectura_sensor ALTER COLUMN id SET DEFAULT nextval('public.lectura_sensor_id_seq'::regclass);


--
-- TOC entry 3281 (class 2604 OID 1450192)
-- Name: orden_produccion id; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.orden_produccion ALTER COLUMN id SET DEFAULT nextval('public.orden_produccion_id_seq'::regclass);


--
-- TOC entry 3283 (class 2604 OID 1450224)
-- Name: pedido id_pedido; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.pedido ALTER COLUMN id_pedido SET DEFAULT nextval('public.pedido_id_pedido_seq'::regclass);


--
-- TOC entry 3282 (class 2604 OID 1450199)
-- Name: proceso_manufactura id; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.proceso_manufactura ALTER COLUMN id SET DEFAULT nextval('public.proceso_manufactura_id_seq'::regclass);


--
-- TOC entry 3268 (class 2604 OID 1417237)
-- Name: producto id; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.producto ALTER COLUMN id SET DEFAULT nextval('public.producto_id_seq'::regclass);


--
-- TOC entry 3271 (class 2604 OID 1450067)
-- Name: producto_web id; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.producto_web ALTER COLUMN id SET DEFAULT nextval('public.producto_web_id_seq'::regclass);


--
-- TOC entry 3276 (class 2604 OID 1450144)
-- Name: sensor id; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.sensor ALTER COLUMN id SET DEFAULT nextval('public.sensor_id_seq'::regclass);


--
-- TOC entry 3284 (class 2604 OID 1450231)
-- Name: transaccion_contable id; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.transaccion_contable ALTER COLUMN id SET DEFAULT nextval('public.transaccion_contable_id_seq'::regclass);


--
-- TOC entry 3285 (class 2604 OID 1450248)
-- Name: version_producto id; Type: DEFAULT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.version_producto ALTER COLUMN id SET DEFAULT nextval('public.version_producto_id_seq'::regclass);


--
-- TOC entry 3500 (class 0 OID 1417311)
-- Dependencies: 222
-- Data for Name: CRM_lead; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public."CRM_lead" (id_lead, external_id, nombre, "compañia_nombre", nombre_contacto, email_lead, posicion_trabajo, telefono, direccion, websita, notas, codigo_proveedor) FROM stdin;
1	EXT001	Juan Pérez	TechSolutions SA	María García	juan.perez@techsolutions.com	Gerente de Ventas	912345678	Calle Principal 123, Madrid	www.techsolutions.com	Interesado en software de gestión	1001
2	EXT002	Ana Martínez	InnovaSoft SL	Carlos Rodríguez	ana.martinez@innovasoft.es	Directora de Marketing	934567890	Avenida Central 45, Barcelona	www.innovasoft.es	Busca soluciones de análisis de datos	1002
3	EXT003	Luis Fernández	GlobalTrade Corp	Sofía López	luis.fernandez@globaltrade.com	CEO	911223344	Plaza Mayor 7, Sevilla	www.globaltrade.com	Expansión internacional	1003
4	EXT004	Elena Gómez	EcoEnergy SL	Javier Sánchez	elena.gomez@ecoenergy.es	Ingeniera Jefe	955667788	Calle Verde 22, Valencia	www.ecoenergy.es	Interés en energías renovables	1004
5	EXT005	Roberto Díaz	FoodTech SA	Carmen Ruiz	roberto.diaz@foodtech.com	Director de Operaciones	923456789	Avenida del Parque 56, Bilbao	www.foodtech.com	Automatización de procesos	1005
6	EXT006	Isabel Torres	HealthCare Plus	Miguel Álvarez	isabel.torres@healthcareplus.es	Directora de Investigación	912345677	Calle Hospital 89, Málaga	www.healthcareplus.es	Desarrollo de nuevos tratamientos	1006
7	EXT007	Francisco Moreno	ConstruPro SL	Laura Jiménez	francisco.moreno@construpro.com	Jefe de Proyectos	934567891	Avenida Constructora 34, Zaragoza	www.construpro.com	Búsqueda de proveedores	1007
8	EXT008	Marta Serrano	FinanzaSegura SA	Andrés Muñoz	marta.serrano@finanzasegura.es	Analista Financiero	911223355	Calle Bolsa 12, Madrid	www.finanzasegura.es	Asesoramiento en inversiones	1008
9	EXT009	Alberto Ramos	TechnoFuture Corp	Lucía Ortega	alberto.ramos@technofuture.com	CTO	955667799	Plaza Innovación 3, Barcelona	www.technofuture.com	Desarrollo de IA	1009
10	EXT010	Cristina Navarro	EcoFashion SL	Daniel Delgado	cristina.navarro@ecofashion.es	Diseñadora Jefe	923456790	Calle Moda 78, Valencia	www.ecofashion.es	Moda sostenible	1010
11	EXT011	Javier López	SmartHome Systems	Patricia Herrera	javier.lopez@smarthome.com	Ingeniero de Sistemas	912345679	Avenida Inteligente 90, Sevilla	www.smarthome.com	Integración de IoT	1011
12	EXT012	Silvia Romero	GreenAgro SA	Raúl Vargas	silvia.romero@greenagro.es	Gerente de Producto	934567892	Calle Campo 23, Murcia	www.greenagro.es	Agricultura sostenible	1012
13	EXT013	Diego Sanz	CyberSec Solutions	Eva Molina	diego.sanz@cybersec.com	Consultor de Seguridad	911223366	Plaza Digital 5, Bilbao	www.cybersec.com	Protección contra ciberataques	1013
14	EXT014	Nuria Castro	EduTech Innovations	Óscar Medina	nuria.castro@edutech.es	Coordinadora Pedagógica	955667800	Avenida Educación 67, Granada	www.edutech.es	Plataformas de e-learning	1014
15	EXT015	Rubén Flores	BioMed Research	Marina Vega	ruben.flores@biomed.com	Investigador Principal	923456791	Calle Ciencia 45, Valencia	www.biomed.com	Ensayos clínicos	1015
16	EXT016	Carmen Ortiz	LogisTrans SL	Alejandro Reyes	carmen.ortiz@logistrans.es	Jefa de Logística	912345680	Avenida Transporte 89, Alicante	www.logistrans.es	Optimización de rutas	1016
17	EXT017	Antonio Mendez	CloudServe SA	Beatriz Campos	antonio.mendez@cloudserve.com	Arquitecto de Soluciones	934567893	Calle Nube 34, Madrid	www.cloudserve.com	Migración a la nube	1017
18	EXT018	Laura Guerrero	EcoTourism Adventures	Hugo Vera	laura.guerrero@ecotourism.es	Directora de Experiencias	911223377	Plaza Naturaleza 7, Tenerife	www.ecotourism.es	Turismo sostenible	1018
19	EXT019	Pablo Ibáñez	RoboTech Industries	Celia Duran	pablo.ibanez@robotech.com	Ingeniero de Robótica	955667811	Avenida Autómata 56, Barcelona	www.robotech.com	Automatización industrial	1019
20	EXT020	Beatriz Luna	ArtificialMinds Corp	Víctor Prieto	beatriz.luna@artificialminds.es	Data Scientist	923456792	Calle Algoritmo 78, Málaga	www.artificialminds.es	Modelos de machine learning	1020
\.


--
-- TOC entry 3514 (class 0 OID 1450161)
-- Dependencies: 236
-- Data for Name: alarma; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.alarma (id, id_sensor, condicion, valor_umbral, mensaje) FROM stdin;
\.


--
-- TOC entry 3504 (class 0 OID 1450078)
-- Dependencies: 226
-- Data for Name: carrito_compra; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.carrito_compra (id, id_cliente, fecha_creacion, estado) FROM stdin;
\.


--
-- TOC entry 3494 (class 0 OID 1417218)
-- Dependencies: 216
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.cliente (id, "tipo_compañia", "nombre_compañia", pais, ciudad, direccion, telefono, email, nit, cuenta_banco, banco) FROM stdin;
21	1	TechSolutions SA	España              	Madrid	Calle Principal 123	912345678	info@techsolutions.com	123456789	987654321	S
22	2	InnovaSoft SL	España              	Barcelona	Avenida Central 45	934567890	contacto@innovasoft.es	234567890	876543210	C
23	3	GlobalTrade Corp	España              	Sevilla	Plaza Mayor 7	911223344	info@globaltrade.com	345678901	765432109	B
24	1	EcoEnergy SL	España              	Valencia	Calle Verde 22	955667788	contacto@ecoenergy.es	456789012	654321098	S
25	2	FoodTech SA	España              	Bilbao	Avenida del Parque 56	923456789	info@foodtech.com	567890123	543210987	C
26	3	HealthCare Plus	España              	Málaga	Calle Hospital 89	912345677	contacto@healthcareplus.es	678901234	432109876	B
27	1	ConstruPro SL	España              	Zaragoza	Avenida Constructora 34	934567891	info@construpro.com	789012345	321098765	S
28	2	FinanzaSegura SA	España              	Madrid	Calle Bolsa 12	911223355	contacto@finanzasegura.es	890123456	210987654	C
29	3	TechnoFuture Corp	España              	Barcelona	Plaza Innovación 3	955667799	info@technofuture.com	901234567	109876543	B
30	1	EcoFashion SL	España              	Valencia	Calle Moda 78	923456790	contacto@ecofashion.es	123123123	998877665	S
31	2	SmartHome Systems	España              	Sevilla	Avenida Inteligente 90	912345679	info@smarthome.com	234234234	887766554	C
32	3	GreenAgro SA	España              	Murcia	Calle Campo 23	934567892	contacto@greenagro.es	345345345	776655443	B
33	1	CyberSec Solutions	España              	Bilbao	Plaza Digital 5	911223366	info@cybersec.com	456456456	665544332	S
34	2	EduTech Innovations	España              	Granada	Avenida Educación 67	955667800	contacto@edutech.es	567567567	554433221	C
35	3	BioMed Research	España              	Valencia	Calle Ciencia 45	923456791	info@biomed.com	678678678	443322110	B
36	1	LogisTrans SL	España              	Alicante	Avenida Transporte 89	912345680	contacto@logistrans.es	789789789	332211009	S
37	2	CloudServe SA	España              	Madrid	Calle Nube 34	934567893	info@cloudserve.com	890890890	221100998	C
38	3	EcoTourism Adventures	España              	Tenerife	Plaza Naturaleza 7	911223377	contacto@ecotourism.es	987654321	110099887	B
39	1	RoboTech Industries	España              	Barcelona	Avenida Autómata 56	955667811	info@robotech.com	876543210	9988776	S
40	2	ArtificialMinds Corp	España              	Málaga	Calle Algoritmo 78	923456792	contacto@artificialminds.es	765432109	998877665	C
\.


--
-- TOC entry 3508 (class 0 OID 1450108)
-- Dependencies: 230
-- Data for Name: control_calidad; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.control_calidad (id, id_producto, fecha_inspeccion, responsable, resultado, notas) FROM stdin;
\.


--
-- TOC entry 3528 (class 0 OID 1450259)
-- Dependencies: 250
-- Data for Name: documento_producto; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.documento_producto (id, id_version_producto, tipo_documento, url_documento, fecha_creacion) FROM stdin;
\.


--
-- TOC entry 3516 (class 0 OID 1450175)
-- Dependencies: 238
-- Data for Name: estacion_trabajo; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.estacion_trabajo (id, nombre, tipo, capacidad) FROM stdin;
\.


--
-- TOC entry 3498 (class 0 OID 1417272)
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
-- TOC entry 3506 (class 0 OID 1450091)
-- Dependencies: 228
-- Data for Name: item_carrito; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.item_carrito (id, id_carrito, id_producto_web, cantidad, precio_unitario) FROM stdin;
\.


--
-- TOC entry 3512 (class 0 OID 1450148)
-- Dependencies: 234
-- Data for Name: lectura_sensor; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.lectura_sensor (id, id_sensor, valor, fecha_lectura) FROM stdin;
\.


--
-- TOC entry 3518 (class 0 OID 1450189)
-- Dependencies: 240
-- Data for Name: orden_produccion; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.orden_produccion (id, nombre_producto, cantidad, id_producto) FROM stdin;
\.


--
-- TOC entry 3522 (class 0 OID 1450221)
-- Dependencies: 244
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.pedido (id_pedido, fecha_pedido, cliente, total) FROM stdin;
\.


--
-- TOC entry 3520 (class 0 OID 1450196)
-- Dependencies: 242
-- Data for Name: proceso_manufactura; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.proceso_manufactura (id, id_orden_produccion, id_estacion_trabajo, fecha_inicio, fecha_fin, estado) FROM stdin;
\.


--
-- TOC entry 3496 (class 0 OID 1417234)
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
-- TOC entry 3502 (class 0 OID 1450064)
-- Dependencies: 224
-- Data for Name: producto_web; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.producto_web (id, id_producto, descripcion_web, imagenes, precio_web, stock_disponible, categoria_web, tags) FROM stdin;
\.


--
-- TOC entry 3510 (class 0 OID 1450141)
-- Dependencies: 232
-- Data for Name: sensor; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.sensor (id, tipo, ubicacion, unidad_medida) FROM stdin;
\.


--
-- TOC entry 3524 (class 0 OID 1450228)
-- Dependencies: 246
-- Data for Name: transaccion_contable; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.transaccion_contable (id, fecha, tipo, monto, cuenta_debe, cuenta_haber, id_pedido, id_orden_produccion) FROM stdin;
\.


--
-- TOC entry 3526 (class 0 OID 1450245)
-- Dependencies: 248
-- Data for Name: version_producto; Type: TABLE DATA; Schema: public; Owner: Comfe_owner
--

COPY public.version_producto (id, id_producto, numero_version, fecha_lanzamiento, cambios, estado) FROM stdin;
\.


--
-- TOC entry 3556 (class 0 OID 0)
-- Dependencies: 221
-- Name: CRM_lead_id_lead_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public."CRM_lead_id_lead_seq"', 20, true);


--
-- TOC entry 3557 (class 0 OID 0)
-- Dependencies: 235
-- Name: alarma_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.alarma_id_seq', 1, false);


--
-- TOC entry 3558 (class 0 OID 0)
-- Dependencies: 225
-- Name: carrito_compra_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.carrito_compra_id_seq', 1, false);


--
-- TOC entry 3559 (class 0 OID 0)
-- Dependencies: 215
-- Name: cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.cliente_id_seq', 40, true);


--
-- TOC entry 3560 (class 0 OID 0)
-- Dependencies: 229
-- Name: control_calidad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.control_calidad_id_seq', 1, false);


--
-- TOC entry 3561 (class 0 OID 0)
-- Dependencies: 249
-- Name: documento_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.documento_producto_id_seq', 1, false);


--
-- TOC entry 3562 (class 0 OID 0)
-- Dependencies: 237
-- Name: estacion_trabajo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.estacion_trabajo_id_seq', 1, false);


--
-- TOC entry 3563 (class 0 OID 0)
-- Dependencies: 219
-- Name: inventario_id_inventario_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.inventario_id_inventario_seq', 20, true);


--
-- TOC entry 3564 (class 0 OID 0)
-- Dependencies: 227
-- Name: item_carrito_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.item_carrito_id_seq', 1, false);


--
-- TOC entry 3565 (class 0 OID 0)
-- Dependencies: 233
-- Name: lectura_sensor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.lectura_sensor_id_seq', 1, false);


--
-- TOC entry 3566 (class 0 OID 0)
-- Dependencies: 239
-- Name: orden_produccion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.orden_produccion_id_seq', 1, false);


--
-- TOC entry 3567 (class 0 OID 0)
-- Dependencies: 243
-- Name: pedido_id_pedido_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.pedido_id_pedido_seq', 1, false);


--
-- TOC entry 3568 (class 0 OID 0)
-- Dependencies: 241
-- Name: proceso_manufactura_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.proceso_manufactura_id_seq', 1, false);


--
-- TOC entry 3569 (class 0 OID 0)
-- Dependencies: 217
-- Name: producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.producto_id_seq', 20, true);


--
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 223
-- Name: producto_web_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.producto_web_id_seq', 1, false);


--
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 231
-- Name: sensor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.sensor_id_seq', 1, false);


--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 245
-- Name: transaccion_contable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.transaccion_contable_id_seq', 1, false);


--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 247
-- Name: version_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Comfe_owner
--

SELECT pg_catalog.setval('public.version_producto_id_seq', 1, false);


--
-- TOC entry 3298 (class 2606 OID 1441803)
-- Name: CRM_lead CRM_lead_codigo_proveedor_key; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public."CRM_lead"
    ADD CONSTRAINT "CRM_lead_codigo_proveedor_key" UNIQUE (codigo_proveedor);


--
-- TOC entry 3300 (class 2606 OID 1417318)
-- Name: CRM_lead CRM_lead_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public."CRM_lead"
    ADD CONSTRAINT "CRM_lead_pkey" PRIMARY KEY (id_lead);


--
-- TOC entry 3316 (class 2606 OID 1450168)
-- Name: alarma alarma_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.alarma
    ADD CONSTRAINT alarma_pkey PRIMARY KEY (id);


--
-- TOC entry 3305 (class 2606 OID 1450084)
-- Name: carrito_compra carrito_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.carrito_compra
    ADD CONSTRAINT carrito_compra_pkey PRIMARY KEY (id);


--
-- TOC entry 3288 (class 2606 OID 1417223)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 3292 (class 2606 OID 1417241)
-- Name: producto codigo_barra; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT codigo_barra UNIQUE (codigo_barra) INCLUDE (codigo_barra);


--
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 3292
-- Name: CONSTRAINT codigo_barra ON producto; Type: COMMENT; Schema: public; Owner: Comfe_owner
--

COMMENT ON CONSTRAINT codigo_barra ON public.producto IS 'codigo de barra del producto';


--
-- TOC entry 3309 (class 2606 OID 1450115)
-- Name: control_calidad control_calidad_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.control_calidad
    ADD CONSTRAINT control_calidad_pkey PRIMARY KEY (id);


--
-- TOC entry 3334 (class 2606 OID 1450264)
-- Name: documento_producto documento_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.documento_producto
    ADD CONSTRAINT documento_producto_pkey PRIMARY KEY (id);


--
-- TOC entry 3318 (class 2606 OID 1450180)
-- Name: estacion_trabajo estacion_trabajo_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.estacion_trabajo
    ADD CONSTRAINT estacion_trabajo_pkey PRIMARY KEY (id);


--
-- TOC entry 3296 (class 2606 OID 1417277)
-- Name: inventario inventario_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_pkey PRIMARY KEY (id_inventario);


--
-- TOC entry 3307 (class 2606 OID 1450096)
-- Name: item_carrito item_carrito_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.item_carrito
    ADD CONSTRAINT item_carrito_pkey PRIMARY KEY (id);


--
-- TOC entry 3314 (class 2606 OID 1450154)
-- Name: lectura_sensor lectura_sensor_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.lectura_sensor
    ADD CONSTRAINT lectura_sensor_pkey PRIMARY KEY (id);


--
-- TOC entry 3290 (class 2606 OID 1417225)
-- Name: cliente nit; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT nit UNIQUE (nit) INCLUDE (nit);


--
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 3290
-- Name: CONSTRAINT nit ON cliente; Type: COMMENT; Schema: public; Owner: Comfe_owner
--

COMMENT ON CONSTRAINT nit ON public.cliente IS 'Registro único ';


--
-- TOC entry 3321 (class 2606 OID 1450194)
-- Name: orden_produccion orden_produccion_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.orden_produccion
    ADD CONSTRAINT orden_produccion_pkey PRIMARY KEY (id);


--
-- TOC entry 3326 (class 2606 OID 1450226)
-- Name: pedido pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (id_pedido);


--
-- TOC entry 3324 (class 2606 OID 1450201)
-- Name: proceso_manufactura proceso_manufactura_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.proceso_manufactura
    ADD CONSTRAINT proceso_manufactura_pkey PRIMARY KEY (id);


--
-- TOC entry 3294 (class 2606 OID 1417239)
-- Name: producto producto_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (id);


--
-- TOC entry 3303 (class 2606 OID 1450071)
-- Name: producto_web producto_web_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.producto_web
    ADD CONSTRAINT producto_web_pkey PRIMARY KEY (id);


--
-- TOC entry 3311 (class 2606 OID 1450146)
-- Name: sensor sensor_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.sensor
    ADD CONSTRAINT sensor_pkey PRIMARY KEY (id);


--
-- TOC entry 3329 (class 2606 OID 1450233)
-- Name: transaccion_contable transaccion_contable_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.transaccion_contable
    ADD CONSTRAINT transaccion_contable_pkey PRIMARY KEY (id);


--
-- TOC entry 3332 (class 2606 OID 1450252)
-- Name: version_producto version_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.version_producto
    ADD CONSTRAINT version_producto_pkey PRIMARY KEY (id);


--
-- TOC entry 3312 (class 1259 OID 1450275)
-- Name: idx_lectura_sensor_fecha; Type: INDEX; Schema: public; Owner: Comfe_owner
--

CREATE INDEX idx_lectura_sensor_fecha ON public.lectura_sensor USING btree (fecha_lectura);


--
-- TOC entry 3319 (class 1259 OID 1450273)
-- Name: idx_orden_produccion_id_producto; Type: INDEX; Schema: public; Owner: Comfe_owner
--

CREATE INDEX idx_orden_produccion_id_producto ON public.orden_produccion USING btree (id_producto);


--
-- TOC entry 3322 (class 1259 OID 1450276)
-- Name: idx_proceso_manufactura_id_orden; Type: INDEX; Schema: public; Owner: Comfe_owner
--

CREATE INDEX idx_proceso_manufactura_id_orden ON public.proceso_manufactura USING btree (id_orden_produccion);


--
-- TOC entry 3301 (class 1259 OID 1450272)
-- Name: idx_producto_web_id_producto; Type: INDEX; Schema: public; Owner: Comfe_owner
--

CREATE INDEX idx_producto_web_id_producto ON public.producto_web USING btree (id_producto);


--
-- TOC entry 3327 (class 1259 OID 1450274)
-- Name: idx_transaccion_contable_fecha; Type: INDEX; Schema: public; Owner: Comfe_owner
--

CREATE INDEX idx_transaccion_contable_fecha ON public.transaccion_contable USING btree (fecha);


--
-- TOC entry 3330 (class 1259 OID 1450277)
-- Name: idx_version_producto_id_producto; Type: INDEX; Schema: public; Owner: Comfe_owner
--

CREATE INDEX idx_version_producto_id_producto ON public.version_producto USING btree (id_producto);


--
-- TOC entry 3349 (class 2620 OID 1450281)
-- Name: orden_produccion tr_actualizar_stock_orden_produccion; Type: TRIGGER; Schema: public; Owner: Comfe_owner
--

CREATE TRIGGER tr_actualizar_stock_orden_produccion AFTER INSERT ON public.orden_produccion FOR EACH ROW EXECUTE FUNCTION public.actualizar_stock_orden_produccion();


--
-- TOC entry 3342 (class 2606 OID 1450169)
-- Name: alarma alarma_id_sensor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.alarma
    ADD CONSTRAINT alarma_id_sensor_fkey FOREIGN KEY (id_sensor) REFERENCES public.sensor(id);


--
-- TOC entry 3337 (class 2606 OID 1450085)
-- Name: carrito_compra carrito_compra_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.carrito_compra
    ADD CONSTRAINT carrito_compra_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES public.cliente(id);


--
-- TOC entry 3340 (class 2606 OID 1450116)
-- Name: control_calidad control_calidad_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.control_calidad
    ADD CONSTRAINT control_calidad_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.producto(id);


--
-- TOC entry 3348 (class 2606 OID 1450265)
-- Name: documento_producto documento_producto_id_version_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.documento_producto
    ADD CONSTRAINT documento_producto_id_version_producto_fkey FOREIGN KEY (id_version_producto) REFERENCES public.version_producto(id);


--
-- TOC entry 3335 (class 2606 OID 1441804)
-- Name: producto fk_producto_crm_lead; Type: FK CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT fk_producto_crm_lead FOREIGN KEY (codigo_proveedor) REFERENCES public."CRM_lead"(codigo_proveedor) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3338 (class 2606 OID 1450097)
-- Name: item_carrito item_carrito_id_carrito_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.item_carrito
    ADD CONSTRAINT item_carrito_id_carrito_fkey FOREIGN KEY (id_carrito) REFERENCES public.carrito_compra(id);


--
-- TOC entry 3339 (class 2606 OID 1450102)
-- Name: item_carrito item_carrito_id_producto_web_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.item_carrito
    ADD CONSTRAINT item_carrito_id_producto_web_fkey FOREIGN KEY (id_producto_web) REFERENCES public.producto_web(id);


--
-- TOC entry 3341 (class 2606 OID 1450155)
-- Name: lectura_sensor lectura_sensor_id_sensor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.lectura_sensor
    ADD CONSTRAINT lectura_sensor_id_sensor_fkey FOREIGN KEY (id_sensor) REFERENCES public.sensor(id);


--
-- TOC entry 3343 (class 2606 OID 1450207)
-- Name: proceso_manufactura proceso_manufactura_id_estacion_trabajo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.proceso_manufactura
    ADD CONSTRAINT proceso_manufactura_id_estacion_trabajo_fkey FOREIGN KEY (id_estacion_trabajo) REFERENCES public.estacion_trabajo(id);


--
-- TOC entry 3344 (class 2606 OID 1450202)
-- Name: proceso_manufactura proceso_manufactura_id_orden_produccion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.proceso_manufactura
    ADD CONSTRAINT proceso_manufactura_id_orden_produccion_fkey FOREIGN KEY (id_orden_produccion) REFERENCES public.orden_produccion(id);


--
-- TOC entry 3336 (class 2606 OID 1450072)
-- Name: producto_web producto_web_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.producto_web
    ADD CONSTRAINT producto_web_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.producto(id);


--
-- TOC entry 3345 (class 2606 OID 1450239)
-- Name: transaccion_contable transaccion_contable_id_orden_produccion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.transaccion_contable
    ADD CONSTRAINT transaccion_contable_id_orden_produccion_fkey FOREIGN KEY (id_orden_produccion) REFERENCES public.orden_produccion(id);


--
-- TOC entry 3346 (class 2606 OID 1450234)
-- Name: transaccion_contable transaccion_contable_id_pedido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.transaccion_contable
    ADD CONSTRAINT transaccion_contable_id_pedido_fkey FOREIGN KEY (id_pedido) REFERENCES public.pedido(id_pedido);


--
-- TOC entry 3347 (class 2606 OID 1450253)
-- Name: version_producto version_producto_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Comfe_owner
--

ALTER TABLE ONLY public.version_producto
    ADD CONSTRAINT version_producto_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.producto(id);


--
-- TOC entry 2126 (class 826 OID 1425411)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- TOC entry 2125 (class 826 OID 1425410)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


-- Completed on 2024-08-13 21:48:34

--
-- PostgreSQL database dump complete
--

