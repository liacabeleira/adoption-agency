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
            if (email != null) {
        %>
            <!-- Frase de boas-vindas -->
            <li style="margin-right: 20px; color: white; font-size: 16px;">Welcome, <%= email %></li>

            <!-- Link para a página de adoção -->
            <li style="margin-right: 20px;">
                <a href="adopt.jsp" style="color: white; text-decoration: none; font-size: 16px;">Adopt</a>
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
	
	<div id="wrapper">
	
	

    <!-- Header -->
    <header id="header">
        <h1>Adoption Successful!</h1>      
    </header>

    <p style="font-size:18px;">Congratulations on adopting <strong><%= request.getParameter("nome") %></strong> (Species: <%= request.getParameter("especie") %>)!</p>
    <p style="font-size:18px;">We will contact you soon for details.</p>
    
    <%
            // Receber parâmetros
            String idAnimal = request.getParameter("id_animal");

            // Variáveis para conexão e preparação da query
            Connection cn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                // Conectar à base de dados
                cn = ligacaomysql.criarligacao();

                // Buscar o id_user com base no email
                String getUserSql = "SELECT id_user FROM user WHERE email = ?";
                ps = cn.prepareStatement(getUserSql);
                ps.setString(1, email);
                rs = ps.executeQuery();

                if (rs.next()) {
                    int idUser = rs.getInt("id_user");

                    // Atualizar a tabela animals
                    String updateAnimalSql = "UPDATE animals SET status_animal = 'Adopted', id_user = ? WHERE id_animal = ?";
                    ps = cn.prepareStatement(updateAnimalSql);
                    ps.setInt(1, idUser); // id_user
                    ps.setString(2, idAnimal); // id_animal

                    int rowsUpdated = ps.executeUpdate();
                    if (rowsUpdated > 0) {
                        out.println("<p style='font-size:18px;'>Animal status updated successfully!</p>");
                    } else {
                        out.println("<p style='font-size:18px;'>Failed to update animal status.</p>");
                    }
                } else {
                    out.println("<p style='font-size:18px;'>User not found in the database.</p>");
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                e.printStackTrace(); // Apenas no log do servidor, não na saída da página
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (cn != null) cn.close();
                } catch (SQLException e) {
                    out.println("<p style='color:red;'>Error closing resources: " + e.getMessage() + "</p>");
                }
            }
        %>

    <!-- Footer -->
    <section id="footer" style="margin-top:40px;">
        <p>&copy; 2025 Adoption Agency. Design by Lia Costa.</p>
    </section>

</div>

	





</body>
</html>