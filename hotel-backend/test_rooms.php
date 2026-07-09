<?php
$pdo = new PDO('mysql:host=127.0.0.1;dbname=hotel_pms;charset=utf8', 'root', '');
$stmt = $pdo->query('DESCRIBE rooms');
echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC), JSON_PRETTY_PRINT);
