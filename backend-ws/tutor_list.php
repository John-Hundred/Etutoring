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
    $sql = "SELECT * FROM user join tutor_attribute on user.id = tutor_attribute.user_id 
left join role on tutor_attribute.role_id = role.role_id
where id = " . $_GET['id'];
} else {
			if(isset($_GET['email'])) {
				$sql = "SELECT * FROM user join tutor_attribute on user.id = tutor_attribute.user_id 
left join role on tutor_attribute.role_id = role.role_id
		where email = '" . $_GET['email'] ."'";
	} else {
			$sql = "SELECT * FROM user join tutor_attribute on user.id = tutor_attribute.user_id 
left join role on tutor_attribute.role_id = role.role_id";
}
}
$result = $connect->query($sql);

$emparray = array();
if ($result->num_rows > 0) {
  if($result->num_rows == 1) $emparray = $row = $result->fetch_assoc();
  // output data of each row
  else {
	  $row['time_slot'] = [];
	  while($row = $result->fetch_assoc()) {
		  
		  	$sql = "SELECT * FROM tutor_time_slot where user_id = '" . $row['id'] ."'";
			$result_tutor_time_slot = $connect->query($sql);
			$row['time_slot'] = [];
			while($row_tutor_time_slot = $result_tutor_time_slot->fetch_assoc()) {
				array_push($row['time_slot'], $row_tutor_time_slot);
			}
			
			$sql = "SELECT * FROM tutor_course  
				left join course on tutor_course.course_id = course.course_id 
				where user_id = '" . $row['id'] ."'";
			$result_courses = $connect->query($sql);
			$row['courses'] = [];
			while($row_courses = $result_courses->fetch_assoc()) {
				array_push($row['courses'], $row_courses);
			}
			
			$emparray[] = $row;
	}
  }
} else { 
	// no results
}
$connect->close();

echo json_encode($emparray, JSON_INVALID_UTF8_IGNORE);


?>