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
            <h1>Animals for Adoption</h1>
            
        </header>
        
        

        <!-- Main -->
		<div class="container" style="background-color: Gainsboro; padding: 20px; border-radius: 10px;">
		
		<table class="styled-table">
			<tr>
				<th>Photo</th>
				<th>Name</th>
				<th>Gender</th>
				<th>Status</th>
				<th>Species</th>
				<th></th>
				
				
			</tr>
				<%
				    String sql = "SELECT animals.id_animal, animals.name_animal, animals.gender, species.name_species, animals.status_animal, animals.photo " +
			                 	" FROM animals" +
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
				        out.println("<td><img src='" + foto + "' alt='Animal Photo' style='width:100px; height:auto;'/></td>");
				        out.println("<td>" + nome + "</td>");
				        out.println("<td>" + genero + "</td>");
				        out.println("<td>" + estado + "</td>");
				        out.println("<td>" + especie + "</td>");
				        // Botão de Adotar
				        if ("Available".equalsIgnoreCase(estado)) {
				            out.println("<td>");
				            out.println("<form action='form.jsp' method='post'>");
				            out.println("<input type='hidden' name='id_animal' value='" + idAnimal + "' />");
				            out.println("<input type='hidden' name='nome' value='" + nome + "' />");
				            out.println("<input type='hidden' name='genero' value='" + genero + "' />");
				            out.println("<input type='hidden' name='especie' value='" + especie + "' />");
				            out.println("<input type='hidden' name='foto' value='" + foto + "' />");
				            out.println("<button type='submit'>Adopt</button>");
				            out.println("</form>");
				            out.println("</td>");
				        } else {
				            out.println("<td></td>"); // Deixa a célula vazia caso o estado não seja "Available"
				        }
				        out.println("</tr>");
				    }
				%>
		</table>
	
	
	</div>

        <!-- Footer -->
        <section id="footer">
            <p>&copy; 2025 Adoption Agency. Design by <a href="http://html5up.net">HTML5 UP</a>.</p>
        </section>

    </div>
    

   
</body>
</html>