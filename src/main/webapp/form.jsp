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
            <h2>Adoption Confirmation</h2>      
        </header>

       <%
       		String idAnimal = request.getParameter("id_animal");
		    String nome = request.getParameter("nome");
		    String especie = request.getParameter("especie");
		    String foto = request.getParameter("foto");
		%>
			
			<p>Adopting: <strong><%= nome %></strong> (Species: <%= especie %>)</p>
			<img src="<%= foto %>" alt="Animal Photo" style="width:300px; height:auto; margin-bottom:20px;"/>
			
			<p style="margin-top:20px; font-size:16px;">Adopting is a great responsibility.</p>
			<p style="margin-top:20px; font-size:16px;">Are you sure you want to adopt <%= nome%>?</p>

    <!-- Botões -->
    <form method="post" action="adoption_success.jsp" style="display:inline;">
    	<input type="hidden" name="id_animal" value="<%= idAnimal %>">
        <input type="hidden" name="nome" value="<%= nome %>">
        <input type="hidden" name="especie" value="<%= especie %>">
        <button type="submit" style="padding:10px 20px; background-color:green; color:white; border:none; cursor:pointer; border-radius: 4px;">
            Confirm Request
        </button>
    </form>

    <form method="get" action="adopt.jsp" style="display:inline;">
        <button type="submit" style="padding:10px 20px; background-color:red; color:white; border:none; cursor:pointer; border-radius: 4px;">
            Cancel
        </button>
    </form>
			
			
       
       

        <!-- Footer -->
        <section id="footer">
            <p>&copy; 2025 Adoption Agency. Design by Lia Costa.</p>
        </section>

    </div>

   
</body>
</html>