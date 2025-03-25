<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="ligarBD.*" %>
<%@ page import="classes.Validator" %>
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

				<!-- Main -->
					<section id="main">

						<!-- Items -->
							<div class="items">

								<div class="item intro span-2">
									<h1>Adoption Agency</h1>
									<p>Make your life richer<br />
									one pet at a time!</p>
								</div>

								<article class="item thumb span-1">
									<h2>Jeremias</h2>
									<a href="images/fulls/donkey.jpg" class="image"><img src="images/thumbs/donkey.jpg" alt=""></a>
								</article>

								<article class="item thumb span-2">
									<h2>Alfredo</h2>
									<a href="images/fulls/guinea.png" class="image"><img src="images/thumbs/guinea.png" alt=""></a>
								</article>

								<article class="item thumb span-1">
									<h2>Mimi</h2>
									<a href="images/fulls/cat.jpg" class="image"><img src="images/thumbs/cat.jpg" alt=""></a>
								</article>

								<article class="item thumb span-1">
									<h2>Bonnie</h2>
									<a href="images/fulls/parrot.jpg" class="image"><img src="images/thumbs/parrot.jpg" alt=""></a>
								</article>

								<article class="item thumb span-3">
									<h2>Mickey</h2>
									<a href="images/fulls/rat.jpg" class="image"><img src="images/thumbs/rat.jpg" alt=""></a>
								</article>

								<article class="item thumb span-1">
									<h2>Galak</h2>
									<a href="images/fulls/goose.jpg" class="image"><img src="images/thumbs/goose.jpg" alt=""></a>
								</article>

								<article class="item thumb span-2">
									<h2>Filete</h2>
									<a href="images/fulls/fish.jpg" class="image"><img src="images/thumbs/fish.jpg" alt=""></a>
								</article>

								<article class="item thumb span-2">
									<h2>Jasper</h2>
									<a href="images/fulls/dog.jpg" class="image"><img src="images/thumbs/dog.jpg" alt=""></a>
								</article>

							</div>

						<!-- Items -->
							<div class="items">

								<article class="item thumb span-3"><h2>Mickey</h2><a href="images/fulls/rat.jpg" class="image"><img src="images/thumbs/rat.jpg" alt=""></a></article>
								<article class="item thumb span-1"><h2>Galak</h2><a href="images/fulls/goose.jpg" class="image"><img src="images/thumbs/goose.jpg" alt=""></a></article>
								<article class="item thumb span-2"><h2>Filete</h2><a href="images/fulls/fish.jpg" class="image"><img src="images/thumbs/fish.jpg" alt=""></a></article>
								<article class="item thumb span-2"><h2>Jasper</h2><a href="images/fulls/dog.jpg" class="image"><img src="images/thumbs/dog.jpg" alt=""></a></article>
								<article class="item thumb span-1"><h2>Jeremias</h2><a href="images/fulls/donkey.jpg" class="image"><img src="images/thumbs/donkey.jpg" alt=""></a></article>
								<article class="item thumb span-2"><h2>Alfredo</h2><a href="images/fulls/guinea.png" class="image"><img src="images/thumbs/guinea.png" alt=""></a></article>
								<article class="item thumb span-1"><h2>Mimi</h2><a href="images/fulls/cat.jpg" class="image"><img src="images/thumbs/cat.jpg" alt=""></a></article>
								<article class="item thumb span-2"><h2>Mickey</h2><a href="images/fulls/rat.jpg" class="image"><img src="images/thumbs/rat.jpg" alt=""></a></article>
								<article class="item thumb span-1"><h2>Bonnie</h2><a href="images/fulls/parrot.jpg" class="image"><img src="images/thumbs/parrot.jpg" alt=""></a></article>

							</div>

					</section>

				<!-- Footer -->
					<section id="footer">
						<section>
							 <p>&copy; 2025 Adoption Agency. Design by Lia Costa.</p>
						</section>
						<section>
							<ul class="icons">
								<li><a href="#" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li>
								<li><a href="#" class="icon brands fa-instagram"><span class="label">Instagram</span></a></li>
								<li><a href="#" class="icon brands fa-facebook-f"><span class="label">Facebook</span></a></li>
								<li><a href="#" class="icon brands fa-dribbble"><span class="label">Dribbble</span></a></li>
								<li><a href="#" class="icon solid fa-envelope"><span class="label">Email</span></a></li>
							</ul>
							<ul class="copyright">
								<li>&copy; Untitled</li><li>Design: Lia Costa</li>
							</ul>
						</section>
					</section>

			</div>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.poptrox.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
</html>