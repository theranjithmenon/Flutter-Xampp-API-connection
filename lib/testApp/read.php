<?php
include 'connect.php';

$sql = $conn -> query("SELECT * FROM userdetails ORDER BY id DESC");
$list = array();
if($sql -> num_rows > 0){
    while ($row = $sql -> fetch_assoc()) {
        $myarray['name'] = $row['user_name'];
        $myarray['email'] = $row['user_email'];
        $myarray['phone'] = $row['user_ph'];
        $myarray['id'] = $row['id'];
        array_push($list,$myarray);
    }
}
else{
    $myarray['result'] = 'failed';
    array_push($list,$myarray);
}
echo json_encode($list);
?>