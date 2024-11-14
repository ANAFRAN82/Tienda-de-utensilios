// Función para generar el PDF del ticket
function generarPDF(nombre, apellido, direccion, ciudad, email, telefono, cart, total) {
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();

    // Fondo coloreado para el encabezado
    doc.setFillColor(47, 167, 212); 
    doc.rect(0, 0, 210, 30, 'F'); 

    // Título del documento
    doc.setFont('helvetica', 'bold'); 
    doc.setFontSize(24); 
    doc.setTextColor(255); 
    doc.text('Ticket de Compra', 105, 20, { align: 'center' }); 

    // Detalles del cliente
    doc.setFont('helvetica', 'normal'); 
    doc.setFontSize(14); 
    doc.setTextColor(0); 
    doc.text(`Nombre: ${nombre} ${apellido}`, 20, 40); 
    doc.text(`Dirección: ${direccion}, ${ciudad}`, 20, 50); 
    doc.text(`Email: ${email}`, 20, 60); 
    doc.text(`Teléfono: ${telefono}`, 20, 70); 

    // Listado de productos
    doc.setFont('helvetica', 'bold'); 
    doc.setFontSize(18); 
    doc.setTextColor(47, 167, 212); 
    doc.text('Productos:', 20, 90); 

    doc.setFont('helvetica', 'normal'); 
    doc.setFontSize(12); 
    let yPos = 100; // Posición vertical inicial para la lista de productos
    cart.forEach((item, index) => {
        let precioTotal = (item.precio * item.cantidad).toFixed(2); // Calcula el precio total del producto
        doc.text(`${index + 1}. ${item.titulo} - Cantidad: ${item.cantidad} - Precio: $${precioTotal}`, 20, yPos); // Agrega la información del producto
        yPos += 10; // Incrementa la posición vertical para el siguiente producto
    });

    // Total a pagar
    doc.setFont('helvetica', 'bold'); 
    doc.setFontSize(16); 
    doc.setTextColor(47, 167, 212); 
    doc.text(`Total a pagar: $${total.toFixed(2)}`, 20, yPos + 10); // Agrega el total a pagar

    // Guardar el documento como PDF y descargarlo
    doc.save('ticket.pdf'); // Guarda y descarga el PDF con el nombre 'ticket.pdf'
}

// Espera a que el contenido del DOM esté completamente cargado
document.addEventListener('DOMContentLoaded', function() {
    const productosCarritoContainer = document.getElementById('productos-carrito');
    const totalPagarContainer = document.getElementById('total-pagar'); 
    const formulario = document.getElementById('formulario-confirmacion'); 

    // Función para mostrar productos en el carrito
    function mostrarProductosCarrito() {
        const cart = JSON.parse(localStorage.getItem('cart')) || []; // Obtiene el carrito de la memoria local o un array vacío
        let total = 0;

        if (cart.length === 0) {
            productosCarritoContainer.innerHTML = '<p>No hay productos en el carrito</p>'; 
            totalPagarContainer.innerHTML = '';
            return;
        }

        let html = '<h2>Productos en el Carrito:</h2>';
        html += '<ul>';
        cart.forEach(item => {
            total += item.precio * item.cantidad; // Calcula el total sumando el precio de cada producto multiplicado por su cantidad
            html += `<li>${item.titulo} - Cantidad: ${item.cantidad} - Precio: $${(item.precio * item.cantidad).toFixed(2)}</li>`; // Agrega cada producto a la lista HTML
        });
        html += '</ul>';
        productosCarritoContainer.innerHTML = html; // Inserta la lista de productos en el contenedor
        totalPagarContainer.innerHTML = `Total a pagar: $${total.toFixed(2)}`; // Muestra el total a pagar
    }

    mostrarProductosCarrito(); // Llama a la función para mostrar los productos en el carrito

    // Evento de envío del formulario
    formulario.addEventListener('submit', function(event) {
        event.preventDefault(); // Previene el envío del formulario por defecto

        // Obtiene los valores de los campos del formulario
        const nombre = document.getElementById('nombre').value;
        const apellido = document.getElementById('apellido').value;
        const direccion = document.getElementById('direccion').value;
        const ciudad = document.getElementById('ciudad').value;
        const email = document.getElementById('email').value;
        const telefono = document.getElementById('telefono').value;

        const cart = JSON.parse(localStorage.getItem('cart')) || []; // Obtiene el carrito de la memoria local o un array vacío
        let total = 0;

        cart.forEach((producto) => {
            total += producto.precio * producto.cantidad; // Calcula el total sumando el precio de cada producto multiplicado por su cantidad
        });

        // Realizar la solicitud AJAX al servidor (procesar_compra.php)
        const formData = new FormData(); 
        formData.append('nombre', nombre); 
        formData.append('apellido', apellido);
        formData.append('direccion', direccion); 
        formData.append('ciudad', ciudad); 
        formData.append('email', email); 
        formData.append('telefono', telefono); 
        formData.append('total', total.toFixed(2)); 

        cart.forEach((producto, index) => {
            formData.append(`producto${index}`, JSON.stringify(producto)); 
        });

        // Envía los datos del formulario al servidor usando fetch
        fetch('procesar_compra.php', {
            method: 'POST', 
            body: formData 
        })
        .then(response => response.text()) // Convierte la respuesta a texto
        .then(data => {
            if (data.includes("¡Gracias por su compra!")) {
                // Generar el PDF del ticket solo si la compra fue exitosa
                generarPDF(nombre, apellido, direccion, ciudad, email, telefono, cart, total); // Llama a la función para generar el PDF del ticket
                alert(data); 
                localStorage.removeItem('cart'); // Limpia el carrito después de la compra
            } else {
                alert(data); 
            }
        })
        .catch(error => {
            console.error('Error al procesar la compra:', error); 
            alert('Hubo un error al procesar la compra. Por favor, inténtalo de nuevo.'); 
        });
    });
});
