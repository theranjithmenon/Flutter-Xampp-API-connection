<?php
include 'connect.php';

$id = $_POST['id'];
$sql = $conn -> query("DELETE FROM userdetails WHERE id = $id");
?>