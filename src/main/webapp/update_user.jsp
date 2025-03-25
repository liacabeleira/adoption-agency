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
		            <h1>Update User</h1>  
		        </header>
		        	<%
					    // Obter os parâmetros enviados pelo formulário
					    int idUser = Integer.parseInt(request.getParameter("id_user"));
					    String roleUser = request.getParameter("role");
					    String statusUser = request.getParameter("status_user");
					
					    // Variáveis para a mensagem de status
					    String message = "";
					    boolean success = false;
					
					    try {
					        // Estabelecer conexão com o banco de dados
					        Connection cn = ligacaomysql.criarligacao();
					
					        // Query para atualizar os dados do utilizador
					        String updateSql = "UPDATE user SET role = ?, status_user = ? WHERE id_user = ?";
					        PreparedStatement pst = cn.prepareStatement(updateSql);
					        pst.setString(1, roleUser);
					        pst.setString(2, statusUser);
					        pst.setInt(3, idUser);
					
					        int rowsUpdated = pst.executeUpdate();
					
					        if (rowsUpdated > 0) {
					            // Inserir um registro na tabela admin_log
					            String insertLogSql = "INSERT INTO admin_logs (action, id_user) VALUES (?, ?)";
					            PreparedStatement logPst = cn.prepareStatement(insertLogSql);
					            logPst.setString(1, "Updated user role and/or status with ID: " + idUser);
					            logPst.setInt(2, idUser);
					            logPst.executeUpdate();
					
					            // Mensagem de sucesso
					            message = "User updated successfully!";
					            success = true;
					        } else {
					            // Mensagem de falha
					            message = "No changes were made to the user.";
					        }
					
					        cn.close();
					    } catch (Exception e) {
					        message = "Error: " + e.getMessage();
					    }
					%>
					
					
					<div class="container" style="background-color: Gainsboro; padding: 20px; border-radius: 10px; text-align: center; color: black;">
					    <h2 style="color: black;"><%= success ? "Success" : "Error" %></h2>
					    <p><%= message %></p>
					    
					    <!-- Botão Back -->
					    <div style="margin-top: 20px;">
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