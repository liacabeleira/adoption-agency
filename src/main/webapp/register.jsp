<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="ligarBD.*" %>
<%@ page import="classes.Validator" %>
<!DOCTYPE html>
<html>
<head>
		<title>Adoption Agency</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<link rel="icon" href="images/icon.png">
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
		
		<style>
        .register-container {
            width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f4f4f4;
            border-radius: 8px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }
        .register-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: black;
            font-weight: bold;
        }
        .register-container label {
            display: block;
            margin-bottom: 8px;
            color: black;
        }
        .register-container input {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            color: black;
        }
        .register-container button {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        .btn-submit {
            background-color: #4CAF50;
            color: white;
        }
        .btn-back {
            background-color: #2196F3;
            color: white;
        }
    </style>
</head>
<body>
		<!-- Navbar -->
		<nav style="background-color: #333; padding: 10px; display: flex; align-items: center; justify-content: space-between;">
			<a href="index.jsp" style="color: white; text-decoration: none; font-size: 20px; font-weight: bold;">Adoption Agency</a>
			<ul style="list-style-type: none; margin: 0; padding: 0; display: flex;">
				<li style="margin-left: 20px;">
					<a href="login.jsp" style="color: white; text-decoration: none; font-size: 16px;">Login</a>
				</li>
			</ul>
		</nav>
		
		 <!-- Wrapper -->
    <div id="wrapper">


			
			<div class="register-container">
    <h2>Register</h2>
    <form action="ver_new.jsp" method="POST">
        <label for="name">Name:</label>
        <input type="text" id="name" name="txt_name" required placeholder="Enter your name">

        <label for="surname">Surname:</label>
        <input type="text" id="surname" name="txt_surname" required placeholder="Enter your surname">

        <label for="email">Email:</label>
        <input type="email" id="email" name="txt_email" required placeholder="Enter your email">

        <label for="password">Password:</label>
        <input type="password" id="password" name="txt_password" required placeholder="Enter your password">

        <label for="confirm_password">Confirm Password:</label>
        <input type="password" id="confirm_password" name="txt_confirm_password" required placeholder="Confirm your password">

        <label for="address">Address:</label>
        <input type="text" id="address" name="txt_address" required placeholder="Enter your address">

        <label for="zip_code">Zip-Code:</label>
        <input type="text" id="zip_code" name="txt_zip_code" required placeholder="Enter your zip-code">

        <label for="city">City:</label>
        <input type="text" id="city" name="txt_city" required placeholder="Enter your city">

        <label for="country">Country:</label>
        <input type="text" id="country" name="txt_country" required placeholder="Enter your country">

        <label for="phone_number">Phone Number:</label>
        <input type="text" id="phone_number" name="txt_phone_number" required placeholder="Enter your phone number">

        <button type="submit" class="btn-submit">Submit</button>
    </form>

    <button onclick="window.location.href='login.jsp';" class="btn-back">Back</button>
</div>
       
       
       

        <!-- Footer -->
        <section id="footer">
            <p>&copy; 2024 Adoption Agency. Design by <a href="http://html5up.net">HTML5 UP</a>.</p>
        </section>

    </div>
		
</body>
</html>