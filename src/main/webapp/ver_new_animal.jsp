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
		        
		        <%
				    // Obter os dados do formulário
				    String animalName = request.getParameter("name_animal");
				    String gender = request.getParameter("gender");
				    String speciesId = request.getParameter("id_species");
				    String photo = request.getParameter("photo");
				    
				 	// Sanitiza dados do input
			      	animalName = Validator.sanitizeInput(animalName);
			    
				    boolean insertSuccess = false;
				    boolean nameInvalid = false;
				    int userId = (int) session.getAttribute("id_user"); // ID do admin logado
				    int animalId = -1; // ID do animal inserido
				
				 // Validar o nome do animal
				    if (Validator.isValidName(animalName)) {
				        try (Connection cn = ligacaomysql.criarligacao()) {
				        	// Actualizar o caminho da foto
				            String fullPhotoPath = "images/thumbs/" + photo;
				            // Query para inserir o animal na tabela "animals"
				            String insertQuery = "INSERT INTO animals (name_animal, gender, id_species, photo) VALUES (?, ?, ?, ?)";
				            try (PreparedStatement ps = cn.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS)) {
				                ps.setString(1, animalName);
				                ps.setString(2, gender);
				                ps.setInt(3, Integer.parseInt(speciesId));
				                ps.setString(4, fullPhotoPath);

				                int rowsAffected = ps.executeUpdate();
				                if (rowsAffected > 0) {
				                    insertSuccess = true;
				                    // Obter o ID gerado automaticamente
				                    try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
				                        if (generatedKeys.next()) {
				                            animalId = generatedKeys.getInt(1);
				                        }
				                    }
				                }
				            }

				            // Registrar no log de admin
				            if (insertSuccess && animalId != -1) {
				                String logQuery = "INSERT INTO admin_logs (id_user, action) VALUES (?, ?)";
				                try (PreparedStatement logPs = cn.prepareStatement(logQuery)) {
				                    logPs.setInt(1, userId);
				                    logPs.setString(2, "Added new animal with ID: " + animalId);
				                    logPs.executeUpdate();
				                }
				            }
				        } catch (Exception e) {
				            out.println("<p style='color: red;'>Error adding animal: " + e.getMessage() + "</p>");
				        }
				    } else {
				        nameInvalid = true;
				    }
				%>

				<% if (nameInvalid) { %>
				<p style="color: red;">Invalid animal name. Please ensure it is at least 2 characters long and contains only letters and spaces.</p>
				<button onclick="window.history.back()" style="padding: 10px 20px; background-color: #f44336; color: white; border: none; cursor: pointer; border-radius: 4px;">
				    Try Again
				</button>
				<% } else if (insertSuccess) { %>
				<p style="color: green;">Animal added successfully with ID: <%= animalId %>!</p>
				<button onclick="window.location.href='animals.jsp'" style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer; border-radius: 4px;">
				    Go Back
				</button>
				<% } else { %>
				<p style="color: red;">Failed to add animal. Please try again.</p>
				<button onclick="window.history.back()" style="padding: 10px 20px; background-color: #f44336; color: white; border: none; cursor: pointer; border-radius: 4px;">
				    Try Again
				</button>
				<% } %>
		        
		      	
		      	
		      	
		      	 <!-- Footer -->
			        <section id="footer">
			            <p>&copy; 2025 Adoption Agency. Design by Lia Costa.</p>
			        </section>
					
			</div>
	
	
		
	</body>
</html>