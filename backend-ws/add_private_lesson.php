<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

define("DB_HOST", "31.11.39.54");
define("DB_USER", "Sql1558195");
define("DB_PASSWORD", "ab12pozt12Q!!");
define("DB_NAME", "Sql1558195_1");
	
try {
	
	$connect = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
	if (mysqli_connect_errno($connect)){
		die("Unable to connect to MySQL Database: " . mysqli_connect_error());
	}

	// Getting the received JSON into $json variable.
	$json = file_get_contents('php://input');
	 
	// Decoding the received JSON and store into $obj variable.
	$obj = json_decode($json,true);

	$email = $obj['email'];
	$course_id = $obj['course_id'];
	$tutor_time_slot_id = $obj['tutor_time_slot_id'];
	$tutor_id = $obj['tutor_id'];
	
	$query_select_id_user = "select id FROM user WHERE email = '$email'";
	$result = $connect->query($query_select_id_user);
	$row = $result->fetch_assoc();
	$user_id = $row['id'];
	
	$query_select_tutor_course_id = "select tutor_course_id FROM tutor_course 
	WHERE user_id = '$tutor_id' AND course_id = '$course_id' ";
	$result_tutor_course_id = $connect->query($query_select_tutor_course_id);
	$row_tutor_course_id = $result_tutor_course_id->fetch_assoc();
	$tutor_course_id = $row_tutor_course_id['tutor_course_id'];
		
	$sql = "INSERT INTO private_lesson (user_id, tutor_course_id, tutor_time_slot_id) VALUES ($user_id, $tutor_course_id, $tutor_time_slot_id)";
	if($connect->query($sql)){
		$SuccessMSG = json_encode("Add lesson successfully");
		echo $SuccessMSG ; 
	} else {
		$InvalidMSG = "Error adding lesson";
		$InvalidMSGJSon = json_encode($InvalidMSG, JSON_INVALID_UTF8_IGNORE);
		echo $InvalidMSGJSon;
	}

	$connect->close();
} catch (Exception $e) {
	echo json_encode("Unable to connect to MySQL Database: " . $e->getMessage());
}
?>