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
		            <h1>Delete Species</h1>  
		        </header>
		        
		        	<%
					    String idSpecies = request.getParameter("id_species");
					    String speciesName = "";
					
					    // Conexão com a base de dados para buscar informações da espécie
					    try (Connection cn = ligacaomysql.criarligacao()) {
					        String query = "SELECT name_species FROM species WHERE id_species = ?";
					        try (PreparedStatement ps = cn.prepareStatement(query)) {
					            ps.setString(1, idSpecies);
					            try (ResultSet rs = ps.executeQuery()) {
					                if (rs.next()) {
					                    speciesName = rs.getString("name_species");
					                } else {
					                    out.println("<p style='color: red;'>Species not found!</p>");
					                    return;
					                }
					            }
					        }
					    } catch (Exception e) {
					        out.println("<p style='color: red;'>Error fetching species details: " + e.getMessage() + "</p>");
					        return;
					    }
					%>


					<p>Are you sure you want to delete the species: <strong><%= speciesName %></strong>?</p>
					
					<!-- Botões para confirmação ou cancelamento -->
					<div style="display: flex; gap: 10px; align-items: center;">
					
					    <!-- Botão para confirmação -->
					    <form action="confirm_delete_species.jsp" method="POST" style="margin: 0;">
					        <input type="hidden" name="id_species" value="<%= idSpecies %>">
					        <button type="submit" style="padding: 10px 20px; background-color: #f44336; color: white; border: none; cursor: pointer; border-radius: 4px;">
					            Delete Species
					        </button>
					    </form>
					
					    <!-- Botão para cancelamento -->
					    <button onclick="window.location.href='species.jsp'" style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer; border-radius: 4px;">
					        Cancel
					    </button>
					    
					</div>
		        
		      	
		      	 <!-- Footer -->
			        <section id="footer">
			            <p>&copy; 2025 Adoption Agency. Design by Lia Costa.</p>
			        </section>
					
			</div>
	
	
		
	</body>
</html>