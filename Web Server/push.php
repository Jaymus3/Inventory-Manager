<?php
$servername = "localhost";
$username = "ipodinterface";
$password = "jxbRrafHNT8CSjgY";
$dbname = "car_parts";
$name = $_GET["name"];
$conditions = $_GET["conditions"];
$make = $_GET["make"];
$model = $_GET["model"];
$year = $_GET["year"];
$stock = $_GET["stock"];

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

$sql = "INSERT INTO `Cars_Index` (`Name`, `Conditions`, `Make`, `Model`, `Year`, `Stock`)
 VALUES ('$name', '$conditions', '$make', '$model', '$year', '$stock')";

if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>