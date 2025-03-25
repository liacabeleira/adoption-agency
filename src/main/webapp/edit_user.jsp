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
		            <h1>Edit User</h1>  
		        </header>
		        
		        		<!-- Main -->
						<div class="container" style="background-color: Gainsboro; padding: 20px; border-radius: 10px;">
						    <form action="update_user.jsp" method="post">
						        <table class="styled-table" style="width: 100%; margin-top: 20px;">
						        
						        <%
								    // Obter o ID do utilizador passado pelo formulário
								    int idUser = Integer.parseInt(request.getParameter("id_user"));
								
								    // Query para obter os dados do utilizador pelo ID
								    String sql = "SELECT id_user, role, status_user FROM user WHERE id_user = ?";
								    
								    String roleUser = "";
								    String statusUser = "";
								    
								    try {
								        Connection cn = ligacaomysql.criarligacao();
								        PreparedStatement pst = cn.prepareStatement(sql);
								        pst.setInt(1, idUser);
								        ResultSet rs = pst.executeQuery();
								
								        if (rs.next()) {
								            roleUser = rs.getString("role");
								            statusUser = rs.getString("status_user");
								        }
								    } catch (Exception e) {
								        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
								    }
								%>
						            <tr>
						                <th>ID</th>
						                <th>Role</th>
						                <th>Status</th>
						            </tr>
						            <tr>
						                <!-- ID do utilizador (não editável) -->
						                <td>
						                    <input type="text" name="id_user" value="<%= idUser %>" readonly 
						                           style="background-color: #e9e9e9; border: none; text-align: center; color: black;" />
						                </td>
						                
						                <!-- Dropdown para Role -->
						                <td>
						                    <select name="role" style="padding: 5px; border-radius: 4px; width: 100%; color: black;">
						                        <option value="admin" <%= roleUser.equals("admin") ? "selected" : "" %>>Admin</option>
						                        <option value="user" <%= roleUser.equals("user") ? "selected" : "" %>>User</option>
						                    </select>
						                </td>
						
						                <!-- Dropdown para Status -->
						                <td>
						                    <select name="status_user" style="padding: 5px; border-radius: 4px; width: 100%; color: black;">
						                        <option value="Active" <%= statusUser.equals("Active") ? "selected" : "" %>>Active</option>
						                        <option value="Inactive" <%= statusUser.equals("Inactive") ? "selected" : "" %>>Inactive</option>
						                    </select>
						                </td>
						            </tr>
						        </table>
						
						        <!-- Botões -->
						        <div style="margin-top: 20px; text-align: center;">
						            <button type="submit" style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer; border-radius: 4px;">
						                Save Changes
						            </button>
						            <button type="button" onclick="window.location.href='users.jsp'" 
						                    style="padding: 10px 20px; margin-left: 10px; background-color: red; color: white; border: none; cursor: pointer; border-radius: 4px;">
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