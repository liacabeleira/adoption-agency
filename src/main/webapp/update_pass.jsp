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
		            	 if ("admin".equals(role)) {
		                     // Redireciona para a página de admin se o role for admin
		                     response.sendRedirect("index_admin.jsp");
		                     return;
		                 }
		        %>
		            <!-- Frase de boas-vindas -->
		            <li style="margin-right: 20px; color: white; font-size: 16px;">Welcome, <%= email %></li>
		
		            <!-- Link para a página de adoção -->
		            <li style="margin-right: 20px;">
		                <a href="adopt.jsp" style="color: white; text-decoration: none; font-size: 16px;">Adopt</a>
		            </li>
		            
		            <!-- Link para a página de detalhes da conta -->
		            <li style="margin-right: 20px;">
		                <a href="account.jsp" style="color: white; text-decoration: none; font-size: 16px;">Account</a>
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
		            <h1>Edit Details</h1>  
		        </header>
		       <%
				    String oldPassword = request.getParameter("old_password");
				    String newPassword = request.getParameter("new_password");
				    String confirmPassword = request.getParameter("confirm_new_password");
				
				    if (email != null && oldPassword != null && newPassword != null && confirmPassword != null) {
				        try {
				            // Conexão com a base de dados
				            Connection cn = ligacaomysql.criarligacao();
				
				            // Verificar se a senha antiga está correcta
				            String queryVerifyOldPassword = "SELECT * FROM user WHERE email = ? AND password = SHA2(?, 256)";
				            PreparedStatement psVerifyOldPassword = cn.prepareStatement(queryVerifyOldPassword);
				            psVerifyOldPassword.setString(1, email);
				            psVerifyOldPassword.setString(2, oldPassword);
				            ResultSet rsVerifyOldPassword = psVerifyOldPassword.executeQuery();
				
				            if (rsVerifyOldPassword.next()) {
				                // Verificar se a nova senha já foi usada
				                String queryCheckHistory = "SELECT COUNT(*) AS count FROM password_history WHERE id_user = ? AND old_password = SHA2(?, 256)";
				                PreparedStatement psCheckHistory = cn.prepareStatement(queryCheckHistory);
				                psCheckHistory.setInt(1, rsVerifyOldPassword.getInt("id_user")); // Obtém o id_user do resultado anterior
				                psCheckHistory.setString(2, newPassword);
				                ResultSet rsCheckHistory = psCheckHistory.executeQuery();
				
				                if (rsCheckHistory.next() && rsCheckHistory.getInt("count") == 0) {
				                    // Verificar se a nova senha é válida e corresponde à confirmação
				                    if (Validator.isValidPassword(newPassword, confirmPassword)) {
				                        // Atualizar a senha no banco de dados
				                        String queryUpdatePassword = "UPDATE user SET password = ? WHERE email = ?";
				                        PreparedStatement psUpdatePassword = cn.prepareStatement(queryUpdatePassword);
				                        psUpdatePassword.setString(1, newPassword);
				                        psUpdatePassword.setString(2, email);
				                        int rowsAffected = psUpdatePassword.executeUpdate();
				
				                        if (rowsAffected > 0) {
				                            out.println("<h1 style='color: green;'>Password updated successfully!</h1>");
				                            out.println("<a href='account.jsp'>Go back to Account</a>");
				                        } else {
				                            out.println("<h1 style='color: red;'>Failed to update password. Please try again.</h1>");
				                        }
				
				                        psUpdatePassword.close();
				                    } else {
				                        out.println("<h1 style='color: red;'>New password is invalid or does not match the confirmation.</h1>");
				                    }
				                } else {
				                    out.println("<h1 style='color: red;'>This password has already been used. Please choose a different one.</h1>");
				                }
				
				                rsCheckHistory.close();
				                psCheckHistory.close();
				            } else {
				                out.println("<h1 style='color: red;'>Old password is incorrect.</h1>");
				            }
				
				            rsVerifyOldPassword.close();
				            psVerifyOldPassword.close();
				            cn.close();
				        } catch (Exception e) {
				            out.println("<h1>Ocorreu um erro: " + e.getMessage() + "</h1>");
				        }
				    } else {
				        out.println("<h1 style='color: red;'>Please fill in all fields!</h1>");
				    }
				%>
				
				<!-- Botões -->
			        <div style="margin-top: 20px;">
			            <button type="button" onclick="window.location.href='account.jsp'" style="padding: 10px 20px; background-color: #f44336; color: white; border: none; cursor: pointer; border-radius: 4px;">
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