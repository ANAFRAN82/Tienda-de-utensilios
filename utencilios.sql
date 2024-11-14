/*
 Navicat Premium Data Transfer

 Source Server         : TBase de Datos
 Source Server Type    : MySQL
 Source Server Version : 50130 (5.1.30-community-log)
 Source Host           : localhost:3306
 Source Schema         : utencilios

 Target Server Type    : MySQL
 Target Server Version : 50130 (5.1.30-community-log)
 File Encoding         : 65001

 Date: 19/06/2024 01:17:19
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for categorias
-- ----------------------------
DROP TABLE IF EXISTS `categorias`;
CREATE TABLE `categorias`  (
  `id_Categoria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_Categoria`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of categorias
-- ----------------------------
INSERT INTO `categorias` VALUES (1, 'Platos');
INSERT INTO `categorias` VALUES (2, 'Cubiertos');
INSERT INTO `categorias` VALUES (3, 'Vasos');
INSERT INTO `categorias` VALUES (4, 'Sartenes');
INSERT INTO `categorias` VALUES (5, 'Ollas');

-- ----------------------------
-- Table structure for clientes
-- ----------------------------
DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes`  (
  `ID_Cliente` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Apellido` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Direccion` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Ciudad` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Correo_Electronico` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Telefono` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_Cliente`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of clientes
-- ----------------------------
INSERT INTO `clientes` VALUES (1, 'Ana', 'Franco', 'Soyaniquilpan', 'Mexico', 'cris832fran@gmail.com', '5569786312');
INSERT INTO `clientes` VALUES (2, 'Debora', 'Cruz', 'San Pablo', 'Mexico', 'devo123@gmail.com', '5578367896');
INSERT INTO `clientes` VALUES (3, 'Sofia', 'Franco', 'Soyaniquilpan', 'Mexico', 'sofi.56@gmail.com', '5578367896');
INSERT INTO `clientes` VALUES (4, 'Cristina', 'Franco', 'Soyaniquilpan', 'Mexico', 'crisfranco@gmail.com', '5578367896');
INSERT INTO `clientes` VALUES (5, 'Debora', 'Garcia', 'San Pablo', 'Mexico', 'devo123@gmail.com', '5578367896');
INSERT INTO `clientes` VALUES (6, 'Ambar', 'Cruz', 'Jilotepec', 'Mexico', 'devo123@gmail.com', '5569786312');
INSERT INTO `clientes` VALUES (7, 'Ana', 'Garcia', 'Soyaniquilpan', 'Mexico', 'devo123@gmail.com', '5578367896');
INSERT INTO `clientes` VALUES (8, 'Sofia', 'Cruz', 'Soyaniquilpan', 'Mexico', 'devo123@gmail.com', '8569741236');
INSERT INTO `clientes` VALUES (9, 'Felix', 'Franco', 'Soyaniquilpan', 'Mexico', 'devo123@gmail.com', '5569786312');
INSERT INTO `clientes` VALUES (10, 'Ana', 'Gonzalez', 'Jilotepec', 'Mexico', 'cris832fran@gmail.com', '5569786312');
INSERT INTO `clientes` VALUES (11, 'Debora', 'Garcia', 'Jilotepec', 'Mexico', 'devo123@gmail.com', '5569786312');
INSERT INTO `clientes` VALUES (12, 'Liz', 'Franco', 'Soyaniquilpan', 'Mexico', 'cris832fran@gmail.com', '7736853610');

-- ----------------------------
-- Table structure for detalles_pedido
-- ----------------------------
DROP TABLE IF EXISTS `detalles_pedido`;
CREATE TABLE `detalles_pedido`  (
  `ID_detallePedido` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Pedido` int(11) NULL DEFAULT NULL,
  `ID_Producto` int(11) NULL DEFAULT NULL,
  `Cantidad_de_Cajas` int(11) NULL DEFAULT NULL,
  `Precio_por_Caja` decimal(10, 2) NULL DEFAULT NULL,
  `Precio_Total` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_detallePedido`) USING BTREE,
  INDEX `ID_Pedido`(`ID_Pedido`) USING BTREE,
  INDEX `ID_Producto`(`ID_Producto`) USING BTREE,
  CONSTRAINT `detalles_pedido_ibfk_1` FOREIGN KEY (`ID_Pedido`) REFERENCES `pedidos` (`ID_Pedido`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `detalles_pedido_ibfk_2` FOREIGN KEY (`ID_Producto`) REFERENCES `productos` (`id_Producto`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of detalles_pedido
-- ----------------------------
INSERT INTO `detalles_pedido` VALUES (1, 11, 35, 1, 1500.00, 1500.00);
INSERT INTO `detalles_pedido` VALUES (2, 12, 19, 2, 800.00, 1600.00);

-- ----------------------------
-- Table structure for pedidos
-- ----------------------------
DROP TABLE IF EXISTS `pedidos`;
CREATE TABLE `pedidos`  (
  `ID_Pedido` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Cliente` int(11) NULL DEFAULT NULL,
  `Fecha` date NULL DEFAULT NULL,
  `Total` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_Pedido`) USING BTREE,
  INDEX `ID_Cliente`(`ID_Cliente`) USING BTREE,
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`ID_Cliente`) REFERENCES `clientes` (`ID_Cliente`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of pedidos
-- ----------------------------
INSERT INTO `pedidos` VALUES (1, 1, '2024-06-14', 480.00);
INSERT INTO `pedidos` VALUES (2, 2, '2024-06-14', 700.00);
INSERT INTO `pedidos` VALUES (3, 3, '2024-06-14', 1000.00);
INSERT INTO `pedidos` VALUES (4, 4, '2024-06-14', 1500.00);
INSERT INTO `pedidos` VALUES (5, 5, '2024-06-14', 600.00);
INSERT INTO `pedidos` VALUES (6, 6, '2024-06-14', 600.00);
INSERT INTO `pedidos` VALUES (7, 7, '2024-06-15', 600.00);
INSERT INTO `pedidos` VALUES (8, 8, '2024-06-16', 500.00);
INSERT INTO `pedidos` VALUES (9, 9, '2024-06-16', 500.00);
INSERT INTO `pedidos` VALUES (10, 10, '2024-06-16', 1600.00);
INSERT INTO `pedidos` VALUES (11, 11, '2024-06-16', 1500.00);
INSERT INTO `pedidos` VALUES (12, 12, '2024-06-16', 1600.00);

-- ----------------------------
-- Table structure for productos
-- ----------------------------
DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos`  (
  `id_Producto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `descripcion` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `Precio_por_Caja` decimal(10, 2) NULL DEFAULT NULL,
  `Stock_Minimo` int(11) NULL DEFAULT NULL,
  `Stock_Maximo` int(11) NULL DEFAULT NULL,
  `Existencias` int(11) NULL DEFAULT NULL,
  `id_Categoria` int(11) NULL DEFAULT NULL,
  `foto` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_Producto`) USING BTREE,
  INDEX `id_Categoria`(`id_Categoria`) USING BTREE,
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_Categoria`) REFERENCES `categorias` (`id_Categoria`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of productos
-- ----------------------------
INSERT INTO `productos` VALUES (1, 'Vajilla de Platos de Paja de Trigo', 'Vajilla de platos de paja de trigo de 16 unidades', 400.00, 10, 100, 51, 1, 'resources/fotos_productos/platosPaja.jpg');
INSERT INTO `productos` VALUES (2, 'Vajilla de Melamina Moderna', 'Vajilla de melamina moderna de 12 unidades', 600.00, 10, 100, 50, 1, 'resources/fotos_productos/platosMelemina.jpg');
INSERT INTO `productos` VALUES (3, 'Vajilla de Gres Moderna', 'Vajilla de gres moderna de 16 unidades', 600.00, 10, 100, 50, 1, 'resources/fotos_productos/platosGres.jpg');
INSERT INTO `productos` VALUES (4, 'Vajilla Rockaway redonda de cerámica ', 'Vajilla Rockaway redonda de cerámica de 12 unidades', 1000.00, 10, 100, 50, 1, 'resources/fotos_productos/platosRockaway.jpg');
INSERT INTO `productos` VALUES (5, 'Vajilla de cerámica Absolute Black', 'Vajilla de cerámica Absolute Black de 12 unidades', 1300.00, 10, 100, 50, 1, 'resources/fotos_productos/platosAbsolute.jpg');
INSERT INTO `productos` VALUES (6, 'Vajilla de cerámica de gres', 'Vajilla de cerámica de gres de 12 unidades', 1200.00, 10, 100, 50, 1, 'resources/fotos_productos/platosCeramicaGres.jpg');
INSERT INTO `productos` VALUES (7, 'Vajilla de vidrio Corelle', 'Vajilla de vidrio Corelle de 16 unidades', 1500.00, 10, 100, 50, 1, 'resources/fotos_productos/platosVidrio.jpg');
INSERT INTO `productos` VALUES (8, 'Juego de Cubiertos de Acero Inoxidable', 'Juego de cubiertos de acero inoxidable de 24 unidades', 300.00, 10, 100, 50, 2, 'resources/fotos_productos/utencilioAcero.jpg');
INSERT INTO `productos` VALUES (9, 'Juego de cubiertos de acero inoxidable Negro', 'Juego de cubiertos de acero inoxidable negro de 40 unidades', 480.00, 10, 100, 50, 2, 'resources/fotos_productos/utencilioAceroNegro.jpg');
INSERT INTO `productos` VALUES (10, 'Juego de Cubiertos de Titanio Plata Plateado', 'Juego de cubiertos de titanio plata plateado de 30 unidades', 750.00, 10, 100, 50, 2, 'resources/fotos_productos/utencilioTitanioPlata.jpg');
INSERT INTO `productos` VALUES (11, 'Juego de cubiertos modernos de martill en titanio Negro ', 'Juego de cubiertos modernos de martill en titanio negro de 16 unidades', 800.00, 10, 100, 50, 2, 'resources/fotos_productos/utenciliosModernosMartill.jpg');
INSERT INTO `productos` VALUES (12, 'Juego de Cubiertos de Acero Inoxidable Oro', 'Juego de cubiertos de acero inoxidable oro de 30 unidades', 200.00, 10, 100, 50, 2, 'resources/fotos_productos/UtencilioAceroOro.jpg');
INSERT INTO `productos` VALUES (13, 'Juego de Cubiertos de Acero Inoxidable Oro y Negro', 'Juego de cubiertos de acero inoxidable oro y negro de 24 unidades', 300.00, 10, 100, 50, 2, 'resources/fotos_productos/utencilioAceroOroYNegro.jpg');
INSERT INTO `productos` VALUES (14, 'Juego de Cubiertos Navideños Plateado', 'Juego de cubiertos navideños plateado de 45 unidades', 400.00, 10, 100, 50, 2, 'resources/fotos_productos/utenciliosNavide.jpg');
INSERT INTO `productos` VALUES (15, 'Juego de Cubiertos de Acero Inoxidable Oro rosa ', 'Juego de cubiertos de acero inoxidable oro rosa de 24 unidades', 330.00, 10, 100, 50, 2, 'resources/fotos_productos/utenciliosOroRosa.jpg');
INSERT INTO `productos` VALUES (16, 'Juego de Vasos de Vidrio Francés', 'Juego de vasos de vidrio francés de 6 unidades', 300.00, 10, 100, 50, 3, 'resources/fotos_productos/vidrioFrances.jpg');
INSERT INTO `productos` VALUES (17, 'Juego de Vasos de Vidrio Cabos', 'Juego de vasos de vidrio Cabos de 467 ml y 319 ml de 16 unidades', 700.00, 10, 100, 50, 3, 'resources/fotos_productos/vidrioCabos.jpg');
INSERT INTO `productos` VALUES (18, 'Vasos de Vidrio Modernos', 'Vasos de vidrio modernos de 16 unidades', 500.00, 10, 100, 50, 3, 'resources/fotos_productos/vidrioModernos.jpg');
INSERT INTO `productos` VALUES (19, 'Vasos de Vidrio Stonehenge', 'Vasos de vidrio Stonehenge de 290 ml, 377 ml y 477 ml de 30 unidades', 800.00, 10, 100, 48, 3, 'resources/fotos_productos/VidrioStonehenge.jpg');
INSERT INTO `productos` VALUES (20, 'Juego de Vasos de Vidrio Soplado', 'Juego de vasos de vidrio soplado de 355 ml de 6 unidades', 1000.00, 10, 100, 50, 3, 'resources/fotos_productos/vidrioSoplado.jpg');
INSERT INTO `productos` VALUES (21, 'Juego de vasos altos', 'Juego de vasos altos de 12 onzas de 8 unidades', 900.00, 10, 100, 50, 3, 'resources/fotos_productos/vassosAltos.jpg');
INSERT INTO `productos` VALUES (22, 'Juego de Vasos Samba de Vidrio', 'Juego de vasos Samba de vidrio de 547 ml y 414 ml de 16 unidades', 700.00, 10, 100, 50, 3, 'resources/fotos_productos/sambaVidrio.jpg');
INSERT INTO `productos` VALUES (23, 'Juego de cristalería mixta', 'Juego de cristalería mixta de 12 unidades', 830.00, 10, 100, 50, 3, 'resources/fotos_productos/cristaleria.jpg');
INSERT INTO `productos` VALUES (24, 'Sartén de Acero Inoxidable ', 'Sartén de acero inoxidable de 10 unidades', 1200.00, 10, 100, 50, 4, 'resources/fotos_productos/acero.jpg');
INSERT INTO `productos` VALUES (25, 'Sartén de Hierro Fundido', 'Sartén de hierro fundido de 10 unidades', 1500.00, 10, 100, 50, 4, 'resources/fotos_productos/fundido.jpg');
INSERT INTO `productos` VALUES (26, 'Sartén de Teflón Antiadherente', 'Sartén de teflón antiadherente de 10 unidades', 1000.00, 10, 100, 50, 4, 'resources/fotos_productos/teflon.jpg');
INSERT INTO `productos` VALUES (27, 'Sartén de Cerámica', 'Sartén de cerámica de 10 unidades', 1300.00, 10, 100, 50, 4, 'resources/fotos_productos/ceramica.jpg');
INSERT INTO `productos` VALUES (28, 'Sartén de Cobre', 'Sartén de cobre de 10 unidades', 1600.00, 10, 100, 50, 4, 'resources/fotos_productos/cobre.jpg');
INSERT INTO `productos` VALUES (29, 'Sartén de Granito', 'Sartén de granito de 10 unidades', 1400.00, 10, 100, 50, 4, 'resources/fotos_productos/granito.jpg');
INSERT INTO `productos` VALUES (30, 'Sartén de Mármol', 'Sartén de mármol de 10 unidades', 1700.00, 10, 100, 50, 4, 'resources/fotos_productos/marmol.jpg');
INSERT INTO `productos` VALUES (31, 'Sartén de Aluminio', 'Sartén de aluminio de 10 unidades', 1100.00, 10, 100, 50, 4, 'resources/fotos_productos/aluminio.jpg');
INSERT INTO `productos` VALUES (32, 'Sartén de Titanio', 'Sartén de titanio de 10 unidades', 1800.00, 10, 100, 50, 4, 'resources/fotos_productos/titanio.jpg');
INSERT INTO `productos` VALUES (33, 'Sartén Esmaltado', 'Sartén esmaltado de 10 unidades', 1500.00, 10, 100, 50, 4, 'resources/fotos_productos/esmaltado.jpg');
INSERT INTO `productos` VALUES (34, 'Olla de Acero Inoxidable', 'Olla de acero inoxidable de 10 unidades', 1200.00, 10, 100, 50, 5, 'resources/fotos_productos/AceroOlla.jpg');
INSERT INTO `productos` VALUES (35, 'Olla de Hierro Fundido', 'Olla de hierro fundido de 10 unidades', 1500.00, 10, 100, 49, 5, 'resources/fotos_productos/hierroO.jpg');
INSERT INTO `productos` VALUES (36, 'Olla de Teflón Antiadherente', 'Olla de teflón antiadherente de 10 unidades', 1000.00, 10, 100, 50, 5, 'resources/fotos_productos/teflonO.jpg');
INSERT INTO `productos` VALUES (37, 'Olla de Cerámica', 'Olla de cerámica de 10 unidades', 1300.00, 10, 100, 50, 5, 'resources/fotos_productos/ceramicaO.jpg');
INSERT INTO `productos` VALUES (38, 'Olla de Cobre', 'Olla de cobre de 10 unidades', 1600.00, 10, 100, 50, 5, 'resources/fotos_productos/cobreO.jpg');
INSERT INTO `productos` VALUES (39, 'Olla de Granito', 'Olla de granito de 10 unidades', 1400.00, 10, 100, 50, 5, 'resources/fotos_productos/granitoO.jpg');
INSERT INTO `productos` VALUES (40, 'Olla de Mármol', 'Olla de mármol de 10 unidades', 1700.00, 10, 100, 50, 5, 'resources/fotos_productos/marmolO.webp');
INSERT INTO `productos` VALUES (41, 'Olla de Titanio', 'Olla de titanio de 10 unidades', 1800.00, 10, 100, 50, 5, 'resources/fotos_productos/titanioO.jpg');
INSERT INTO `productos` VALUES (42, 'Olla de Aluminio', 'Olla de aluminio de 10 unidades', 1100.00, 10, 100, 50, 5, 'resources/fotos_productos/aluminioO.web');
INSERT INTO `productos` VALUES (43, 'Olla a Presión', 'Olla a presión de 10 unidades', 2000.00, 10, 100, 50, 5, 'resources/fotos_productos/presionO.jpg');
INSERT INTO `productos` VALUES (44, 'Vajilla de Platos Cuadrados', 'Vajilla de platos cuadrados de 50 unidades', 500.00, 10, 100, 50, 1, 'resources/fotos_productos/platosCuadrados.jpg');

-- ----------------------------
-- Table structure for rol
-- ----------------------------
DROP TABLE IF EXISTS `rol`;
CREATE TABLE `rol`  (
  `idRol` int(3) NOT NULL AUTO_INCREMENT,
  `rol` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `estado` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '1',
  PRIMARY KEY (`idRol`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of rol
-- ----------------------------

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario`  (
  `idUsuario` int(3) NOT NULL AUTO_INCREMENT,
  `nombreU` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `email` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `contrasenia` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `estadoU` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '1',
  `idRol` int(3) NOT NULL,
  PRIMARY KEY (`idUsuario`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of usuario
-- ----------------------------
INSERT INTO `usuario` VALUES (1, 'Proveedor1', 'proveddor.56@gmail.com', 'cee02b3226ac33fc254071832d099102', '1', 1);

SET FOREIGN_KEY_CHECKS = 1;
