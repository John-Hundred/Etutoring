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

$sql = "SELECT * FROM private_lesson join user on user.id=private_lesson.user_id
	left join course on private_lesson.course_id = course.course_id";

$result = $connect->query($sql);

$emparray = array();
if ($result->num_rows > 0) {
  // output data of each row
  while($row = $result->fetch_assoc()) {
    $emparray[] = $row;
  }
} else {
  // echo "0 results";
}
$connect->close();

echo json_encode($emparray);
?>