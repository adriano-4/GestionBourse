<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 19/05/2025
  Time: 14:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>mail</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/etudiant.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.4.2/css/all.min.css">
</head>
<body>
<header>
    <div class="gauche">
        <img onclick="window.location.href='${pageContext.request.contextPath}/dashboard.jsp'" src="${pageContext.request.contextPath}/image/logo_bourse.png" alt="Logo" width="180">
    </div>
    <p class="titre">historique des mails envoyés</p>
    <div class="droite">
        <p>Nom d'utilisateur :<span>Belou</span></p>
        <button id="déco" onclick="window.location.href='${pageContext.request.contextPath}/dashboard.jsp'">
            <i class="fa fa-home"></i>
            <span>Acceuil</span>
        </button>
    </div>
</header>
<div class="tableau" id="tableau_mail">
    <table>
        <thead>
        <tr>
            <th>Matricule</th>
            <th>Nom et Prénom</th>
            <th>Mail</th>
            <th>Date</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="mail" items="${mails}">
        <tr>
            <td>${mail.matricule}</td>
            <td>${mail.nom}</td>
            <td>${mail.mail}</td>
            <td>${mail.date_envoie}</td>
            <td><i class="fa fa-check"></i></td>
        </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
