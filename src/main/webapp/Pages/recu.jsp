<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 18/05/2025
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>recu</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/etudiant.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/recu.css">
  </head>
  <body>
  <header>
    <div class="gauche">
      <img src="${pageContext.request.contextPath}/image/logo_bourse.png" alt="Logo" width="180">
    </div>
    <p class="titre">Reçu de payement de bourse</p>
    <div class="droite">
      <p>Nom d'utilisateur :<span>Belou</span></p>
    </div>
  </header>

  <div class="pdf">
    <div class="exporter_div">
      <button class="exporter">Exporter<i class="fa fa-download"></i></button>
    </div>
    <div class="pdf_recu">
      <div class="date_titre">
        <p></p>
      </div>
    </div>
  </div>
  </body>
</html>
