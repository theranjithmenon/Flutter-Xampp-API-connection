<?php
include 'connect.php';

$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];

$sql = $conn -> query(
    "INSERT INTO userdetails(user_name,user_email,user_ph) 
    values ('$name','$email','$phone');");
if ($sql) {
    $myarray['result'] = 'success';
}else{
    $myarray['result'] = 'failed';
}
echo json_encode($myarray);
?>