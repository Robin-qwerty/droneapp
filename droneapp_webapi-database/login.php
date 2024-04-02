<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
require_once 'private/dbconnect.php';

try {
    // Get username and password from request
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Retrieve the user's record from the database based on the provided username
    $sql = "SELECT * FROM users WHERE username = :username";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':username', $username);
    $stmt->execute();
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user) {
        // Verify if the provided password matches the hashed password stored in the database
        if (password_verify($password, $user['password'])) {
            // Passwords match, return user ID
            echo $user['userid'];
        } else {
            // Passwords do not match
            echo "ERROR2";
        }
    } else {
        // User does not exist
        echo "ERROR2";
    }
} catch (\Throwable $th) {
    echo "ERROR1";
}

?>
