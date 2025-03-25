<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="ligarBD.*" %>
<%@ page import="classes.Validator" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout</title>
</head>
<body>
		<%
		    // Invalida a sessão para terminar o login do utilizador
		    if (session != null) {
		        session.invalidate();
		    }
		    // Redireciona para a página de login
		    response.sendRedirect("login.jsp");
		%>

</body>
</html>