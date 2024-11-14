document.addEventListener('DOMContentLoaded', function() {
    const carritoItemsContainer = document.getElementById('carrito-items'); 
    const totalAPagarContainer = document.getElementById('total-a-pagar'); 

    let cart = []; // Array para almacenar los elementos del carrito

    // Función para cargar el carrito desde el almacenamiento local y mostrar los elementos
    function cargarCarrito() {
        carritoItemsContainer.innerHTML = ''; // Limpia el contenido del contenedor del carrito
        cart = getCartFromLocalStorage(); // Obtiene el carrito del almacenamiento local

        if (cart.length === 0) {
            carritoItemsContainer.innerHTML = '<p>El carrito está vacío</p>'; 
            totalAPagarContainer.innerText = 'Total a Pagar: $0'; 
        }

        cart.forEach(item => {
            renderizarItem(item); // Renderiza cada elemento del carrito
        });

        mostrarTotalAPagar(); 
    }

    // Función para renderizar un elemento del carrito
    function renderizarItem(item) {
        const itemDiv = document.createElement('div'); // Crea un contenedor div para el elemento del carrito
        itemDiv.classList.add('carrito-item'); // Añade una clase al div
        itemDiv.innerHTML = `
            <img src="${item.imagen}" alt="${item.titulo}"> <!-- Imagen del producto -->
            <h3>${item.titulo}</h3> <!-- Título del producto -->
            <p>Precio Caja: $${item.precio}</p> <!-- Precio por caja del producto -->
            <p>Precio Total: $${calcularPrecioTotal(item)}</p> <!-- Precio total del producto -->
            <div>Cantidad: <input type="number" class="cantidad" value="${item.cantidad}" min="1" max="${item.existencias}" data-titulo="${item.titulo}" data-existencias="${item.existencias}"></div> <!-- Input para la cantidad del producto -->
            <button class="actualizar" data-titulo="${item.titulo}">Actualizar</button> <!-- Botón para actualizar la cantidad -->
        `;
        carritoItemsContainer.appendChild(itemDiv); // Añade el div del producto al contenedor del carrito
    }

    // Función para calcular el precio total de un producto
    function calcularPrecioTotal(item) {
        return item.precio * item.cantidad; // Multiplica el precio por la cantidad
    }

    // Función para mostrar el total a pagar
    function mostrarTotalAPagar() {
        const total = cart.reduce((acc, item) => acc + calcularPrecioTotal(item), 0); // Suma el precio total de todos los productos en el carrito
        totalAPagarContainer.innerText = `Total a Pagar: $${total}`; // Muestra el total a pagar
    }

    // Función para modificar la cantidad de un producto en el carrito
    function modificarCantidad(titulo, cantidad) {
        const product = cart.find(item => item.titulo === titulo); // Encuentra el producto en el carrito por su título

        if (product) {
            const existencias = product.existencias;
            const stockMinimo = 0; // Establece la cantidad mínima permitida en 1
            const stockMaximo = existencias;

            if (cantidad < stockMinimo) {
                alert(`La cantidad mínima permitida es ${stockMinimo}.`); 
                return;
            }

            if (cantidad > stockMaximo) {
                alert(`La cantidad no puede exceder las existencias disponibles. Existencias disponibles: ${existencias}.`); // Alerta si la cantidad excede las existencias
                return;
            }

            product.cantidad = cantidad; // Actualiza la cantidad del producto

            if (product.cantidad <= 0) {
                removeProductFromCart(titulo); // Remueve el producto del carrito si la cantidad es 0 o menor
            }

            saveCartToLocalStorage(cart); // Guarda el carrito actualizado en el almacenamiento local
            cargarCarrito(); // Recarga el carrito para reflejar los cambios
        }
    }

    // Función para manejar el clic en los botones de actualizar
    function handleButtonClick(event) {
        const target = event.target;
        if (target.classList.contains('actualizar')) {
            const titulo = target.getAttribute('data-titulo'); 
            const inputElement = target.previousElementSibling.querySelector('.cantidad'); 
            const nuevaCantidad = parseInt(inputElement.value); 

            if (!isNaN(nuevaCantidad)) {
                modificarCantidad(titulo, nuevaCantidad); 
            } else {
                alert("Por favor ingrese una cantidad válida."); 
            }
        }
    }

    // Función para obtener el carrito desde el almacenamiento local
    function getCartFromLocalStorage() {
        return JSON.parse(localStorage.getItem('cart')) || []; // Retorna el carrito o un array vacío si no existe
    }

    // Función para guardar el carrito en el almacenamiento local
    function saveCartToLocalStorage(cart) {
        localStorage.setItem('cart', JSON.stringify(cart)); // Guarda el carrito como una cadena JSON
    }

    // Función para remover un producto del carrito
    function removeProductFromCart(titulo) {
        cart = cart.filter(item => item.titulo !== titulo); // Filtra el carrito para remover el producto con el título dado
        saveCartToLocalStorage(cart); // Guarda el carrito actualizado en el almacenamiento local
    }

    cargarCarrito(); // Carga el carrito cuando se carga el DOM

    carritoItemsContainer.addEventListener('click', handleButtonClick); // Añade el evento de clic al contenedor del carrito

    // Redirigir a la página de confirmación de compra
    const confirmarCompraBtn = document.getElementById('confirmar-compra');
    if (confirmarCompraBtn) {
        confirmarCompraBtn.addEventListener('click', function() {
            window.location.href = 'confirmacion.html'; // Redirige a la página de confirmación
        });
    }
});


