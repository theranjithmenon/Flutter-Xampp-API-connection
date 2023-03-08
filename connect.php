<?php
 $dbhost = "localhost";
 $dbuser = "root";
 $dbpass = "";
 $db = "user";


 $conn = new mysqli($dbhost, $dbuser, $dbpass,$db);

 
 return $conn;
?>