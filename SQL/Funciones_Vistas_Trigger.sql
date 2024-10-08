-- Desarrollado por Dilio Méndez
-- Agosto 13 de 2024

-- Índices para mejorar el rendimiento
CREATE INDEX idx_producto_web_id_producto ON public.producto_web(id_producto);
CREATE INDEX idx_orden_produccion_id_producto ON public.orden_produccion(id_producto);
CREATE INDEX idx_transaccion_contable_fecha ON public.transaccion_contable(fecha);
CREATE INDEX idx_lectura_sensor_fecha ON public.lectura_sensor(fecha_lectura);
CREATE INDEX idx_proceso_manufactura_id_orden ON public.proceso_manufactura(id_orden_produccion);
CREATE INDEX idx_version_producto_id_producto ON public.version_producto(id_producto);

-- Vista para obtener un resumen de las órdenes de producción activas
CREATE VIEW public.resumen_ordenes_produccion AS
SELECT 
    op.id, 
    p.referencia AS producto_referencia, 
    op.cantidad, 
    op.fecha_inicio, 
    op.fecha_fin_estimada, 
    op.estado,
    c."nombre_compañia" AS cliente
FROM 
    public.orden_produccion op
JOIN public.producto p ON op.id_producto = p.id
JOIN public.pedido ped ON op.id_pedido = ped.id_pedido
JOIN public.cliente c ON ped.id_cliente = c.id
WHERE 
    op.estado = 'En Proceso';

-- Función para calcular el costo total de una orden de producción
CREATE OR REPLACE FUNCTION public.calcular_costo_orden_produccion(id_orden INTEGER)
RETURNS DECIMAL AS $$
DECLARE
    costo_total DECIMAL(12, 2);
BEGIN
    SELECT SUM(tc.monto) INTO costo_total
    FROM public.transaccion_contable tc
    WHERE tc.id_orden_produccion = id_orden AND tc.tipo = 'Costo';
    
    RETURN COALESCE(costo_total, 0);
END;
$$ LANGUAGE plpgsql;

-- Trigger para actualizar el stock cuando se crea una nueva orden de producción
CREATE OR REPLACE FUNCTION public.actualizar_stock_orden_produccion()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE public.producto_web
    SET stock_disponible = stock_disponible - NEW.cantidad
    WHERE id_producto = NEW.id_producto;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_actualizar_stock_orden_produccion
AFTER INSERT ON public.orden_produccion
FOR EACH ROW
EXECUTE FUNCTION public.actualizar_stock_orden_produccion();