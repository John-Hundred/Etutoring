<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

define("DB_HOST", "localhost");
define("DB_USER", "e_tutoring");
define("DB_PASSWORD", "e_tutoring_DSM");
define("DB_NAME", "e_tutoring");
	
$connect = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
if (mysqli_connect_errno($connect)){
	die("Unable to connect to MySQL Database: " . mysqli_connect_error());
}

if(isset($_GET['id'])) {
    $sql = "SELECT * FROM user left join user_attribute on user.id = user_attribute.user_id 
left join role on user_attribute.role_id = role.role_id
left join degree on user_attribute.degree_id = degree.degree_id
left join degree_path on user_attribute.degree_path_id = degree_path.degree_path_id
left join degree_type on degree.degree_type_id = degree_type.degree_type_id
where id = " . $_GET['id'];
} else {
			if(isset($_GET['email'])) {
				$sql = "SELECT * FROM user left join user_attribute on user.id = user_attribute.user_id 
		left join role on user_attribute.role_id = role.role_id
		left join degree on user_attribute.degree_id = degree.degree_id
		left join degree_path on user_attribute.degree_path_id = degree_path.degree_path_id
		left join degree_type on degree.degree_type_id = degree_type.degree_type_id
		where email = '" . $_GET['email'] ."'";
	} else {
			$sql = "SELECT * FROM user left join user_attribute on user.id = user_attribute.user_id 
		left join role on user_attribute.role_id = role.role_id
		left join degree on user_attribute.degree_id = degree.degree_id
		left join degree_path on user_attribute.degree_path_id = degree_path.degree_path_id
		left join degree_type on degree.degree_type_id = degree_type.degree_type_id";
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

echo json_encode($emparray);


?>