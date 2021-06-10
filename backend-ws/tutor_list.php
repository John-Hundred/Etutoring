<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

define("DB_HOST", "31.11.39.54");
define("DB_USER", "Sql1558195");
define("DB_PASSWORD", "ab12pozt12Q!!");
define("DB_NAME", "Sql1558195_1");
	
$connect = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
if (mysqli_connect_errno($connect)){
	die("Unable to connect to MySQL Database: " . mysqli_connect_error());
}

if(isset($_GET['id'])) {
    $sql = "SELECT * FROM user left join tutor_attribute on user.id = tutor_attribute.user_id 
left join role on tutor_attribute.role_id = role.role_id
where id = " . $_GET['id'];
} else {
			if(isset($_GET['email'])) {
				$sql = "SELECT * FROM user left join tutor_attribute on user.id = tutor_attribute.user_id 
left join role on tutor_attribute.role_id = role.role_id
		where email = '" . $_GET['email'] ."'";
	} else {
			$sql = "SELECT * FROM user left join tutor_attribute on user.id = tutor_attribute.user_id 
left join role on tutor_attribute.role_id = role.role_id";
}
}
$result = $connect->query($sql);

$emparray = array();
if ($result->num_rows > 0) {
  if($result->num_rows == 1) $emparray = $row = $result->fetch_assoc();
  // output data of each row
  else {
	  while($row = $result->fetch_assoc()) {
		$emparray[] = $row;
	}
  }
} else { 
	// no results
}
$connect->close();

echo json_encode($emparray, JSON_INVALID_UTF8_IGNORE);


?>