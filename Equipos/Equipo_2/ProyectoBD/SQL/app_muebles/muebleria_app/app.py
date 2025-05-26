

from flask import Flask, render_template, request, redirect, url_for, flash
import psycopg2
import json  # <-- Asegúrate de que esta línea esté presente
from markupsafe import Markup
from flask import session

app = Flask(__name__)
app.secret_key = 'supersecretkey'

def get_db_connection():
    try:
        conn = psycopg2.connect(
            host='c6sfjnr30ch74e.cluster-czrs8kj4isg7.us-east-1.rds.amazonaws.com',
            dbname='ddrq67b07taudq',
            user='ufsoav3252jr22',
            password='p4f365297f395083b6bc44b4fe2607f6091e7a796be0a119ba35ea6107392e324'
        )
        print("🔌 Conectado a la base de datos")
        return conn
    except Exception as e:
        print("❌ No se pudo conectar a la base de datos:", e)
        raise

@app.route('/')
@app.route('/')
def index():
    if 'usuario' not in session:
        return redirect(url_for('login'))

    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("""
        SELECT codigo_de_barras, nombre_articulo,
               CASE WHEN stock = 0 THEN 'No disponible'
                    ELSE 'Stock bajo' END AS estado
        FROM "ARTICULO"
        WHERE stock <= 3
    """)
    articulos = cur.fetchall()
    cur.execute('SELECT folio FROM "VENTA" ORDER BY fecha_venta DESC LIMIT 1')
    folio_actual = cur.fetchone()
    cur.close()
    conn.close()
    return render_template('index.html', articulos=articulos, folio_actual=folio_actual[0] if folio_actual else '')

def crear_trigger_actualizar_fecha_stock():
    sql = """
    ALTER TABLE "ARTICULO" ADD COLUMN IF NOT EXISTS fecha_actualizacion_stock TIMESTAMP;

    CREATE OR REPLACE FUNCTION actualizar_fecha_stock() RETURNS TRIGGER AS $$
    BEGIN
        IF NEW.stock <> OLD.stock THEN
            NEW.fecha_actualizacion_stock = NOW();
        END IF;
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    DROP TRIGGER IF EXISTS trg_actualizar_fecha_stock ON "ARTICULO";

    CREATE TRIGGER trg_actualizar_fecha_stock
    BEFORE UPDATE ON "ARTICULO"
    FOR EACH ROW
    EXECUTE FUNCTION actualizar_fecha_stock();
    """
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute(sql)
    conn.commit()
    cur.close()
    conn.close()
@app.route('/crear_trigger_fecha_stock', methods=['GET', 'POST'])
def crear_trigger_fecha_stock_route():
    if request.method == 'POST':
        try:
            crear_trigger_actualizar_fecha_stock()
            flash('✅ Trigger para actualizar fecha de stock creado correctamente.', 'success')
        except Exception as e:
            flash(f'❌ Error al crear trigger: {e}', 'danger')
        return redirect(url_for('index'))
    return render_template('crear_trigger_fecha_stock.html')

def crear_trigger_validar_stock():
    sql = """
    CREATE OR REPLACE FUNCTION validar_stock_detalle_venta() RETURNS TRIGGER AS $$
    DECLARE
        stock_actual INTEGER;
    BEGIN
        SELECT stock INTO stock_actual FROM "ARTICULO" WHERE codigo_de_barras = NEW."codigo_de_barras_ARTICULO";

        IF stock_actual IS NULL THEN
            RAISE EXCEPTION 'El artículo con código % no existe', NEW."codigo_de_barras_ARTICULO";
        END IF;

        IF NEW.cantidad_por_articulo > stock_actual THEN
            RAISE EXCEPTION 'Stock insuficiente para el artículo %: stock actual %', NEW."codigo_de_barras_ARTICULO", stock_actual;
        END IF;

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    DROP TRIGGER IF EXISTS trg_validar_stock_insert ON "DETALLE_VENTA";
    CREATE TRIGGER trg_validar_stock_insert
    BEFORE INSERT ON "DETALLE_VENTA"
    FOR EACH ROW EXECUTE FUNCTION validar_stock_detalle_venta();

    DROP TRIGGER IF EXISTS trg_validar_stock_update ON "DETALLE_VENTA";
    CREATE TRIGGER trg_validar_stock_update
    BEFORE UPDATE ON "DETALLE_VENTA"
    FOR EACH ROW EXECUTE FUNCTION validar_stock_detalle_venta();
    """

    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute(sql)
    conn.commit()
    cur.close()
    conn.close()

