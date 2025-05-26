<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion bourse étudiant</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.5.2/css/all.min.css"></head>
<body>
<div class="login-container">
    <div class="admin-icon">
        <i class="fas fa-user-shield"></i>
    </div>

    <h2>Connexion Admin</h2>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="input-group">
            <label for="username"><i class="fas fa-user"></i> Nom d'utilisateur</label>
            <input type="text" id="username" name="username" required>
        </div>

        <div class="input-group">
            <label for="password"><i class="fas fa-lock"></i> Mot de passe</label>
            <input type="password" id="password" name="password" required>
        </div>

        <button class="continue-btn" onclick="window.location.href='dashboard.jsp'">
            Continuer
        </button>
    </form>

    <div class="footer">
        Système de gestion de bourse étudiante 2025
    </div>
</div>
</body>
</html>