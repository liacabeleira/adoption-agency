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
	            	 if ("admin".equals(role)) {
	                     // Redireciona para a página de admin se o role for admin
	                     response.sendRedirect("index_admin.jsp");
	                     return;
	                 }
	        %>
	            <!-- Frase de boas-vindas -->
	            <li style="margin-right: 20px; color: white; font-size: 16px;">Welcome, <%= email %></li>
	
	            <!-- Link para a página de adoção -->
	            <li style="margin-right: 20px;">
	                <a href="adopt.jsp" style="color: white; text-decoration: none; font-size: 16px;">Adopt</a>
	            </li>
	            
	            <!-- Link para a página de detalhes da conta -->
	            <li style="margin-right: 20px;">
	                <a href="account.jsp" style="color: white; text-decoration: none; font-size: 16px;">Account</a>
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
		            <h1>Account Details</h1>  
		        </header>
		            
		            <%
		                try (Connection cn = ligacaomysql.criarligacao()) {
		                    String query = "SELECT firstname, surname, email, address, zip_code, city, country, phone_number FROM user WHERE email = ?";
		                    try (PreparedStatement ps = cn.prepareStatement(query)) {
		                        ps.setString(1, email);
		                        try (ResultSet rs = ps.executeQuery()) {
		                            if (rs.next()) {
		                                String firstname = rs.getString("firstname");
		                                String surname = rs.getString("surname");
		                                String userEmail = rs.getString("email");
		                                String address = rs.getString("address");
		                                String zipCode = rs.getString("zip_code");
		                                String city = rs.getString("city");
		                                String country = rs.getString("country");
		                                String phoneNumber = rs.getString("phone_number");
		            %>
		
		           <!-- Tabela para os detalhes do utilizador -->
					<div class="container" style="background-color: Gainsboro; padding: 20px; border-radius: 10px;">

					    <table class="styled-table">
					        
					        <tr>
					            <td style="padding: 10px;">First Name</td>
					            <td style="padding: 10px;"><%= rs.getString("firstname") %></td>
					        </tr>
					        <tr>
					            <td style="padding: 10px;">Surname</td>
					            <td style="padding: 10px;"><%= rs.getString("surname") %></td>
					        </tr>
					        <tr>
					            <td style="padding: 10px;">Email</td>
					            <td style="padding: 10px;"><%= rs.getString("email") %></td>
					        </tr>
					        <tr>
					            <td style="padding: 10px;">Address</td>
					            <td style="padding: 10px;"><%= rs.getString("address") %></td>
					        </tr>
					        <tr>
					            <td style="padding: 10px;">Zip Code</td>
					            <td style="padding: 10px;"><%= rs.getString("zip_code") %></td>
					        </tr>
					        <tr>
					            <td style="padding: 10px;">City</td>
					            <td style="padding: 10px;"><%= rs.getString("city") %></td>
					        </tr>
					        <tr>
					            <td style="padding: 10px;">Country</td>
					            <td style="padding: 10px;"><%= rs.getString("country") %></td>
					        </tr>
					        <tr>
					            <td style="padding: 10px;">Phone Number</td>
					            <td style="padding: 10px;"><%= rs.getString("phone_number") %></td>
					        </tr>
					    </table>
							
		            <%
		                            }
		                        }
		                    }
		                } catch (Exception e) {
		                    out.println("<p style='color: red;'>Error loading account details: " + e.getMessage() + "</p>");
		                }
		            %>

            <!-- Botões -->
           <div style="margin-top: 20px; text-align: center;">
			    <button onclick="window.location.href='edit_details.jsp'" 
			            style="padding: 10px 20px; margin-right: 10px; background-color: #4CAF50; color: white; border: none; cursor: pointer; border-radius: 4px;">
			        Edit Details
			    </button>
			    <button onclick="window.location.href='change_pass.jsp'" 
			            style="padding: 10px 20px; background-color: #008CBA; color: white; border: none; cursor: pointer; border-radius: 4px;">
			        Change Password
			    </button>
			    <button onclick="window.location.href='index_user.jsp'" style="padding: 10px 20px; background-color: #f44336; color: white; border: none; cursor: pointer; border-radius: 4px;">
					  Back
					</button>
			</div>
		</div>
        
					
					
			        <!-- Footer -->
			        <section id="footer">
			            <p>&copy; 2025 Adoption Agency. Design by Lia Costa.</p>
			        </section>
					
			</div>

</body>
</html>