@app.route('/crear_trigger_stock', methods=['GET', 'POST'])
def crear_trigger_stock():
    if request.method == 'POST':
        try:
            crear_trigger_validar_stock()
            flash('✅ Trigger de validación de stock creado correctamente.', 'success')
        except Exception as e:
            flash(f'❌ Error al crear trigger: {e}', 'danger')
        return redirect(url_for('index'))
    return render_template('crear_trigger_stock.html')



@app.route('/crear_indice')
def crear_indice():
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('CREATE INDEX IF NOT EXISTS idx_stock_articulo ON "ARTICULO"(stock);')
        conn.commit()
        flash('✅ Índice creado exitosamente sobre ARTICULO.stock (tipo B-Tree).', 'info')
    except Exception as e:
        flash(f'❌ Error al crear índice: {e}', 'danger')
    finally:
        cur.close()
        conn.close()
    return redirect(url_for('index'))

@app.route('/nueva_venta', methods=['POST'])
def nueva_venta():
    cajero = request.form['cajero']
    vendedor = request.form['vendedor']
    cliente = request.form['cliente']
    try:
        conn = get_db_connection()
        cur = conn.cursor()

        cur.execute('SELECT "id_sucursal_SUCURSAL" FROM "CAJERO" WHERE numero_empleado = %s', (cajero,))
        cajero_suc = cur.fetchone()
        cur.execute('SELECT "id_sucursal_SUCURSAL" FROM "VENDEDOR" WHERE numero_empleado = %s', (vendedor,))
        vendedor_suc = cur.fetchone()

        if not cajero_suc or not vendedor_suc or cajero_suc[0] != vendedor_suc[0]:
            flash('⚠️ Error: Vendedor y Cajero no pertenecen a la misma sucursal', 'danger')
            return redirect(url_for('index'))

        cur.execute('SELECT COUNT(*) FROM "VENTA"')
        count = cur.fetchone()[0] + 1
        folio = f"MBL-{count:03d}"

        cur.execute("""
            INSERT INTO "VENTA" (folio, monto_total, cantidad_total_articulo, "numero_empleado_VENDEDOR", "numero_empleado_CAJERO", "rfc_cliente_CLIENTE")
            VALUES (%s, 0, 0, %s, %s, %s)
        """, (folio, vendedor, cajero, cliente))
        conn.commit()
        flash(Markup(f'🗓 Venta iniciada con folio {folio}. <a class="btn btn-sm btn-primary ms-3" href="{url_for("ticket", folio=folio)}">Ver Ticket</a>'), 'success')

    except Exception as e:
        flash(f'❌ Error al iniciar venta: {e}', 'danger')
    finally:
        cur.close()
        conn.close()
    return redirect(url_for('index'))

