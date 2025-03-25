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
		            <h1>Admin Users List</h1>  
		        </header>
		        
		        	<!-- Main -->
						<div class="container" style="background-color: Gainsboro; padding: 20px; border-radius: 10px;">
						    <table class="styled-table">
						        <tr>
						            <th>ID</th>
						            <th>First Name</th>
						            <th>Surname</th>
						            <th>Email</th>
						            <th>Address</th>
						            <th>Zip Code</th>
						            <th>City</th>
						            <th>Country</th>
						            <th>Phone Number</th>
						            <th>Role</th>
						            <th>Status</th>
						            <th>Action</th>
						        </tr>
						       <%
						            // Query para obter os utilizadores
						            String sql = "SELECT id_user, firstname, surname, email, address, zip_code, city, country, phone_number, role, status_user FROM user WHERE role = 'admin' ORDER BY id_user";
						        
						            Connection cn = ligacaomysql.criarligacao();
						            Statement st = cn.createStatement();
						            ResultSet rs = st.executeQuery(sql);
						        
						            // Gerar as linhas da tabela
						            while (rs.next()) {
						                int idUser = rs.getInt("id_user");
						                String firstName = rs.getString("firstname");
						                String surname = rs.getString("surname");
						                String emailUser = rs.getString("email");
						                String address = rs.getString("address");
						                String zipCode = rs.getString("zip_code");
						                String city = rs.getString("city");
						                String country = rs.getString("country");
						                String phoneNumber = rs.getString("phone_number");
						                String roleUser = rs.getString("role");
						                String statusUser = rs.getString("status_user");
						        
						                out.println("<tr>");
						                out.println("<td>" + idUser + "</td>");
						                out.println("<td>" + firstName + "</td>");
						                out.println("<td>" + surname + "</td>");
						                out.println("<td>" + emailUser + "</td>");
						                out.println("<td>" + address + "</td>");
						                out.println("<td>" + zipCode + "</td>");
						                out.println("<td>" + city + "</td>");
						                out.println("<td>" + country + "</td>");
						                out.println("<td>" + phoneNumber + "</td>");
						                out.println("<td>" + roleUser + "</td>");
						                out.println("<td>" + statusUser + "</td>");
						        
						                // Botão Edit
						                out.println("<td>");
						                out.println("<form action='edit_user.jsp' method='post'>");
						                out.println("<input type='hidden' name='id_user' value='" + idUser + "' />");
						                out.println("<button type='submit' style='padding: 5px 10px; background-color: #4CAF50; color: white; border: none; cursor: pointer; border-radius: 4px;'>Edit</button>");
						                out.println("</form>");
						                out.println("</td>");
						                out.println("</tr>");
						            }
						        %>
						    </table>

					    <!-- Botões -->
					    <div style="margin-top: 20px; text-align: center;">
					        <button onclick="window.location.href='users.jsp'" 
					                style="padding: 10px 20px; background-color: red; color: white; border: none; cursor: pointer; border-radius: 4px;">
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