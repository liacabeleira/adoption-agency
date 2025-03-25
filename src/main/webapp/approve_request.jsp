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
		            <h1>Approve Request</h1>  
		        </header>
		        	<%
		        	 	int userId = (int) session.getAttribute("id_user");
		        		String idRequest = request.getParameter("id_request");
		        		
			        	Connection cn = null;
		                PreparedStatement psUpdateAnimal = null;
		                PreparedStatement psUpdateRequest = null;
		                PreparedStatement psInsertLog = null;
	
		                try {
		                    // Conexão com a base de dados
		                    cn = ligacaomysql.criarligacao();
	
		                    // Atualizar status do animal para "Adopted"
		                    String updateAnimalSql = "UPDATE animals " +
		                                             " SET status_animal = 'Adopted' " +
		                                             " WHERE id_animal = (SELECT id_animal FROM adoption_request WHERE id_request = ?)";
		                    psUpdateAnimal = cn.prepareStatement(updateAnimalSql);
		                    psUpdateAnimal.setString(1, idRequest);
		                    psUpdateAnimal.executeUpdate();
	
		                    // Atualizar status do pedido para "Approved"
		                    String updateRequestSql = "UPDATE adoption_request SET status_request = 'Approved' WHERE id_request = ?";
		                    psUpdateRequest = cn.prepareStatement(updateRequestSql);
		                    psUpdateRequest.setString(1, idRequest);
		                    psUpdateRequest.executeUpdate();
	
		                    // Inserir log na tabela admin_log
		                    String insertLogSql = "INSERT INTO admin_logs (id_user, action) VALUES (?, ?)";
		                    psInsertLog = cn.prepareStatement(insertLogSql);
		                    psInsertLog.setInt(1, userId);
		                    psInsertLog.setString(2, "Approved adoption request ID: " + idRequest);
		                    psInsertLog.executeUpdate();
	
		                    out.println("<p style='color: green;'>Sucessfully approved request! </p>");
	
		                } catch (Exception e) {
		                	out.println("<p style='color: red;'>Error approving request </p>");
		                } finally {
		                    // Fechar conexões
		                    if (psUpdateAnimal != null) psUpdateAnimal.close();
		                    if (psUpdateRequest != null) psUpdateRequest.close();
		                    if (psInsertLog != null) psInsertLog.close();
		                    if (cn != null) cn.close();
		                }
		                
		                
		        %>
		        <div style="margin-top: 20px;">
		        <button onclick="window.location.href='requests.jsp'" style="padding: 10px 20px; background-color: #f44336; color: white; border: none; cursor: pointer; border-radius: 4px;">
		        	Back
		        </button>
		        </div>
	        
		        
		      	
		      	
		      	
		      	 <!-- Footer -->
			        <section id="footer">
			            <p>&copy; 2025 Adoption Agency. Design by Lia Costa.</p>
			        </section>
					
			</div>
	
	
		
	</body>
</html>