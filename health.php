<?php
mysqli_report(MYSQLI_REPORT_OFF);

$host = getenv('DB_HOST') ?: 'localhost';
$username = getenv('DB_USER') ?: 'root';
$password = getenv('DB_PASSWORD') ?: '';
$database = getenv('DB_NAME') ?: 'railway';

$conn = @mysqli_connect($host, $username, $password, $database);

if (!$conn) {
    http_response_code(503);
    header('Content-Type: text/plain');
    echo "Database unavailable";
    exit;
}

mysqli_close($conn);

http_response_code(200);
header('Content-Type: text/plain');
echo "OK";