@app.route('/agregar_articulo', methods=['POST'])
def agregar_articulo():
    folio = request.form['folio']
    codigo = request.form['codigo']
    cantidad = int(request.form['cantidad'])

    try:
        conn = get_db_connection()
        cur = conn.cursor()

        cur.execute('SELECT stock, precio_de_venta FROM "ARTICULO" WHERE codigo_de_barras = %s', (codigo,))
        result = cur.fetchone()

        if not result:
            flash('❌ Artículo no existe', 'danger')
        elif result[0] < cantidad:
            flash('❌ Stock insuficiente', 'danger')
        else:
            stock, precio = result
            subtotal = cantidad * precio

            cur.execute("""
                INSERT INTO "DETALLE_VENTA" (cantidad_por_articulo, monto_por_articulo, "codigo_de_barras_ARTICULO", "folio_VENTA")
                VALUES (%s, %s, %s, %s)
            """, (cantidad, subtotal, codigo, folio))

            cur.execute('UPDATE "ARTICULO" SET stock = stock - %s WHERE codigo_de_barras = %s', (cantidad, codigo))
            cur.execute("""
                UPDATE "VENTA"
                SET monto_total = monto_total + %s,
                    cantidad_total_articulo = cantidad_total_articulo + %s
                WHERE folio = %s
            """, (subtotal, cantidad, folio))

            conn.commit()
            flash(f'✅ {cantidad} unidades de {codigo} agregadas a la venta {folio}', 'success')
    except Exception as e:
        flash(f'❌ Error al agregar artículo: {e}', 'danger')
    finally:
        cur.close()
        conn.close()

    return redirect(url_for('index'))

@app.route('/ticket/<folio>')
def ticket(folio):
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("""
        SELECT v.folio, v.fecha_venta, c.razon_social_cliente, a.nombre_articulo,
               dv.cantidad_por_articulo, dv.monto_por_articulo
        FROM "VENTA" v
        JOIN "DETALLE_VENTA" dv ON dv."folio_VENTA" = v.folio
        JOIN "ARTICULO" a ON a.codigo_de_barras = dv."codigo_de_barras_ARTICULO"
        LEFT JOIN "CLIENTE" c ON c.rfc_cliente = v."rfc_cliente_CLIENTE"
        WHERE v.folio = %s
    """, (folio,))
    detalles = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('ticket.html', detalles=detalles, folio=folio)
@app.route('/jerarquia', methods=['GET', 'POST'])
def jerarquia():
    import unicodedata

    def quitar_acentos(texto):
        return ''.join(
            c for c in unicodedata.normalize('NFD', texto)
            if unicodedata.category(c) != 'Mn'
        )

    empleados = []
    filtro = ''

    if request.method == 'POST':
        filtro_original = request.form.get('nombre', '').strip()
        filtro = quitar_acentos(filtro_original).lower()
        print(f"Filtro recibido (sin acentos): '{filtro}'")

        if filtro:
            conn = get_db_connection()
            cur = conn.cursor()

            cur.execute("""
                WITH RECURSIVE jerarquia AS (
                  SELECT 
                    e.numero_empleado,
                    e.numero_supervisor,
                    e.email_empleado AS nombre_completo,
                    CASE 
                      WHEN v.numero_empleado IS NOT NULL THEN 'VENDEDOR'
                      WHEN c.numero_empleado IS NOT NULL THEN 'CAJERO'
                      WHEN a.numero_empleado IS NOT NULL THEN 'ADMINISTRATIVO'
                      WHEN s.numero_empleado IS NOT NULL THEN 'SEGURIDAD'
                      WHEN l.numero_empleado IS NOT NULL THEN 'LIMPIEZA'
                      ELSE 'DESCONOCIDO'
                    END AS puesto
                  FROM "EMPLEADO" e
                  LEFT JOIN "VENDEDOR" v ON e.numero_empleado = v.numero_empleado
                  LEFT JOIN "CAJERO" c ON e.numero_empleado = c.numero_empleado
                  LEFT JOIN "ADMINISTRATIVO" a ON e.numero_empleado = a.numero_empleado
                  LEFT JOIN "SEGURIDAD" s ON e.numero_empleado = s.numero_empleado
                  LEFT JOIN "LIMPIEZA" l ON e.numero_empleado = l.numero_empleado
                  WHERE translate(lower(e.email_empleado), 'áéíóúÁÉÍÓÚüÜñÑ', 'aeiouAEIOUuUnN') ILIKE %s

                  UNION ALL

                  SELECT 
                    e2.numero_empleado,
                    e2.numero_supervisor,
                    e2.email_empleado AS nombre_completo,
                    CASE 
                      WHEN v2.numero_empleado IS NOT NULL THEN 'VENDEDOR'
                      WHEN c2.numero_empleado IS NOT NULL THEN 'CAJERO'
                      WHEN a2.numero_empleado IS NOT NULL THEN 'ADMINISTRATIVO'
                      WHEN s2.numero_empleado IS NOT NULL THEN 'SEGURIDAD'
                      WHEN l2.numero_empleado IS NOT NULL THEN 'LIMPIEZA'
                      ELSE 'DESCONOCIDO'
                    END AS puesto
                  FROM "EMPLEADO" e2
                  LEFT JOIN "VENDEDOR" v2 ON e2.numero_empleado = v2.numero_empleado
                  LEFT JOIN "CAJERO" c2 ON e2.numero_empleado = c2.numero_empleado
                  LEFT JOIN "ADMINISTRATIVO" a2 ON e2.numero_empleado = a2.numero_empleado
                  LEFT JOIN "SEGURIDAD" s2 ON e2.numero_empleado = s2.numero_empleado
                  LEFT JOIN "LIMPIEZA" l2 ON e2.numero_empleado = l2.numero_empleado
                  JOIN jerarquia j ON e2.numero_empleado = j.numero_supervisor
                )
                SELECT DISTINCT numero_empleado, numero_supervisor, nombre_completo, puesto
                FROM jerarquia
                ORDER BY numero_empleado;
            """, (f'%{filtro}%',))

            empleados = cur.fetchall()
            cur.close()
            conn.close()

    return render_template('jerarquia.html', empleados=empleados, filtro=filtro)

