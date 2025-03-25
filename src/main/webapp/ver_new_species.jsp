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
		            <h1>Add Species</h1>  
		        </header>
		        
		      		<%
							    String newSpeciesName = request.getParameter("new_species_name");
						      	// Sanitiza o nome da espécie
						      	newSpeciesName = Validator.sanitizeInput(newSpeciesName);
							    boolean insertSuccess = false;
							    boolean speciesExists = false;
							    int userId = (int) session.getAttribute("id_user");
							
							    if (Validator.isValidName(newSpeciesName)) {
							        try (Connection cn = ligacaomysql.criarligacao()) {
							            // Verificar se a espécie já existe
							            String checkQuery = "SELECT COUNT(*) FROM species WHERE name_species = ?";
							            try (PreparedStatement checkPs = cn.prepareStatement(checkQuery)) {
							                checkPs.setString(1, newSpeciesName);
							                try (ResultSet rs = checkPs.executeQuery()) {
							                    if (rs.next() && rs.getInt(1) > 0) {
							                        speciesExists = true;
							                    }
							                }
							            }
							
							            if (!speciesExists) {
							                // Inserir na tabela species
							                String insertQuery = "INSERT INTO species (name_species) VALUES (?)";
							                try (PreparedStatement ps = cn.prepareStatement(insertQuery)) {
							                    ps.setString(1, newSpeciesName);
							                    int rowsAffected = ps.executeUpdate();
							                    insertSuccess = (rowsAffected > 0);
							                }
							
							                // Registrar no log de admin
							                if (insertSuccess) {
							                    String logQuery = "INSERT INTO admin_logs (id_user, action) VALUES (?, ?)";
							                    try (PreparedStatement logPs = cn.prepareStatement(logQuery)) {
							                        logPs.setInt(1, userId);
							                        logPs.setString(2, "Added new species: " + newSpeciesName);
							                        logPs.executeUpdate();
							                    }
							                }
							            }
							        } catch (Exception e) {
							            out.println("<p style='color: red;'>Error adding species: " + e.getMessage() + "</p>");
							        }
							    } else {
							        out.println("<p style='color: red;'>Invalid species name. Please ensure it is at least 2 characters long and contains only letters and spaces.</p>");
							    }
							%>
							
							<%
							    if (speciesExists) {
							%>
							<p style="color: red;">Species already exists in the database. Please enter a different name.</p>
							<button onclick="window.history.back()" style="padding: 10px 20px; background-color: #f44336; color: white; border: none; cursor: pointer; border-radius: 4px;">
							    Try Again
							</button>
							<%
							    } else if (insertSuccess) {
							%>
							<p style="color: green;">Species added successfully!</p>
							<button onclick="window.location.href='species.jsp'" style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer; border-radius: 4px;">
							    Go Back
							</button>
							<%
							    } else {
							%>
							<p style="color: red;">Failed to add species. Please try again.</p>
							<button onclick="window.history.back()" style="padding: 10px 20px; background-color: #f44336; color: white; border: none; cursor: pointer; border-radius: 4px;">
							    Try Again
							</button>
							<%
							    }
							%>
		      	
		      	
		      	 <!-- Footer -->
			        <section id="footer">
			            <p>&copy; 2025 Adoption Agency. Design by Lia Costa.</p>
			        </section>
					
			</div>
	
	
		
	</body>
</html>