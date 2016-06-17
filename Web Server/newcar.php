<?php
$servername = "localhost";
$username = "ipodinterface";
$password = "jxbRrafHNT8CSjgY";
$dbname = "car_parts";
$make = $_GET["make"];
$model = $_GET["model"];
$year = $_GET["year"];
$stock = $_GET["stock"];
$array = array("104 - Grille", "105 - Bumper Assy (Front)", "109 - Radiator Core Supp", "110 - Fender (Left)", "110 - Fender (Right)", "114 - Headlamp (Left)", "114 - Headlamp (Right)", "116 - Front Lamp", "117 - Hood", "120 - Door Fr (Left)", "120 - Door Fr (Right)", "125 - Dr Wdw Reg Fr (Left)", "125 - Dr Wdw Reg Fr (Right)", "128 - Side Mirror (Left)", "128 - Side Mirror (Right)", "130 - Door RR (Left)", "130 - Door RR (Right)", "135 - Dr Wdw Reg RR (Left)", "135 - Dr Wdw Reg RR (Right", "166 - Tail Lamp (Left)", "166 - Tail Lamp (Right)", "170 - Decklid Tailgate", "190 - Bumper Assy (Rear)", "238 - Steering Column", "253 - Air Bag", "257 - Speedo Head/Cluster", "270 - Windshield Glass", "275 - Back Glass", "277 - Dr Glass Fr (Left)", "277 - Dr Glass Fr (Right)", "278 - Dr Glass RR (Left)", "278 - Dr Glass RR (Right)", "279 - Dr Vent Glass (Left)", "279 - Dr Vent Glass (Right)", "284 - Quarter Glass (Left)", "284 - Quarter Glass (Right)", "288 - Roof Glass", "300 - Engine", "321 - Turbo Supercharger", "336 - Air Flow Meter", "337 - Throttle Body Assy", "341 - Air Inj. Pump", "400 - Transmission", "412 - Transfer Case", "434 - Axle Fr (4WD)", "435 - Axle RR", "477 - K-Frame", "505 - Upper Ctrl Arm RR (Left)", "505 - Upper Ctrl Arm RR (Right)", "511 - Upper Ctrl Arm Fr (Left)", "511 - Upper Ctrl Arm Fr (Right)", "512 - Lower Ctrl Arm Fr (Left)", "512 - Lower Ctrl Arm Fr (Right)", "513 - Lower Ctrl Arm RR (Left)", "513 - Lower Ctrl Arm RR (Right)", "515 - Spndl Knuckle Fr (Left)", "515 - Spndl Knuckle Fr (Right)", "527 - Strut (Left)", "527 - Strut (Right)", "540 - Power Brake Booster", "541 - Brake Master Cyl", "545 - Anti-lock Brake Pts", "550 - Power Strg Assy", "551 - Steering Gear Rack", "553 - PS Pump/Motor", "560 - Wheel", "590 - Eng/Motor Cont", "601 - Alternator", "604 - Starter Motor", "606 - Distributor" , "615 - Blower Motor", "618 - Wiper Motor RR", "620 - Wiper Motor WDSH", "655 - Temp Control", "674 - Rad Cond Fan Motor", "675 - Radiator", "679 - AC Condenser", "682 - AC Compressor");

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
echo count($array);
for ($x = 0; $x < count($array); $x++) {
    echo $array[$x];
    $sql = "INSERT INTO `Cars_Index` (`Name`, `Conditions`, `Make`, `Model`, `Year`, `Stock`)
 VALUES ('$array[$x]', '111', '$make', '$model', '$year', '$stock')";

 if ($conn->query($sql) === TRUE) {
    echo "New record created successfully\n";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}
}

$conn->close();
?>