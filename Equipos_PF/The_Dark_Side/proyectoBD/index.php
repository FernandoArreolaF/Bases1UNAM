<?php
session_start();
?>
<?php
echo 'Bienvenido, ';
if (isset($_SESSION['k_username'])) {
 echo '<b>'.$_SESSION['k_username'].'</b>.';
 echo '<p><a href="logout.php">Logout</a></p>';
}else{
 echo '<p><a href="login.php">Login</a></p>';
 
}
?>
