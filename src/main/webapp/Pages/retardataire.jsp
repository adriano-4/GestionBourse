<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 18/05/2025
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>retardataire</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/etudiant.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.4.2/css/all.min.css">
    <script src="${pageContext.request.contextPath}/script/retardataire.js?v=1.0"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/retardataire.css">


</head>
<body>
<header>
    <div class="gauche">
        <img onclick="window.location.href='${pageContext.request.contextPath}/dashboard.jsp'" src="${pageContext.request.contextPath}/image/logo_bourse.png" alt="Logo" width="180">
    </div>
    <p class="titre">Listes des retardataires</p>
    <div class="droite">
        <p>Nom d'utilisateur :<span>Belou</span></p>
        <button id="déco" onclick="window.location.href='${pageContext.request.contextPath}/dashboard.jsp'">
            <i class="fa fa-home"></i>
            <span>Acceuil</span>
        </button>
    </div>
</header>
<div class="recherche">
    <!-- Champ de recherche + bouton -->
    <div class="search-container">
<%--        <input type="text" placeholder="Rechercher un étudiant..." class="search-input">--%>
<%--        <button class="search-btn">--%>
<%--            <i class="fas fa-search"></i>--%>
<%--        </button>--%>
    </div>

    <div class="search-container2" >
        <form action="/projetJSP_war_exploded/etudiants?action=retard" method="post">
        <select name="mois" id="month-filter" class="filter-select">
        </select>
        <button>
            Valider
        </button>
        </form>
    </div>

</div>
<div class="tableau">
    <table>
        <thead>
        <tr>
            <th>Matricule</th>
            <th>Nom et Prénom</th>
            <th>Sexe</th>
            <th>Date Naissance</th>
            <th>institution</th>
            <th>Mail</th>
            <th>Niveau</th>
            <th>Retards</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="retardataire" items="${retardataires}">
        <tr>
            <td>${retardataire.matricule}</td>
            <td>${retardataire.nom}</td>
            <td>${retardataire.sexe}</td>
            <td>${retardataire.datenais}</td>
            <td>${retardataire.institution}</td>
            <td>${retardataire.mail}</td>
            <td>${retardataire.idniv}</td>
            <c:choose>
                <c:when test="${retardataire.institution eq 'ENI'}">
                    <td>14 j</td>
                </c:when>
                <c:otherwise>
                    <td>19 j</td>
                </c:otherwise>
            </c:choose>
            <td>
                <a href="/projetJSP_war_exploded/mails?action=envoyer&matricule=${retardataire.matricule}&mail=${retardataire.mail}&nom=${retardataire.nom}">
                    <button class="btn-edit">
                        <i class="fa fa-paper-plane"></i>
                    </button>
                </a>
            </td>
        </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<%--<div id="mail_div_flou">--%>
<%--    <div class="mail1">--%>
<%--        <i class="fas fa-paper-plane" id="mail_check"></i>--%>
<%--        <h2 id="h2_mail">tokyadriano45@gmail.com recevra un mail<br>(trois semaine de retard)</h2>--%>
<%--        <p id="p_mail">Envoi du mail en cours ...</p>--%>
<%--        <div class="loading"></div>--%>
<%--    </div>--%>
<%--</div>--%>
</body>
</html>
