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
		            <h1>Change Password</h1>  
		        </header>
		        
		         <!-- Formulário para mudar password -->
			        <div class="container" style="background-color: Gainsboro; padding: 20px; border-radius: 10px;">
			            <form action="update_pass.jsp" method="POST">
			                <table class="styled-table">
			                	<tr>
			                        <td style="padding: 10px;">Old Password</td>
			                        <td><input type="password" name="old_password" placeholder="Enter old password" required style="width: 100%; padding: 8px; color: black;"></td>
			                    </tr>
			                    <tr>
			                        <td style="padding: 10px;">New Password</td>
			                        <td><input type="password" name="new_password" placeholder="Enter new password" required style="width: 100%; padding: 8px; color: black;"></td>
			                    </tr>
			                    <tr>
			                        <td style="padding: 10px;">Confirm New Password</td>
			                        <td><input type="password" name="confirm_new_password" placeholder="Confirm new password" required style="width: 100%; padding: 8px; color: black;"></td>
			                    </tr>
			                 </table>
			                 
			                  <!-- Botões -->
					           <div style="margin-top: 20px; text-align: center;">
								    <button onclick="window.location.href='update_pass.jsp'" 
								            style="padding: 10px 20px; margin-right: 10px; background-color: #4CAF50; color: white; border: none; cursor: pointer; border-radius: 4px;">
								        Save Changes
								    </button>
								    <button onclick="window.location.href='account.jsp'" 
								            style="padding: 10px 20px; background-color: red; color: white; border: none; cursor: pointer; border-radius: 4px;">
								        Cancel
								    </button>
								</div>
			             </form>
			          </div>
			          
			         
					        
					      	
					      	
					      	
					      	 <!-- Footer -->
						        <section id="footer">
						            <p>&copy; 2025 Adoption Agency. Design by Lia Costa.</p>
						        </section>
								
						</div>
	
	
		
	</body>
</html>