<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

define("DB_HOST", "localhost");
define("DB_USER", "e_tutoring");
define("DB_PASSWORD", "e_tutoring_DSM");
define("DB_NAME", "e_tutoring");
	
sleep(2);

try {
	$connect = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
	if (mysqli_connect_errno($connect)){
		die("Unable to connect to MySQL Database: " . mysqli_connect_error());
	}

	// Getting the received JSON into $json variable.
	$json = file_get_contents('php://input');
	 
	// Decoding the received JSON and store into $obj variable.
	$obj = json_decode($json,true);

	// Getting User email from JSON $obj array and store into $email.
	$email = $obj['email'];

	// Getting Password from JSON $obj array and store into $password.
	$password = $obj['password'];
	$hashed_password = md5($password);

	$firstname = $obj['firstname'] ?? '';
	$lastname = $obj['lastname'] ?? '';

	//Verify if User email exist.
	$query = "select * from user where email = '$email'";

	// Executing SQL Query.
	$check = mysqli_fetch_array(mysqli_query($connect,$query));

	global $mysqli;

	if(isset($check)){
		// user already exist
		
		// Successfully Login Message.
		 $onSignInFailed = 'The user already exists. Registration failed';
		 
		 // Converting the message into JSON format.
		 $failedMSG = json_encode($onSignInFailed);
		 
		 // Echo the message.
		 echo $failedMSG; 
	 
	 }
	 
	 else{ // ok -> insert to db table: user, user_attribute 

		$sql = "INSERT INTO user (password, email) VALUES ('$hashed_password', '$email')";
		if($connect->query($sql)){
			
			$last_id = $connect->insert_id;
			
			$sql = "INSERT INTO user_attribute (firstname, lastname, user_id) VALUES ('$firstname', '$lastname', '$last_id')";
			
			if($connect->query($sql)){
				
				$msg = 'New record created successfully';
			 
				// Converting the message into JSON format.
				$jsonMsg = json_encode($msg);
			 
				// Echo the message.
				echo $jsonMsg; 
				
			} else { // delete last_id
				$sql = "DELETE FROM MyGuests WHERE id='$last_id'";
				$connect->query($sql);
				$InvalidMSG = 'Error: please Try Again' ;
				$InvalidMSGJSon = json_encode($InvalidMSG);
				echo $InvalidMSGJSon;
			}
		}
	 
	 }
	mysqli_close($connect);
} catch (Exception $e) {
	die("Unable to connect to MySQL Database: ");
}
?>