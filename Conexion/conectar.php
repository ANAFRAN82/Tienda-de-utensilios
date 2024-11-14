<?php
$servidor = "localhost";
$usuario = "root";
$contrasenia = "02351236";
$bd = "utencilios";

$conn = mysqli_connect($servidor, $usuario, $contrasenia, $bd);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

mysqli_set_charset($conn, "utf8");
?>
