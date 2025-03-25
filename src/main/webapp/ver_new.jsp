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
<body>
		<!-- Wrapper -->
			<div id="wrapper">

					 <!-- Header -->
		        <header id="header">
		            <h1>Verify New User</h1>  
		        </header>
		
		
		<%
		    String name = Validator.sanitizeInput(request.getParameter("txt_name"));
		    String surname = Validator.sanitizeInput(request.getParameter("txt_surname"));
		    String email = Validator.sanitizeInput(request.getParameter("txt_email"));
		    String password = request.getParameter("txt_password");
		    String confirmPassword = request.getParameter("txt_confirm_password");
		    String address = Validator.sanitizeInput(request.getParameter("txt_address"));
		    String zipCode = Validator.sanitizeInput(request.getParameter("txt_zip_code"));
		    String city = Validator.sanitizeInput(request.getParameter("txt_city"));
		    String country = Validator.sanitizeInput(request.getParameter("txt_country"));
		    String phoneNumber = Validator.sanitizeInput(request.getParameter("txt_phone_number"));
		
		    boolean isValid = true;
		
		    if (!Validator.isValidName(name)) {
		        out.println("<h1 style='color: red;'>Invalid Name</h1>");
		        isValid = false;
		    }
		    
		    if (!Validator.isValidName(surname)) {
		        out.println("<h1 style='color: red;'>Invalid Surname</h1>");
		        isValid = false;
		    }
		
		    if (!Validator.isValidEmail(email)) {
		        out.println("<h1 style='color: red;'>Invalid Email</h1>");
		        isValid = false;
		    }
		
		    if (!Validator.isValidPassword(password, confirmPassword)) {
		        out.println("<h1 style='color: red;'>Passwords do not match or are not strong enough</h1>");
		        isValid = false;
		    }
		
		    if (!Validator.isValidAddress(address)) {
		        out.println("<h1 style='color: red;'>Invalid Address</h1>");
		        isValid = false;
		    }
		
		    if (!Validator.isValidZipCode(zipCode)) {
		        out.println("<h1 style='color: red;'>Invalid Zip Code</h1>");
		        isValid = false;
		    }
		
		    if (!Validator.isValidCity(city)) {
		        out.println("<h1 style='color: red;'>Invalid City</h1>");
		        isValid = false;
		    }
		
		    if (!Validator.isValidCountry(country)) {
		        out.println("<h1 style='color: red;'>Invalid Country</h1>");
		        isValid = false;
		    }
			
		    if (!Validator.isValidPhoneNumber(phoneNumber)) {
		        out.println("<h1 style='color: red;'>Invalid Phone Number</h1>");
		        isValid = false;
		    }
		    
		
		    if (isValid) {
		        // Inserir na base de dados se todos os campos forem válidos
		    	 try (Connection cn = ligacaomysql.criarligacao()) {
			        // Query de inserção com placeholders para valores
			        String query = "INSERT INTO user (firstname, surname, email, password, address, zip_code, city, country, phone_number) "
			                     + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
			        
			        try (PreparedStatement ps = cn.prepareStatement(query)) {
			            ps.setString(1, name);
			            ps.setString(2, surname);
			            ps.setString(3, email);
			            ps.setString(4, password);
			            ps.setString(5, address);
			            ps.setString(6, zipCode);
			            ps.setString(7, city);
			            ps.setString(8, country);
			            ps.setString(9, phoneNumber);
			
			            int rowsAffected = ps.executeUpdate();
			            if (rowsAffected > 0) {
			                out.println("<h1 style='color: green;'>Registration Successful</h1>");
			            } else {
			                out.println("<h1 style='color: red;'>Registration Failed</h1>");
			            }
			        }
			    } catch (SQLException e) {
			        out.println("<h1>Erro ao inserir os dados: " + e.getMessage() + "</h1>");
			    } catch (Exception e) {
			        out.println("<h1>Erro inesperado: " + e.getMessage() + "</h1>");
			    }
					    }
		%>
		
			 		<!-- Botões -->
			        <div style="margin-top: 20px;">
			            <button type="button" onclick="window.location.href='login.jsp'" style="padding: 10px 20px; background-color: #f44336; color: white; border: none; cursor: pointer; border-radius: 4px;">
			                Back
			            </button>
			        </div>

      	 <!-- Footer -->
	        <section id="footer">
	            <p>&copy; 2025 Adoption Agency. Design by Lia Costa.</p>
	        </section>

		
</div>
		
</body>
</html>