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
		            <h1>Edit Animal</h1>  
		        </header>
		        
		        
		        <!-- Formulário para edição de animais -->
				<div style="margin: 20px auto; max-width: 600px; text-align: center;">
				    <form action="update_animal.jsp" method="POST">
				        <table class="styled-table">
				            <% 
				            	int id_animal = Integer.parseInt(request.getParameter("id_animal"));
				            	
				                try (Connection cn = ligacaomysql.criarligacao()) {
				                    // Query para obter os detalhes do animal
				                    String query = "SELECT name_animal, gender, status_animal, photo, id_species FROM animals WHERE id_animal = ?";
				                    try (PreparedStatement ps = cn.prepareStatement(query)) {
				                        ps.setInt(1, id_animal);
				                        try (ResultSet rs = ps.executeQuery()) {
				                            if (rs.next()) {
				                                String nameAnimal = rs.getString("name_animal");
				                                String gender = rs.getString("gender");
				                                String statusAnimal = rs.getString("status_animal");
				                                String photo = rs.getString("photo");
				                                int idSpecies = rs.getInt("id_species");
				            %>
				            <input type="hidden" name="id_animal" value="<%= id_animal %>">
				            <tr>
				                <td style="padding: 10px;">Photo</td>
				                <td><img src="<%= photo %>" alt="Animal Photo" style="max-width: 100%; max-height: 150px;"></td>
				            </tr>
				            <tr>
				                <td style="padding: 10px;">ID</td>
				                <td><input type="text" value="<%= id_animal %>" readonly style="width: 100%; padding: 8px; color: black;"></td>
				            </tr>
				            
				            <tr>
				                <td style="padding: 10px;">Name</td>
				                <td><input type="text" name="new_name_animal" value="<%= nameAnimal %>" required style="width: 100%; padding: 8px; color: black;"></td>
				            </tr>
				            <tr>
				                <td style="padding: 10px;">Gender</td>
				                <td>
				                    <select name="new_gender" required style="width: 100%; padding: 8px; color: black;">
				                        <option value="Male" <%= "Male".equals(gender) ? "selected" : "" %>>Male</option>
				                        <option value="Female" <%= "Female".equals(gender) ? "selected" : "" %>>Female</option>
				                    </select>
				                </td>
				            </tr>
				           <tr>
				                <td style="padding: 10px;">Status</td>
				                <td>
				                    <select name="new_status_animal" required style="width: 100%; padding: 8px; color: black;">
				                        <option value="Available" <%= "Available".equals(statusAnimal) ? "selected" : "" %>>Available</option>
				                        <option value="Adopted" <%= "Adopted".equals(statusAnimal) ? "selected" : "" %>>Adopted</option>
				                    </select>
				                </td>
				            </tr>
				            <tr>
				                <td style="padding: 10px;">Species</td>
				                <td>
				                    <select name="new_id_species" required style="width: 100%; padding: 8px; color: black;">
				                        <% 
				                            // Obter as espécies para o dropdown
				                            String speciesQuery = "SELECT id_species, name_species FROM species";
				                            try (PreparedStatement psSpecies = cn.prepareStatement(speciesQuery);
				                                 ResultSet rsSpecies = psSpecies.executeQuery()) {
				                                while (rsSpecies.next()) {
				                                    int speciesId = rsSpecies.getInt("id_species");
				                                    String speciesName = rsSpecies.getString("name_species");
				                        %>
				                        <option value="<%= speciesId %>" <%= speciesId == idSpecies ? "selected" : "" %>>
				                            <%= speciesName %>
				                        </option>
				                        <% 
				                                }
				                            } 
				                        %>
				                    </select>
				                </td>
				            </tr>
				            <% 
				                            }
				                        }
				                    }
				                } catch (Exception e) {
				                    out.println("<p style='color: red;'>Error loading animal details: " + e.getMessage() + "</p>");
				                }
				            %>
				        </table>
				
				        <!-- Botões -->
				        <div style="margin-top: 20px;">
				            <button type="submit" style="padding: 10px 20px; margin-right: 10px; background-color: #4CAF50; color: white; border: none; cursor: pointer; border-radius: 4px;">
				                Save Changes
				            </button>
				            <button type="button" onclick="window.location.href='animals.jsp'" style="padding: 10px 20px; background-color: #f44336; color: white; border: none; cursor: pointer; border-radius: 4px;">
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