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
		            <h1>Edit Species</h1>  
		        </header>
		        
		          <div style="margin: 20px auto; max-width: 600px; text-align: center;">
        			<form action="update_species.jsp" method="POST">
            			<table class="styled-table">
			                <% 
			                    String idSpecies = request.getParameter("id_species"); // ID recebido como parâmetro
			                    String currentName = "";
			
			                    try (Connection cn = ligacaomysql.criarligacao()) {
			                        String query = "SELECT id_species, name_species FROM species WHERE id_species = ?";
			                        try (PreparedStatement ps = cn.prepareStatement(query)) {
			                            ps.setString(1, idSpecies);
			                            try (ResultSet rs = ps.executeQuery()) {
			                                if (rs.next()) {
			                                    currentName = rs.getString("name_species");
			                %>
			                <tr>
			                    <td style="padding: 10px;">ID</td>
			                    <td>
			                        <input type="text" name="id_species" value="<%= rs.getString("id_species") %>" readonly style="width: 100%; padding: 8px; color: gray;">
			                    </td>
			                </tr>
			                <tr>
			                    <td style="padding: 10px;">Current Name</td>
			                    <td>
			                        <input type="text" name="current_name" value="<%= currentName %>" readonly style="width: 100%; padding: 8px; color: gray;">
			                    </td>
			                </tr>
			                <tr>
			                    <td style="padding: 10px;">New Name</td>
			                    <td>
			                        <input type="text" name="new_name" required style="width: 100%; padding: 8px; color: black;">
			                    </td>
			                </tr>
			                <% 
			                                }
			                            }
			                        }
			                    } catch (Exception e) {
			                        out.println("<p style='color: red;'>Error loading species details: " + e.getMessage() + "</p>");
			                    }
			                %>
			            </table>
			
			            <!-- Botões -->
			            <div style="margin-top: 20px;">
			                <button type="submit" style="padding: 10px 20px; margin-right: 10px; background-color: #4CAF50; color: white; border: none; cursor: pointer; border-radius: 4px;">
			                    Save Changes
			                </button>
			                <button type="button" onclick="window.location.href='species.jsp'" style="padding: 10px 20px; background-color: #f44336; color: white; border: none; cursor: pointer; border-radius: 4px;">
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