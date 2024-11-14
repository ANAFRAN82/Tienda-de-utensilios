document.addEventListener('DOMContentLoaded', function() {
    // Función para actualizar la cantidad de productos en el enlace del carrito
    function updateCartLink() {
        const cartLink = document.getElementById('cart-link'); 
        const cart = JSON.parse(localStorage.getItem('cart')) || []; 
        const totalItems = cart.reduce((total, item) => total + item.cantidad, 0); 
        cartLink.textContent = `Ver Carrito (${totalItems})`; 

        if (totalItems === 0) {
            cartLink.style.display = 'none'; 
        } else {
            cartLink.style.display = 'inline'; 
        }
    }

    // Evento de clic para agregar productos al carrito
    document.querySelectorAll('.agregar-carrito').forEach(button => {
        button.addEventListener('click', function() {
            const imagen = this.parentElement.querySelector('img').getAttribute('src'); 
            const precio = parseFloat(this.dataset.precio); 
            const titulo = this.parentElement.querySelector('h2').innerText; 

            let cart = JSON.parse(localStorage.getItem('cart')) || []; // Obtener el carrito del almacenamiento local o un array vacío

            const product = cart.find(item => item.titulo === titulo); // Buscar el producto en el carrito por su título

            if (product) {
                product.cantidad++; // Incrementar la cantidad si el producto ya está en el carrito
            } else {
                cart.push({ imagen, precio, titulo, cantidad: 1 }); // Agregar el producto al carrito si no está en él
            }

            localStorage.setItem('cart', JSON.stringify(cart)); // Guardar el carrito actualizado en el almacenamiento local

            // Actualizar la cantidad de productos en el enlace del carrito
            updateCartLink();
        });
    });

    // Llamar a la función para actualizar la cantidad de productos en el enlace del carrito
    updateCartLink(); // Actualizar el enlace del carrito al cargar la página
});



