document.addEventListener('DOMContentLoaded', function () {
    let carrito = [];
    const carritoBtn = document.getElementById('carrito-btn');
    const carritoTicket = document.getElementById('carrito-ticket');
    const closeCarrito = document.getElementById('close-carrito');
    const carritoItems = document.getElementById('carrito-items');
    const carritoTotal = document.getElementById('carrito-total');
    const vaciarCarritoBtn = document.getElementById('vaciar-carrito');
    const carritoCount = document.querySelector('.carrito-count');
    const finalizarCompraBtn = document.querySelector('.carrito-buttons .btn:not(.btn-vaciar)');

    const searchInput = document.getElementById('search-input');
    const searchBtn = document.getElementById('search-btn');
    const productoCards = document.querySelectorAll('.producto-card');

    // Modal de pago
    const pagoModal = document.getElementById('pago-modal');
    const closePago = document.getElementById('close-pago');
    const cancelarPago = document.getElementById('cancelar-pago');
    const pagoForm = document.getElementById('pago-form');
    const metodoPagoRadios = document.querySelectorAll('input[name="metodo-pago"]');
    const tarjetaCampos = document.getElementById('tarjeta-campos');

    // Mostrar u ocultar el carrito
    carritoBtn.addEventListener('click', () => carritoTicket.classList.toggle('active'));
    closeCarrito.addEventListener('click', () => carritoTicket.classList.remove('active'));

    // Vaciar carrito
    vaciarCarritoBtn.addEventListener('click', vaciarCarrito);

    // Mostrar modal al finalizar compra
    finalizarCompraBtn.addEventListener('click', function () {
        if (carrito.length === 0) {
            alert('Tu carrito está vacío. Agrega productos antes de finalizar la compra.');
            return;
        }
        pagoModal.style.display = 'flex';
    });

    // Mostrar u ocultar campos de tarjeta según método de pago
    metodoPagoRadios.forEach(radio => {
        radio.addEventListener('change', () => {
            tarjetaCampos.style.display = (radio.value === 'tarjeta') ? 'block' : 'none';
        });
    });

    // Cerrar y cancelar modal de pago
    closePago.addEventListener('click', () => pagoModal.style.display = 'none');
    cancelarPago.addEventListener('click', () => pagoModal.style.display = 'none');

    // Procesar formulario de pago
    pagoForm.addEventListener('submit', function (e) {
        e.preventDefault();
        const metodo = document.querySelector('input[name="metodo-pago"]:checked').value;

        if (metodo === 'tarjeta') {
            const nombre = document.getElementById('nombre-tarjeta').value.trim();
            const cuenta = document.getElementById('numero-cuenta').value.trim();
            const rfc = document.getElementById('rfc').value.trim();

            if (!nombre || !cuenta || !rfc) {
                alert('Por favor completa todos los campos de tarjeta.');
                return;
            }
        }

        pagoModal.style.display = 'none';
        generarTicketTXT();
    });

    // Búsqueda de productos
    function buscarProductos() {
        const term = searchInput.value.trim().toLowerCase();
        productoCards.forEach(card => {
            const nombre = card.querySelector('h3').textContent.toLowerCase();
            const descripcion = card.querySelector('p').textContent.toLowerCase();
            card.style.display = (nombre.includes(term) || descripcion.includes(term)) ? 'block' : 'none';
        });
    }

    searchBtn.addEventListener('click', buscarProductos);
    searchInput.addEventListener('keyup', e => {
        if (e.key === 'Enter') buscarProductos();
    });

    // Añadir productos al carrito
    document.querySelectorAll('.btn-anadir:not([disabled])').forEach(button => {
        button.addEventListener('click', function () {
            const productoCard = button.closest('.producto-card');
            const id = productoCard.querySelector('h3').textContent.replace(/\s+/g, '-').toLowerCase();
            const nombre = productoCard.querySelector('h3').textContent;
            const precio = parseFloat(productoCard.querySelector('.producto-precio').textContent.replace('$', '').replace(',', ''));
            const imagen = productoCard.querySelector('.producto-imagen').src;

            const existente = carrito.find(item => item.id === id);
            if (existente) {
                existente.cantidad++;
            } else {
                carrito.push({ id, nombre, precio, imagen, cantidad: 1 });
            }

            actualizarCarrito();
            carritoTicket.classList.add('active');
        });
    });

    // Actualizar carrito
    function actualizarCarrito() {
        carritoItems.innerHTML = '';
        if (carrito.length === 0) {
            carritoItems.innerHTML = '<p class="carrito-vacio">Tu carrito está vacío</p>';
            carritoTotal.innerHTML = '<span>Total:</span><span>$0.00</span>';
            carritoCount.textContent = '0';
            return;
        }

        let total = 0, totalItems = 0;
        carrito.forEach(item => {
            const itemTotal = item.precio * item.cantidad;
            total += itemTotal;
            totalItems += item.cantidad;

            const carritoItem = document.createElement('div');
            carritoItem.classList.add('carrito-item');
            carritoItem.innerHTML = `
                <img src="${item.imagen}" alt="${item.nombre}" class="carrito-item-img">
                <div class="carrito-item-info">
                    <div class="carrito-item-nombre">${item.nombre}</div>
                    <div class="carrito-item-precio">$${item.precio.toFixed(2)}</div>
                    <div class="carrito-item-cantidad">
                        <button class="disminuir" data-id="${item.id}">-</button>
                        <input type="number" value="${item.cantidad}" min="1" data-id="${item.id}">
                        <button class="aumentar" data-id="${item.id}">+</button>
                    </div>
                </div>
            `;
            carritoItems.appendChild(carritoItem);
        });

        carritoTotal.innerHTML = `<span>Total:</span><span>$${total.toFixed(2)}</span>`;
        carritoCount.textContent = totalItems;

        document.querySelectorAll('.disminuir').forEach(btn => {
            btn.addEventListener('click', function () {
                const id = btn.getAttribute('data-id');
                const item = carrito.find(item => item.id === id);
                item.cantidad > 1 ? item.cantidad-- : carrito = carrito.filter(p => p.id !== id);
                actualizarCarrito();
            });
        });

        document.querySelectorAll('.aumentar').forEach(btn => {
            btn.addEventListener('click', function () {
                const id = btn.getAttribute('data-id');
                carrito.find(item => item.id === id).cantidad++;
                actualizarCarrito();
            });
        });

        document.querySelectorAll('.carrito-item-cantidad input').forEach(input => {
            input.addEventListener('change', function () {
                const id = input.getAttribute('data-id');
                const item = carrito.find(item => item.id === id);
                const nuevaCantidad = parseInt(input.value);
                item.cantidad = nuevaCantidad >= 1 ? nuevaCantidad : 1;
                actualizarCarrito();
            });
        });
    }

    function vaciarCarrito() {
        carrito = [];
        actualizarCarrito();
    }

    function generarTicketTXT() {
        let contenido = `=== TICKET DE COMPRA ===\n\n`;
        contenido += `MADERNO - Muebles minimalistas\n`;
        contenido += `Fecha: ${new Date().toLocaleString()}\n\n`;
        contenido += `PRODUCTOS:\n`;

        let total = 0;
        carrito.forEach(item => {
            const itemTotal = item.precio * item.cantidad;
            total += itemTotal;
            contenido += `- ${item.nombre} (${item.cantidad} x $${item.precio.toFixed(2)}) = $${itemTotal.toFixed(2)}\n`;
        });

        contenido += `\nTOTAL: $${total.toFixed(2)}\n`;
        contenido += `Gracias por su compra!\nwww.maderno.com`;

        const blob = new Blob([contenido], { type: 'text/plain' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `ticket-maderno-${new Date().getTime()}.txt`;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);

        vaciarCarrito();
        alert('Compra finalizada con éxito. Se ha descargado el ticket.');
    }

    // Menú desplegable en móvil
    const dropdowns = document.querySelectorAll('.dropdown');
    if (window.innerWidth <= 768) {
        dropdowns.forEach(dropdown => {
            const link = dropdown.querySelector('a');
            link.addEventListener('click', function (e) {
                e.preventDefault();
                dropdown.classList.toggle('active');
            });
        });
    }
});
