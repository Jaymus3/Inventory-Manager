<?php
$servername = "localhost";
$username = "ipodinterface";
$password = "jxbRrafHNT8CSjgY";
$dbname = "car_parts";
$name = $_GET["name"];
$conditions = $_GET["conditions"];
$stock = $_GET["stock"];

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

$sql = "UPDATE Cars_Index
SET Conditions='$conditions'
WHERE Stock='$stock' AND Name='$name';";

if ($conn->query($sql) === TRUE) {
    echo "Record updated successfully!";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>