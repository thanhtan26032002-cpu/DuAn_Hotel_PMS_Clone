<?php
// Kết nối MySQL
$pdo = new PDO('mysql:host=127.0.0.1;dbname=hotel_pms;charset=utf8', 'root', '');
$tables = ['booking_rooms', 'rooms', 'bookings'];
foreach ($tables as $t) {
    echo "=== $t ===\n";
    $stmt = $pdo->query("DESCRIBE $t");
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo "  {$row['Field']} | {$row['Type']} | Default={$row['Default']}\n";
    }
    echo "\n";
}

echo "=== Sample booking_rooms (5 rows) ===\n";
$stmt = $pdo->query("SELECT * FROM booking_rooms LIMIT 5");
while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
    echo json_encode($row, JSON_UNESCAPED_UNICODE) . "\n";
}
