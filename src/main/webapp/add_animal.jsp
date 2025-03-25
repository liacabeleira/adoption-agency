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
		            <h1>Add New Animal</h1>  
		        </header>
		        	
		        	<!-- Formulário para adicionar novo animal -->
					<form action="ver_new_animal.jsp" method="POST">
					    <table class="styled-table">
					    	<!-- Name -->
					        <tr>
					            <td style="padding: 10px; border: 1px solid #ddd;">Animal Name:</td>
					            <td style="padding: 10px; border: 1px solid #ddd;">
					                <input type="text" name="name_animal" placeholder="Enter animal name" required 
					                       style="width: 100%; padding: 8px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; color: black;">
					            </td>
					        </tr>
					        <!-- Gender -->
					        <tr>
				                <td style="padding: 10px;">Gender</td>
				                <td>
				                    <select name="gender" required style="width: 100%; padding: 8px; color: black;">
				                        <option value="Male">Male</option>
				                        <option value="Female">Female</option>
				                    </select>
				                </td>
				            </tr>
				            
				             <!-- Species -->
				            <tr>
				             <td style="padding: 10px;">Species</td>
				                <td>
				                    <select name="id_species" required style="width: 100%; padding: 8px; color: black;">
				                        <% 
				                        try (Connection cn = ligacaomysql.criarligacao()) {
				                            // Obter as espécies para o dropdown
				                            String speciesQuery = "SELECT id_species, name_species FROM species";
				                            try (PreparedStatement psSpecies = cn.prepareStatement(speciesQuery);
				                                 ResultSet rsSpecies = psSpecies.executeQuery()) {
				                                while (rsSpecies.next()) {
				                                    int speciesId = rsSpecies.getInt("id_species");
				                                    String speciesName = rsSpecies.getString("name_species");
				                        %>
				                        <option value="<%= speciesId %>"><%= speciesName %></option>
				                        <% 
		                                }
		                            } 
		                        }
		                        %>
		                    </select>
		                </td>
		                
		            </tr>
				            <!-- Photo -->
				            <tr>
					            <td style="padding: 10px; border: 1px solid #ddd;">Photo:</td>
					            <td style="padding: 10px; border: 1px solid #ddd;">
					                <input type="file" name="photo" accept="image/*" required 
					                       style="width: 100%; padding: 8px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; color: black;">
					            </td>
					        </tr>
				            
				            
					    </table>
					
					    <!-- Botões -->
					    <button type="submit" style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer; border-radius: 4px;">
					        Add Animal
					    </button>
					    <button type="button" onclick="window.location.href='animals.jsp'" style="padding: 10px 20px; background-color: #f44336; color: white; border: none; cursor: pointer; border-radius: 4px;">
					        Cancel
					    </button>
					</form>
		      	
		      	
		      	
		      	 <!-- Footer -->
			        <section id="footer">
			            <p>&copy; 2025 Adoption Agency. Design by Lia Costa.</p>
			        </section>
					
			</div>
	
	
		
	</body>
</html>