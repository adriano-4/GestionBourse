<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 18/05/2025
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>etudiant</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/etudiant.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/crud.css">
    <script src="${pageContext.request.contextPath}/script/crud.js?v=1.0"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.4.2/css/all.min.css">

</head>
<body>
<header>
    <div class="gauche">
        <img onclick="window.location.href='${pageContext.request.contextPath}/dashboard.jsp'" src="${pageContext.request.contextPath}/image/logo_bourse.png" alt="Logo" width="180">
    </div>
    <p class="titre">Listes des étudiants</p>
    <div class="droite">
        <p>Nom d'utilisateur :<span>Belou</span></p>
        <button id="déco" onclick="window.location.href='${pageContext.request.contextPath}/dashboard.jsp'">
            <i class="fa fa-home"></i>
            <span>Acceuil</span>
        </button>
    </div>
</header>
<div class="recherche">

    <div class="search-container">
        <button class="ajouter">Ajouter<i class="fa fa-plus"></i></button>
        <form action="" method="post">
            <input type="text" placeholder="Rechercher un étudiant..." class="search-input">
            <button class="search-btn">
                <i class="fas fa-search"></i>
            </button>
        </form>
    </div>

    <div class="search-container2" >
        <select class="filter-select">
            <option value="">Tous les niveaux</option>
            <option value="L1">Licence 1</option>
            <option value="L2">Licence 2</option>
            <option value="L3">Licence 3</option>
            <option value="M1">Master 1</option>
            <option value="M2">Master 2</option>
        </select>

        <select class="filter-select">
            <option value="">Tous les établissements</option>
            <option value="ENI">ENI</option>
            <option value="EMIT">EMIT</option>
            <option value="ENS">ENS</option>
            <option value="MCI">MCI</option>
            <option value="ISTE">ISTE</option>
        </select>

        <select class="filter-select">
            <option value="">Tous âges</option>
            <option value="-18">Moins de 18 ans</option>
            <option value="+18">Plus de 18 ans</option>
        </select>
        <button>
            Valider
        </button>
    </div>

</div>
<div class="tableau">
    <table>
        <thead>
        <tr>
            <th>Matricule</th>
            <th>Nom et Prénom</th>
            <th>Sexe</th>
            <th>Date de Naissance</th>
            <th>Institution</th>
            <th>Mail</th>
            <th>Niveau</th>
            <th class="action">Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="etudiant" items="${etudiants}">
        <tr>
            <td>${etudiant.matricule}</td>
            <td>${etudiant.nom}</td>
            <td>${etudiant.sexe}</td>
            <td>${etudiant.datenais}</td>
            <td>${etudiant.institution}</td>
            <td>${etudiant.mail}</td>
            <td>${etudiant.idniv}</td>
            <td class="actions">
                <button class="btn-edit">
                    <i class="fas fa-edit"></i>
                </button>
                <button class="btn-delete">
                    <i class="fas fa-trash-alt"></i>
                </button>
            </td>
        </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div id="ajouter_div_flou">
    <div class="ajouter_div">
        <h2>Ajout d'étudiant</h2>
        <form action="/projetJSP_war_exploded/etudiants?action=ajouter" method="post">
            <div class="input-group">
                <label for="matricule">Matricule</label>
                <input type="text" id="matricule" name="matricule" required>
            </div>

            <div class="input-group">
                <label for="nom_prenom">Nom et Prénom</label>
                <input type="text" id="nom_prenom" name="nom" required>
            </div>

            <div class="input-group">
                <label for="sexe">Sexe</label>
                <select id="sexe" name="sexe" required>
                    <option value="">Sélectionner</option>
                    <option value="masculin">Masculin</option>
                    <option value="feminin">Féminin</option>
                </select>
            </div>

            <div class="input-group">
                <label for="date_naissance">Date de Naissance</label>
                <input type="date" id="date_naissance" name="datenais" required>
            </div>

            <div class="input-group">
                <label for="institution">Institution</label>
                <select id="institution" name="institution" required>
                    <option value="">Sélectionner</option>
                    <option value="ENI">ENI</option>
                    <option value="EMIT">EMIT</option>
                    <option value="ENS">ENS</option>
                    <option value="MCI">MCI</option>
                    <option value="ISTE">ISTE</option>
                </select>
            </div>

            <div class="input-group">
                <label for="mail">Mail</label>
                <input type="email" id="mail" name="mail" required>
            </div>

            <div class="input-group">
                <label for="niveau">Niveau</label>
                <select id="niveau" name="idniv" required>
                    <option value="">Sélectionner</option>
                    <option value="L1">Licence 1</option>
                    <option value="L2">Licence 2</option>
                    <option value="L3">Licence 3</option>
                    <option value="M1">Master 1</option>
                    <option value="M2">Master 2</option>
                </select>
            </div>
            <div class="bouton_ajouter">
                <button type="reset" class="btn_ann">Annuler</button>
                <button type="submit" class="btn_aj">Ajouter</button>
            </div>
        </form>
    </div>
</div>
<div id="sup_div_flou">
    <div class="sup_div">
        <h2>Voulez vous vraiment supprimer cet étudiant ?</h2>
        <p>Cet element va être supprimé définitivement</p>
        <div class="btn_supprimer">
            <button id="oui_sup">OUI</button>
            <button id="non_sup">NON</button>
        </div>
    </div>
</div>
</body>
</html>
