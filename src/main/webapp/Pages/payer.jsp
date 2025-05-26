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
    <title>payer</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/etudiant.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/crud.css">
    <script src="${pageContext.request.contextPath}/script/crudpayer.js?v=1.0"></script>
</head>
<body>
<header>
    <div class="gauche">
        <img onclick="window.location.href='${pageContext.request.contextPath}/dashboard.jsp'" src="${pageContext.request.contextPath}/image/logo_bourse.png" alt="Logo" width="180">
    </div>
    <p class="titre">Listes des Payements</p>
    <div class="droite">
        <p>Nom d'utilisateur :<span>Belou</span></p>
        <button id="déco" onclick="window.location.href=${pageContext.request.contextPath}/dashboard.jsp'">
            <i class="fa fa-home"></i>
            <span>Acceuil</span>
        </button>
    </div>
</header>
<div class="recherche">
    <!-- Champ de recherche + bouton -->
    <div class="search-container">
        <button class="ajouter">Ajouter<i class="fa fa-plus"></i></button>
        <input type="text" placeholder="Rechercher un étudiant..." class="search-input">
        <button class="search-btn">
            <i class="fas fa-search"></i>
        </button>
    </div>

    <div class="search-container2" >

    </div>

</div>
<div class="tableau">
    <table>
        <thead>
        <tr>
            <th>Matricule</th>
            <th>Nom et Prénom</th>
            <th>Année universitaire</th>
            <th>Date</th>
            <th>Nombre de mois</th>
            <th class="action">Actions</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>3011</td>
            <td>RANDRIANAMBININA Toky Adriano</td>
            <td>2024-2025</td>
            <td>15/03/2025</td>
            <td>3</td>
            <td class="actions">
                <button class="btn-edit">
                    <i class="fas fa-edit"></i>
                </button>
                <button class="btn-delete">
                    <i class="fas fa-trash-alt"></i>
                </button>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<div id="ajouter_div_flou">
    <div class="ajouter_div">
        <h2>Ajout de payement</h2>
        <div class="input-group">
            <label for="matricule">Matricule</label>
            <input type="text" id="matricule" name="matricule" required>
        </div>

        <div class="input-group">
            <label for="institution">Institution</label>
            <input type="text" id="institution" name="institution" required>
        </div>

        <div class="input-group">
            <label for="annee">Année universitaire</label>
            <input type="text" id="annee" name="annee" required>
        </div>

        <div class="input-group">
            <label for="nb_mois">Nombre de mois</label>
            <input type="number" id="nb_mois" name="nb_mois" required>
        </div>

        <div class="bouton_ajouter">
            <button class="btn_ann">Annuler</button>
            <button class="btn_aj">Ajouter</button>
        </div>

    </div>
</div>
<div id="sup_div_flou">
    <div class="sup_div">
        <h2>Voulez vous vraiment supprimer ce payement ?</h2>
        <p>Cet element va être supprimé définitivement</p>
        <div class="btn_supprimer">
            <button id="oui_sup">OUI</button>
            <button id="non_sup">NON</button>
        </div>
    </div>
</div>
</body>
</html>
