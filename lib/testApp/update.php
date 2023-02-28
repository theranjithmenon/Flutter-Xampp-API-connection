<?php
include 'connect.php';

$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$id = $_POST['id'];

$sql = $conn -> query(
    "UPDATE userdetails SET 
    user_name = '$name', user_email = '$email', user_ph = '$phone' 
    WHERE id = '$id'");
?>