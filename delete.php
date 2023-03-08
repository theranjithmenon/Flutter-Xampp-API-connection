<?php
include 'connect.php';

$id = $_POST['id'];
$sql = $conn -> query("DELETE FROM userdetails WHERE id = $id");
if ($sql) {
    $myarray['result'] = 'success';
}else{
    $myarray['result'] = 'failed';
}
?>