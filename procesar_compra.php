<?php
$servidor = "localhost"; 
$usuario = "root"; 
$contrasenia = "02351236"; 
$bd = "utencilios"; 

$conn = mysqli_connect($servidor, $usuario, $contrasenia, $bd);

if (!$conn) {
    die("Conexión fallida: " . mysqli_connect_error()); 
}

// Verificar si se recibieron datos del formulario
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Escapar los datos del formulario para prevenir inyecciones SQL
    $nombre = mysqli_real_escape_string($conn, $_POST["nombre"]);
    $apellido = mysqli_real_escape_string($conn, $_POST["apellido"]);
    $direccion = mysqli_real_escape_string($conn, $_POST["direccion"]);
    $ciudad = mysqli_real_escape_string($conn, $_POST["ciudad"]);
    $email = mysqli_real_escape_string($conn, $_POST["email"]);
    $telefono = mysqli_real_escape_string($conn, $_POST["telefono"]);
    $total = $_POST["total"];

    // Procesar cada producto del carrito
    $productos_validos = true;
    foreach ($_POST as $key => $value) {
        if (strpos($key, 'producto') === 0) {
            $producto = json_decode($value, true);

            if (isset($producto['titulo'])) {
                $producto_titulo = mysqli_real_escape_string($conn, $producto['titulo']);
                $cantidad = $producto['cantidad'];

                // Consultar las existencias actuales del producto
                $sql_info_producto = "SELECT id_Producto, Existencias FROM productos WHERE nombre = '$producto_titulo'";
                $resultado_info = mysqli_query($conn, $sql_info_producto);

                if ($row = mysqli_fetch_assoc($resultado_info)) {
                    $existencias_actuales = $row['Existencias'];

                    // Verificar si hay suficientes existencias
                    if ($existencias_actuales < $cantidad) {
                        $productos_validos = false;
                        break;
                    }
                } else {
                    $productos_validos = false;
                    break;
                }
            } else {
                $productos_validos = false;
                break;
            }
        }
    }

    if ($productos_validos) {
        // Insertar datos del cliente
        $sql_cliente = "INSERT INTO Clientes (Nombre, Apellido, Direccion, Ciudad, Correo_Electronico, Telefono)
                        VALUES ('$nombre', '$apellido', '$direccion', '$ciudad', '$email', '$telefono')";
        if (mysqli_query($conn, $sql_cliente)) {
            $cliente_id = mysqli_insert_id($conn); // Obtener el ID del cliente recién insertado

            // Insertar datos del pedido
            $fecha = date('Y-m-d');
            $sql_pedido = "INSERT INTO Pedidos (ID_Cliente, Fecha, Total)
                            VALUES ('$cliente_id', '$fecha', '$total')";
            if (mysqli_query($conn, $sql_pedido)) {
                $pedido_id = mysqli_insert_id($conn); // Obtener el ID del pedido recién insertado

                foreach ($_POST as $key => $value) {
                    if (strpos($key, 'producto') === 0) {
                        $producto = json_decode($value, true);
                        $producto_titulo = mysqli_real_escape_string($conn, $producto['titulo']);
                        $cantidad = $producto['cantidad'];
                        $precio = $producto['precio'];
                        $precio_total = $precio * $cantidad;

                        // Obtener información del producto
                        $sql_info_producto = "SELECT id_Producto, Existencias FROM productos WHERE nombre = '$producto_titulo'";
                        $resultado_info = mysqli_query($conn, $sql_info_producto);
                        if ($row = mysqli_fetch_assoc($resultado_info)) {
                            $id_producto = $row['id_Producto'];
                            $existencias_actuales = $row['Existencias'];

                            // Insertar detalles del pedido
                            $sql_detalle = "INSERT INTO Detalles_Pedido (ID_Pedido, ID_Producto, Cantidad_de_Cajas, Precio_por_Caja, Precio_Total)
                                            VALUES ('$pedido_id', '$id_producto', '$cantidad', '$precio', '$precio_total')";
                            if (mysqli_query($conn, $sql_detalle)) {
                                // Actualizar las existencias del producto
                                $nuevas_existencias = $existencias_actuales - $cantidad;
                                $sql_actualizar_existencias = "UPDATE productos SET Existencias = '$nuevas_existencias' WHERE id_Producto = '$id_producto'";
                                mysqli_query($conn, $sql_actualizar_existencias);
                            }
                        }
                    }
                }

                echo "¡Gracias por su compra! Su pedido ha sido procesado exitosamente.";
            } else {
                echo "Error al procesar el pedido: " . mysqli_error($conn);
            }
        } else {
            echo "Error al insertar datos del cliente: " . mysqli_error($conn);
        }
    } else {
        echo "Error: No hay suficientes existencias para uno o más productos.";
    }

    mysqli_close($conn); 
} else {
    echo "Error: No se recibieron datos del formulario.";
}
?>



