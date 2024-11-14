<?php
$servidor = "localhost";
$usuario = "root";
$contrasenia = "02351236";
$bd = "utencilios";

$conn = mysqli_connect($servidor, $usuario, $contrasenia, $bd);

if (!$conn) {
    die("Conexión fallida: " . mysqli_connect_error());
}

// Consulta a la base de datos
$sql = "SELECT nombre, descripcion, Precio_por_Caja, id_Categoria, foto FROM productos WHERE id_Categoria = 1";
$result = $conn->query($sql);

$productos = [];
if ($result) {
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            $productos[] = $row;
        }
    }
} else {
    echo "Error en la consulta: " . $conn->error;
}

$conn->close();
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Platos al Mayoreo - Tienda de Utensilios de Cocina</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f3f3f3;
            color: #333;
        }

        header {
            background-color: #232f3e;
            color: #fff;
            padding: 20px 0;
            text-align: center;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
        }

        header h1 {
            margin: 0;
            font-size: 32px;
        }

        main {
            padding: 20px;
        }

        #detalle-producto {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            padding: 0 20px;
        }

        .producto {
            background-color: #fff;
            border-radius: 5px;
            padding: 20px;
            width: calc(25% - 40px);
            margin-bottom: 20px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
            box-sizing: border-box;
        }

        .producto:hover {
            transform: translateY(-5px);
        }

        .producto img {
            width: 80%;
            border-radius: 5px;
            margin-bottom: 10px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            display: block;
            margin: auto;
            object-fit: cover;
        }

        .producto h2 {
            margin: 0;
            font-size: 18px;
            color: #333;
            text-align: center;
            margin-bottom: 10px;
        }

        .producto p {
            margin: 10px 0;
            font-size: 16px;
            color: #555;
            text-align: center;
        }

        .producto button {
            background-color: #f0c14b;
            color: #111;
            border: none;
            border-radius: 3px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease-in-out;
            display: block;
            margin: 0 auto;
        }

        .producto button:hover {
            background-color: #ddb347;
        }

        .mayoreo {
            background-color: #f0f0f0;
            border: 1px solid #ccc;
            box-shadow: none;
        }

        .mayoreo h2 {
            color: #666;
        }

        .mayoreo p {
            color: #888;
            margin-bottom: 5px;
        }

        .mayoreo button {
            background-color: #666;
            color: #fff;
        }

        .mayoreo button:hover {
            background-color: #555;
        }

        #cart-link {
            color: #fff; /* Color del texto */
            text-decoration: none; /* Eliminar subrayado del enlace */
            padding: 10px 20px; /* Añadir espacio alrededor del texto */
            background-color: #f0c14b; /* Color de fondo del enlace */
            border-radius: 3px; /* Bordes redondeados */
            transition: background-color 0.3s ease-in-out; /* Transición suave al pasar el ratón */
        }
        
        #cart-link:hover {
            background-color: #ddb347; /* Cambio de color de fondo al pasar el ratón */
        }
    </style>
</head>
<body>
    <header>
        <h1>Platos</h1>
        <a href="cart.html" id="cart-link">Ver Carrito (0)</a>
    </header>

    <main>
        <section id="detalle-producto">
            <?php
            foreach ($productos as $producto) {
                echo '<div class="producto mayoreo">';
                echo '<img src="' . $producto['foto'] . '" alt="' . $producto['nombre'] . '">';
                echo '<h2>' . htmlspecialchars($producto['nombre']) . '</h2>';
                echo '<p>' . htmlspecialchars($producto['descripcion']) . '</p>';
                echo '<p>$' . htmlspecialchars($producto['Precio_por_Caja']) . ' por caja</p>';
                echo '<button class="agregar-carrito" data-precio="' . htmlspecialchars($producto['Precio_por_Caja']) . '">Agregar al carrito</button>';
                echo '</div>';
            }
            ?>
        </section>
    </main>

    <script src="js/script.js"></script>
</body>
</html>


