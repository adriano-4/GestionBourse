
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>navigation gestion</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/deco.css">
    <script src="${pageContext.request.contextPath}/script/deco.js?v=1.0"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.5.2/css/all.min.css">
</head>
<body>
<header>
    <div class="gauche">
        <img src="${pageContext.request.contextPath}/image/logo_bourse.png" alt="Logo" width="180">
    </div>

    <div class="droite">
        <p>Nom d'utilisateur :<span>Belou</span></p>
        <button id="déco">
            <i class="fa fa-sign-out"></i>
            <span>Déconnecter</span>
        </button>
    </div>
</header>
<div id="navigation">
    <div class="nav" onclick="window.location.href='${pageContext.request.contextPath}/Pages/etudiant.jsp'">
        <i class="fas fa-user-graduate"></i>
        <h3>Etudiant</h3>
    </div>
    <div class="nav" onclick="window.location.href='${pageContext.request.contextPath}/Pages/montant.jsp'">
        <i class="fas fa-money-bill-wave"></i>
        <h3>Montant</h3>
    </div>
    <div class="nav" onclick="window.location.href='${pageContext.request.contextPath}/Pages/payer.jsp'">
        <i class="fas fa-credit-card"></i>
        <h3>Payer</h3>
    </div>
    <div class="nav" onclick="window.location.href='${pageContext.request.contextPath}/Pages/retardataire.jsp'">
        <i class="fas fa-clock"></i>
        <h3>Retardataire</h3>
    </div>
    <div class="nav" onclick="window.location.href='${pageContext.request.contextPath}/Pages/mail.jsp'">
        <i class="fas fa-paper-plane"></i>
        <h3>Mail envoyé</h3>
    </div>
</div>
<div id="cont">
    <div class="cont1">
        <h2>Voulez vous vous déconnecter ?</h2>
        <div class="button">
            <button id="oui2">OUI</button>
            <button id="non2">NON</button>
        </div>
    </div>
</div>
</body>
</html>