@app.route('/dashboard')
def dashboard():
    conn = get_db_connection()
    cur = conn.cursor()

    # Consulta 1
    cur.execute('''
        SELECT
            s.estado AS sucursal,
            EXTRACT(MONTH FROM v.fecha_venta) AS mes,
            SUM(v.monto_total) AS ingresos_mensuales
        FROM public."VENTA" v
        JOIN public."SUCURSAL" s ON v."id_sucursal_SUCURSAL" = s.id_sucursal
        WHERE EXTRACT(YEAR FROM v.fecha_venta) = 2025
        GROUP BY s.estado, mes
        ORDER BY s.estado, mes;
    ''')
    rows1 = cur.fetchall()

    ingresos = {}
    for sucursal, mes, monto in rows1:
        if sucursal not in ingresos:
            ingresos[sucursal] = [0] * 12
        ingresos[sucursal][int(mes) - 1] = float(monto)

    # Consulta 2
    cur.execute('''
        SELECT
            c.nombre_categoria,
            SUM(dv.monto_por_articulo) AS ingresos_por_categoria
        FROM public."DETALLE_VENTA" dv
        JOIN public."ARTICULO" a ON dv."codigo_de_barras_ARTICULO" = a.codigo_de_barras
        JOIN public."CATEGORIA" c ON a."id_categoria_CATEGORIA" = c.id_categoria
        GROUP BY c.nombre_categoria
        ORDER BY ingresos_por_categoria DESC;
    ''')
    rows2 = cur.fetchall()
    categorias = [r[0] for r in rows2]
    ingresos_categorias = [float(r[1]) for r in rows2]

    cur.close()
    conn.close()


    return render_template("dashboard.html",
    ingresos=json.dumps(ingresos),
    categorias=json.dumps(categorias),
    ingresos_categorias=json.dumps(ingresos_categorias)
)

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        usuario = request.form['username']
        clave = request.form['password']

        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('SELECT password FROM "USUARIO" WHERE username = %s', (usuario,))
        resultado = cur.fetchone()
        cur.close()
        conn.close()

        print("Usuario:", usuario)
        print("Resultado:", resultado)

        if resultado and resultado[0] == clave:
            session['usuario'] = usuario
            flash(f'Bienvenido, {usuario}', 'success')
            return redirect(url_for('index'))
        else:
            flash('Credenciales incorrectas', 'danger')
            return redirect(url_for('login'))
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.pop('usuario', None)
    flash('Sesión cerrada correctamente.', 'info')
    return redirect(url_for('login'))




if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
