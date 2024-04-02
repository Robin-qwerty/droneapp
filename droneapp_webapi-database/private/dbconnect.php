<?php
  $servername = "localhost";
  $username = "droneapp";
  $password = "qwerty";

  try {
    $conn = new PDO("mysql:host=$servername;dbname=droneapp", $username, $password);
  } catch(PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
    die();
  }
?>