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
  	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
  	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<title>Rick e Morty - Indivíduos</title>
	<style type="text/css">
		body{
			background-color:darkgrey;
		}
		#header{
			position: fixed; font-style: oblique; 
			height: 120px;
			width: 100%; background-color:black; margin: 0px;
			padding: 2px;
			color: white;
		}
		h1{
			text-align: center; font-family: fantasy; font-size: 2.5em;
		}
		td{
			font-size: 1.5em;
			text-align: center;
			}
		thead{
			font-family: serif;
			font-size: 2.1em;
		}
		.table{
			position:absolute;
			z-index: -1;
			width: 95%;
			margin: 2.5%;
			margin-top: 150px;
		}
		
		form {
			display: flex;
			justify-content: center;
		}
		button {
			margin: 5px;
		}
		#titulo-info {
			display:flex;
			font-family: cursive;
			justify-content: space-around; 
		}
		img{
			border: 30px double;
		}
	</style>
</head>

<body>
	<div id="header">
		<div id="titulo-info">
			<h3>Rick e Morty</h3>
			<h3>Total de Indivíduos: <%=CharacterList.getInfo().getCount()%></h3>
		</div>
 		<h1>Página: ${page} de <%=CharacterList.getInfo().getPages()%></h1>
 		<form action="" method="get">
	 		<%
	 			int prevPage = ((int) request.getAttribute("previousPage"));
	 			if( prevPage >= 1 ) {
	 		%>
	 			<button type="submit" value="${previousPage}" name="page">Anterior</button>
	   		<%}%>
	 		
	 		<%
	 			int nPage = ((int) request.getAttribute("nextPage"));
	 			if( nPage <= CharacterList.getInfo().getPages()  ) {
	 		%>
	 			<button type="submit" value="${nextPage}" name="page">Próxima</button>
	   		<%}%>		
 		</form>
	</div>
	<div id="body">
		
 		<table class="table table-dark table-striped">
 			<thead>
 				<td>NOME</td>
 				<td>STATUS</td>
 				<td>FOTOGRAFIA</td>
 			</thead>
 			<%for(Character c: CharacterList.getResults()){%>
 				<tr>
	 				<td><%= c.getName() %></td>
	 				<td><%if(c.getStatus().equals("Alive")){%>
	 						<%= "Vivo" %>
	 					<% }else if(c.getStatus().equals("Dead")){ %>
	 						<%= "Morto" %>
	 					<% }else {%>
	 						<%= "Desconhecido" %>
	 					<% } %>
	 				</td>
	 				<td><img alt="" src=<%= c.getImage() %>></td>
 				</tr>
 			<% } %>
 		</table>
	</div>
</body>
</html>