<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="ligarBD.*" %>
<%@ page import="classes.Validator" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
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
		    <!-- Logo ou Nome da Agência -->
		    <a href="index_user.jsp" style="color: white; text-decoration: none; font-size: 20px; font-weight: bold;">Adoption Agency</a>
		    
		    <ul style="list-style-type: none; margin: 0; padding: 0; display: flex; align-items: center;">
		        <%
		            // Verifica se há um email na sessão
	            String email = (String) session.getAttribute("email");
	        	String role = (String) session.getAttribute("role"); // Obtém o role da sessão
	            if (email != null) {
	            	 if ("user".equals(role)) {
	                     // Redireciona para a página de user se o role for user
	                     response.sendRedirect("index_user.jsp");
	                     return;
	                 }
		         %>
		            <!-- Frase de boas-vindas -->
		            <li style="margin-right: 20px; color: white; font-size: 16px;">Welcome, Admin <%= email %></li>
		
		            <!-- Link para a página de users -->
		            <li style="margin-right: 20px;">
		                <a href="users.jsp" style="color: white; text-decoration: none; font-size: 16px;">Users</a>
		            </li>
		            
		            <!-- Link para a página de pedidos -->
		            <li style="margin-right: 20px;">
		                <a href="requests.jsp" style="color: white; text-decoration: none; font-size: 16px;">Requests</a>
		            </li>
		            
		            <!-- Link para a página de animais -->
		            <li style="margin-right: 20px;">
		                <a href="animals.jsp" style="color: white; text-decoration: none; font-size: 16px;">Animals</a>
		            </li>
		            
		            <!-- Link para a página de espécies -->
		            <li style="margin-right: 20px;">
		                <a href="species.jsp" style="color: white; text-decoration: none; font-size: 16px;">Species</a>
		            </li>
					
					<!-- Link para a conta do admin -->
		            <li style="margin-right: 20px;">
		                <a href="account_admin.jsp" style="color: white; text-decoration: none; font-size: 16px;">Account</a>
		            </li>
		
		            <!-- Link para logout -->
		            <li>
		                <a href="logout.jsp" style="color: white; text-decoration: none; font-size: 16px;">Logout</a>
		            </li>
		        <%
		            } else {
		            	 // Redireciona para o login se não houver sessão
		                response.sendRedirect("login.jsp");
		                return;
		            }
		        %>
		    </ul>
		</nav>
		
		<!-- Wrapper -->
			<div id="wrapper">

					 <!-- Header -->
		        <header id="header">
		            <h1>Update Admin Details</h1>  
		        </header>
		        
		        	<%
					    String new_firstname = Validator.sanitizeInput(request.getParameter("new_firstname"));
					    String new_surname = Validator.sanitizeInput(request.getParameter("new_surname"));
					    String new_address = Validator.sanitizeInput(request.getParameter("new_address"));
					    String new_zipCode = Validator.sanitizeInput(request.getParameter("new_zip_code"));
					    String new_city = Validator.sanitizeInput(request.getParameter("new_city"));
					    String new_country = Validator.sanitizeInput(request.getParameter("new_country"));
					    String new_phoneNumber = Validator.sanitizeInput(request.getParameter("new_phone_number"));
					    
					
					    boolean isValid = true;
					
					    if (!Validator.isValidName(new_firstname)) {
					        out.println("<h1 style='color: red;'>Invalid Name</h1>");
					        isValid = false;
					    }
					    
					    if (!Validator.isValidName(new_surname)) {
					        out.println("<h1 style='color: red;'>Invalid Surname</h1>");
					        isValid = false;
					    }
					
					
					    if (!Validator.isValidAddress(new_address)) {
					        out.println("<h1 style='color: red;'>Invalid Address</h1>");
					        isValid = false;
					    }
					
					    if (!Validator.isValidZipCode(new_zipCode)) {
					        out.println("<h1 style='color: red;'>Invalid Zip Code</h1>");
					        isValid = false;
					    }
					
					    if (!Validator.isValidCity(new_city)) {
					        out.println("<h1 style='color: red;'>Invalid City</h1>");
					        isValid = false;
					    }
					
					    if (!Validator.isValidCountry(new_country)) {
					        out.println("<h1 style='color: red;'>Invalid Country</h1>");
					        isValid = false;
					    }
						
					    if (!Validator.isValidPhoneNumber(new_phoneNumber)) {
					        out.println("<h1 style='color: red;'>Invalid Phone Number</h1>");
					        isValid = false;
					    }
					    
					
					    if (isValid) {
					        // Actualizar a base de dados se todos os campos forem válidos
					    	 try (Connection cn = ligacaomysql.criarligacao()) {
						        // Query de update
						        String query = "UPDATE user SET firstname=?, surname=?, address=?, zip_code=?, city=?, country=?, phone_number=? WHERE email=?";
						        
						        try (PreparedStatement ps = cn.prepareStatement(query)) {
						            ps.setString(1, new_firstname);
						            ps.setString(2, new_surname);
						            ps.setString(3, new_address);
						            ps.setString(4, new_zipCode);
						            ps.setString(5, new_city);
						            ps.setString(6, new_country);
						            ps.setString(7, new_phoneNumber);
						            ps.setString(8, email);
						
						            int rowsAffected = ps.executeUpdate();
						            if (rowsAffected > 0) {
						                out.println("<h1 style='color: green;'>Update Successful</h1>");
						            } else {
						                out.println("<h1 style='color: red;'>Update Failed</h1>");
						            }
						        }
			    } catch (SQLException e) {
			        out.println("<h1>Error updating details: " + e.getMessage() + "</h1>");
			    } catch (Exception e) {
			        out.println("<h1>Unexpected Error: " + e.getMessage() + "</h1>");
			    }
					    }
					%>
					 <!-- Botões -->
			        <div style="margin-top: 20px;">
						<button onclick="window.location.href='account_admin.jsp'" style="padding: 10px 20px; background-color: #f44336; color: white; border: none; cursor: pointer; border-radius: 4px;">
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