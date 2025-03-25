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
	</head>
<body class="is-preload">
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
		
		<!-- Login Form -->
	<div class="login-container" style="width: 300px; margin: 50px auto; padding: 20px; background-color: #f4f4f4; border-radius: 8px; box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);">
		<h2 style="text-align: center; margin-bottom: 20px; color: black; font-weight: bold;">Login</h2>
		<form action="ver_user.jsp" method="POST">
			<!-- Campo para o email -->
			<label for="email" style="display: block; margin-bottom: 8px;  color: black;">Email:</label>
			<input type="email" id="email" name="txt_email" required placeholder="Enter your email" 
				   style="width: 100%; padding: 8px; margin-bottom: 15px; border: 1px solid #ccc; border-radius: 4px; color: black;">

			<!-- Campo para a password -->
			<label for="password" style="display: block; margin-bottom: 8px; color: black;">Password:</label>
			<input type="password" id="password" name="txt_password" required placeholder="Enter your password" 
				   style="width: 100%; padding: 8px; margin-bottom: 15px; border: 1px solid #ccc; border-radius: 4px; color: black;">

			<!-- Botão de Login -->
			<button type="submit" style="width: 100%; padding: 10px; background-color: #4CAF50; color: white; border: none; border-radius: 4px; font-size: 16px; cursor: pointer;">Login</button>
		</form>

		<!-- Botão para "Register" -->
		<button onclick="window.location.href='register.jsp';" 
				style="width: 100%; padding: 10px; margin-top: 10px; background-color: #2196F3; color: white; border: none; border-radius: 4px; font-size: 16px; cursor: pointer;">Register</button>
	</div>
	
	<section id="footer">
		<section>
			 <p>&copy; 2025 Adoption Agency. Design by Lia Costa.</p>
		</section>
	</section>
	
	</div>

</body>
</html>