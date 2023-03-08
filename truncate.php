<?php
include 'connect.php';

$sql = $conn -> query("TRUNCATE TABLE userdetails");
if ($sql) {
    $myarray['result'] = 'success';
}else{
    $myarray['result'] = 'failed';
}
?>