
 # 🚀 ERP Open Source

[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/JoseMendezA/ERP_Open_Source/issues)
[![Follow on GitHub](https://img.shields.io/github/followers/JoseMendezA?style=social)](https://github.com/JoseMendezA)

> [!Tip]
> ¡Bienvenido al proyecto ERP Open Source! 🎉 Un sistema de planificación de recursos empresariales potente, flexible y de código abierto.

## 🌟 Características principales

- 📊 Gestión financiera completa
- 🏭 Control de inventario y producción
- 👥 Administración de recursos humanos
- 🛒 Gestión de ventas y CRM
- 📈 Informes y análisis avanzados

## 💻 Tecnologías Utilizadas

- Python
- Django
- PostgreSQL
- React

> [!Warning]
> Se han añadido las siguientes tablas:

1. Website y E-commerce: producto_web, carrito_compra, item_carrito
2. Calidad: control_calidad
3. Pedidos y Órdenes de Producción: orden_produccion
4. Contabilidad: transaccion_contable
5. Alarmas y Sensores: sensor, lectura_sensor, alarma
6. Manufactura: estacion_trabajo, proceso_manufactura
7. PLM (Product Lifecycle Management): version_producto, documento_producto

> [!IMPORTANT]
> El sistema ERP Incluye:

- [x] Índices para mejorar el rendimiento de las consultas.
- [x] Una vista resumen_ordenes_produccion para obtener un resumen de las órdenes de producción activas.
- [x] Una función calcular_costo_orden_produccion para calcular el costo total de una orden de producción.
- [x] Un trigger actualizar_stock_orden_produccion para actualizar automáticamente el stock cuando se crea una nueva orden de producción.

> [!CAUTION]
> Este esquema proporciona una base sólida para un ERP ampliado. Dependiendo de las necesidades específicas del negocio, es posible que se requieran ajustes o tablas adicionales.

> [!Note]
> - [x] La relación entre inventario y producto asume que cada entrada en el inventario corresponde a un único producto. Si un producto puede estar en múltiples ubicaciones, podrías necesitar ajustar esta relación.
> - [x] La tabla de pedidos (producto-cliente) permite registrar transacciones o pedidos, lo que es útil para un sistema de gestión de ventas o inventario.
> - [x] Dependiendo de tus necesidades específicas, podrías querer agregar más tablas (como una tabla de ventas) o campos adicionales a las tablas existentes.

## 🛠️ Instalación

🚀 Comenzando

Sigue estos pasos para obtener una copia del proyecto en funcionamiento en tu máquina local para propósitos de desarrollo y pruebas:

1. **Clona el repositorio:**

   ```bash
   git clone https://github.com/JoseMendezA/ERP_Open_Source.git
   cd ERP_Open_Source

2. Instala las dependencias:
    ```bash
    pip install -r requirements.txt
    npm install

3. Configura la base de datos:

   Configura la conexión a tu base de datos en el archivo .env.

4. Ejecuta las migraciones y levanta el servidor:

   ```bash
   python manage.py migrate
   python manage.py runserver

5. Inicia la aplicación:

   ```bash
    npm start
