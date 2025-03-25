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
		            <h1>Animal List</h1>  
		        </header>
		        
		        
		        <!-- Main -->
					<div class="container" style="background-color: Gainsboro; padding: 20px; border-radius: 10px;">
					    
					    <table class="styled-table">
					        <tr>
					        	<th>ID</th>
					            <th>Photo</th>
					            <th>Name</th>
					            <th>Gender</th>
					            <th>Status</th>
					            <th>Species</th>
					            <th>Actions</th>
					        </tr>
					        <%
					            String sql = "SELECT animals.id_animal, animals.name_animal, animals.gender, species.name_species, animals.status_animal, animals.photo " +
					                         " FROM animals " +
					                         " JOIN species ON animals.id_species = species.id_species";
					            
					            Connection cn = ligacaomysql.criarligacao();
					            Statement st = cn.createStatement();
					            ResultSet rs = st.executeQuery(sql);
					            
					            while (rs.next()) {
					                int idAnimal = rs.getInt(1);
					                String nome = rs.getString(2);
					                String genero = rs.getString(3);
					                String especie = rs.getString(4);
					                String estado = rs.getString(5);
					                String foto = rs.getString(6);
					
					                out.println("<tr>");
					                out.println("<td>" + idAnimal + "</td>");
					                out.println("<td><img src='" + foto + "' alt='Animal Photo' style='width:100px; height:auto; border-radius: 5px;'/></td>");
					                out.println("<td>" + nome + "</td>");
					                out.println("<td>" + genero + "</td>");
					                out.println("<td>" + estado + "</td>");
					                out.println("<td>" + especie + "</td>");
					                out.println("<td>");
					                
					                // Botão Edit
					                out.println("<form action='edit_animal.jsp' method='GET' style='display: inline;'>");
					                out.println("<input type='hidden' name='id_animal' value='" + idAnimal + "' />");
					                out.println("<button type='submit' style='padding: 5px 10px; background-color: #4CAF50; color: white; border: none; cursor: pointer; border-radius: 4px;'>Edit</button>");
					                out.println("</form>");
					                
					                // Botão Delete
					                out.println("<form action='delete_animal.jsp' method='GET' style='display: inline; margin-left: 5px;'>");
					                out.println("<input type='hidden' name='id_animal' value='" + idAnimal + "' />");
					                out.println("<button type='submit' style='padding: 5px 10px; background-color: #f44336; color: white; border: none; cursor: pointer; border-radius: 4px;'>Delete</button>");
					                out.println("</form>");
					                
					                out.println("</td>");
					                out.println("</tr>");
					            }
					        %>
					    </table>
					
					    <!-- Botões -->
					    <div style="margin-top: 20px; display: flex; justify-content: space-between;">
					        <button onclick="window.location.href='add_animal.jsp'" 
					                style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer; border-radius: 4px;">
					            Add Animal
					        </button>
					        <button onclick="window.location.href='index_admin.jsp'" 
					                style="padding: 10px 20px; background-color: #f44336; color: white; border: none; cursor: pointer; border-radius: 4px;">
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