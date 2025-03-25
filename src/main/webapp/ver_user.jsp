<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="ligarBD.*" %>
<%@page import="classes.Validator" %>
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
			<a href="index.jsp" style="color: white; text-decoration: none; font-size: 20px; font-weight: bold;">Adoption Agency</a>
			<ul style="list-style-type: none; margin: 0; padding: 0; display: flex;">
				<li style="margin-left: 20px;">
					<a href="login.jsp" style="color: white; text-decoration: none; font-size: 16px;">Login</a>
				</li>
			</ul>
		</nav>
		
				<!-- Wrapper -->
				<div id="wrapper">
				
				<!-- Header -->
		        <header id="header">
		            <h1>Verify User</h1>  
		        </header>
				
					 <%
			    String email = request.getParameter("txt_email");
			    String password = request.getParameter("txt_password");
			
			    if (email != null && password != null) {
			        try {
			            // Conexão com a base de dados
			            Connection cn = ligacaomysql.criarligacao();
			
			            // Obter id_user e status_user pelo email
			            String queryUser = "SELECT id_user, status_user, role FROM user WHERE email = ?";
			            PreparedStatement psUser = cn.prepareStatement(queryUser);
			            psUser.setString(1, email);
			            ResultSet rsUser = psUser.executeQuery();
			
			            if (rsUser.next()) {
			                int idUser = rsUser.getInt("id_user");
			                String statusUser = rsUser.getString("status_user");
			                String role = rsUser.getString("role");
			
			                // Verificar se o usuário está activo
			                if (statusUser.equals("Inactive")) {
			                    out.println("<h1 style='color: red;'>Your account is locked due to too many failed login attempts. Please contact support.</h1>");
			                } else {
			                    // Verificar credenciais
			                    String queryLogin = "SELECT * FROM user WHERE email = ? AND password = SHA2(?, 256)";
			                    PreparedStatement psLogin = cn.prepareStatement(queryLogin);
			                    psLogin.setString(1, email);
			                    psLogin.setString(2, password);
			                    ResultSet rsLogin = psLogin.executeQuery();
			
			                    if (rsLogin.next()) {
			                        // Login bem-sucedido
			                        session.setMaxInactiveInterval(30 * 60); // Tempo em segundos (30 minutos)
			                        session.setAttribute("email", email); // Armazena o email na sessão
			                        session.setAttribute("role", role); // Armazena o role na sessão
			                        session.setAttribute("id_user", idUser); // Armazena o id_user na sessão
			                        
			                        
			                        // Registrar tentativa bem-sucedida
			                        String insertLoginAttempt = "INSERT INTO login_attempts (id_user, success) VALUES (?, 1)";
			                        PreparedStatement psInsertSuccess = cn.prepareStatement(insertLoginAttempt);
			                        psInsertSuccess.setInt(1, idUser);
			                        psInsertSuccess.executeUpdate();
			
			                        // Redirecionar com base no role
			                        if ("admin".equals(role)) {
			                            response.sendRedirect("index_admin.jsp");
			                        } else {
			                            response.sendRedirect("index_user.jsp");
			                        }
			                    } else {
			                        // Login falhou
			                        String insertLoginAttempt = "INSERT INTO login_attempts (id_user, success) VALUES (?, 0)";
			                        PreparedStatement psInsertFail = cn.prepareStatement(insertLoginAttempt);
			                        psInsertFail.setInt(1, idUser);
			                        psInsertFail.executeUpdate();
			
			                        out.println("<h1 style='color: red;'>Invalid email or password!</h1><br>");
			                        
			                    }
			
			                    rsLogin.close();
			                }
			            } else {
			                // Email não encontrado
			                out.println("<h1 style='color: red;'>Invalid email or password!</h1><br>");
			               
			            }
			
			            rsUser.close();
			            psUser.close();
			            cn.close();
			        } catch (Exception e) {
			            out.println("<h1>Ocorreu um erro: " + e.getMessage() + "</h1>");
			        }
			    } else {
			        out.println("<h1 style='color: red;'>Please fill in all the fields!!</h1>");
			    }
			%>
			
			
				<!-- Botões -->
	            <div style="margin-top: 20px;">
	                <button type="button" onclick="window.location.href='login.jsp'" style="padding: 10px 20px; background-color: #f44336; color: white; border: none; cursor: pointer; border-radius: 4px;">
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