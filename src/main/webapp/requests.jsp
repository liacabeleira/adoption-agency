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
		            <h1>Pending Adoption Requests</h1>  
		        </header>
		        
		        	<div class="container" style="background-color: Gainsboro; padding: 20px; border-radius: 10px;">
					    
					    <table class="styled-table">
					        <tr>
					        	<th>Request ID</th>
					            <th>Request Date</th>
					            <th>Animal ID</th>
					            <th>Animal Name</th>
					            <th>User ID</th>
					            <th>User Name</th>
					            <th>User Surname</th>
					            <th>Request Status</th>
					            <th>Action</th>
					        </tr>
					        <% 
					         String sql = "SELECT adoption_request.id_request, adoption_request.request_date, " +
						                     " animals.id_animal, animals.name_animal, " +
						                     " user.id_user, user.firstname, user.surname, adoption_request.status_request " +
						                     " FROM adoption_request " +
						                     " JOIN animals ON adoption_request.id_animal = animals.id_animal " +
						                     " JOIN user ON adoption_request.id_user = user.id_user WHERE status_request = 'Pending'";
					        
					        Connection cn = ligacaomysql.criarligacao();
				            Statement st = cn.createStatement();
				            ResultSet rs = st.executeQuery(sql);
				            
				            while (rs.next()) {
				                int idRequest = rs.getInt(1);
				                String date = rs.getString(2);
				                String idAnimal = rs.getString(3);
				                String nameAnimal = rs.getString(4);
				                String idUser = rs.getString(5);
				                String userName = rs.getString(6);
				                String userSurname = rs.getString(7);
				                String statusRequest = rs.getString(8);
				                
				                out.println("<tr>");
				                out.println("<td>" + idRequest + "</td>");
				                out.println("<td>" + date + "</td>");
				                out.println("<td>" + idAnimal + "</td>");
				                out.println("<td>" + nameAnimal + "</td>");
				                out.println("<td>" + idUser + "</td>");
				                out.println("<td>" + userName + "</td>");
				                out.println("<td>" + userSurname + "</td>");
				                out.println("<td>" + statusRequest + "</td>");
				                out.println("<td>");
				                
				             // Botão Approve
				                out.println("<form action='approve_request.jsp' method='GET' style='display: inline;'>");
				                out.println("<input type='hidden' name='id_request' value='" + idRequest + "' />");
				                out.println("<button type='submit' style='padding: 5px 10px; background-color: #4CAF50; color: white; border: none; cursor: pointer; border-radius: 4px;'>Approve</button>");
				                out.println("</form>");
				                
				                // Botão Deny
				                out.println("<form action='deny_request.jsp' method='GET' style='display: inline; margin-left: 5px;'>");
				                out.println("<input type='hidden' name='id_request' value='" + idRequest + "' />");
				                out.println("<button type='submit' style='padding: 5px 10px; background-color: #f44336; color: white; border: none; cursor: pointer; border-radius: 4px;'>Deny</button>");
				                out.println("</form>");
				                
				                out.println("</td>");
				                out.println("</tr>");
				              }
				                
				            %>
				         </table>
				         
				         <!-- Botões -->
				        <div style="margin-top: 20px;">
				        	 <button type="button" onclick="window.location.href='approved_requests.jsp'" style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer; border-radius: 4px;">
				                Approved Requests
				            </button>
				             <button type="button" onclick="window.location.href='denied_requests.jsp'" style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer; border-radius: 4px;">
				                Denied Requests
				            </button>
				        	
				            <button type="button" onclick="window.location.href='index_admin.jsp'" style="padding: 10px 20px; background-color: #f44336; color: white; border: none; cursor: pointer; border-radius: 4px;">
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