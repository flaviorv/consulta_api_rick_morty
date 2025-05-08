<%@page import="ch.qos.logback.core.net.SyslogOutputStream"%>
<%@page import="br.edu.infnet.request.CharacterListRequest"%>
<%@page import="br.edu.infnet.domain.CharacterList" %>
<%@page import="br.edu.infnet.domain.Character" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/characters.css">
  	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
  	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<title>Rick e Morty - Personagens</title>
</head>

<body id="body">
	<nav id="nav">
		<img
			id="nav-logo"
			src="${pageContext.request.contextPath}/image/rm_logo.png"
			alt="Logo Rick and Morty na barra de navegação"
		>
		<div id="nav-pages">
			<h2>Página: ${page} de <%=CharacterList.getInfo().getPages()%></h2>
			<form action="" method="get">
				<%
					int prevPage = ((int) request.getAttribute("previousPage"));
					if( prevPage >= 1 ) {
				%>
				<button class="nav-button" type="submit" value="${previousPage}" name="page"><</button>
				<%}%>

				<%
					int nPage = ((int) request.getAttribute("nextPage"));
					if( nPage <= CharacterList.getInfo().getPages()  ) {
				%>
				<button class="nav-button" type="submit" value="${nextPage}" name="page">></button>
				<%}%>
			</form>
		</div>
		<h3>Total de Indivíduos: <%=CharacterList.getInfo().getCount()%></h3>
	</nav>
	<form id="search-form" action="">
		<i class="bi bi-search" style="font-weight: bolder"></i>
		<input id="search-input" type="text" placeholder="Busca"/>
	</form>
	<div id="search-div">
		<ul>
			<li id="search-name"></li>
			<li id="search-status"></li>
			<li id="search-species"></li>
			<li id="search-type"></li>
			<li id="search-gender"></li>
			<li id="search-origin"></li>
			<li id="search-location"></li>
		</ul>
		<img id="search-img" src="${pageContext.request.contextPath}/image/no_profile.png" alt="Imagem do elemento encontrado na busca">
	</div>
	<div id="table-div" class="d-flex justify-content-center vh-100">
		<table id="table" class="table-dark table-striped table-bordered mb-0">
			<thead class="text-center align-middle">
				<td>Nome</td>
				<td>Status</td>
				<td>Foto</td>
			</thead>
			<%for(Character c: CharacterList.getResults()){%>
				<tr class="align-middle text-center">
					<td class="align-middle text-center"><%= c.getName() %></td>
					<td class="align-middle text-center "><%if(c.getStatus().equals("Alive")){%>
							<%= "Vivo" %>
						<% }else if(c.getStatus().equals("Dead")){ %>
							<%= "Morto" %>
						<% }else {%>
							<%= "Desconhecido" %>
						<% } %>
					</td>
					<td class="align-middle">
						<img id="character-picture" alt="Foto do personagem" src=<%= c.getImage() %>>
					</td>
				</tr>
			<% } %>
		</table>
	</div>
	<script>
		document.addEventListener("DOMContentLoaded", () => {
			const nav = document.getElementById("nav");
			const input = document.getElementById("search-input");
			const searchForm = document.getElementById("search-form")
			const tableDiv = document.getElementById("table-div");
			const table = document.getElementById("table");
			const searchDiv = document.getElementById("search-div");
			const body = document.getElementById("body")

			if (input) {
				input.addEventListener("focus", () => {
					nav.classList.add("remove-nav");
					searchForm.classList.add("search-form-to-top")
					table.classList.add("remove-table")
					tableDiv.classList.add("remove-table")
					searchDiv.classList.add("search-div-appearing")
					body.classList.add("body-on-search")
				});

				input.addEventListener("blur", () => {
					nav.classList.remove("remove-nav");
					searchForm.classList.remove("search-form-to-top")
					table.classList.remove("remove-table")
					tableDiv.classList.remove("remove-table")
					searchDiv.classList.remove("search-div-appearing")
					body.classList.remove("body-on-search")
				});
			}
		});
	</script>
</body>
</html>