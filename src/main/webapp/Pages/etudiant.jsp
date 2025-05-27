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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/crud1.css">
<%--    <script src="${pageContext.request.contextPath}/script/crud.js?v=1.0"></script>--%>
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
        <form action="/projetJSP_war_exploded/etudiants?action=rechercher" method="post">
            <input  name="recherche" type="text" placeholder="Rechercher un étudiant..." class="search-input">
            <button class="search-btn">
                <i class="fas fa-search"></i>
            </button>
        </form>
    </div>

    <div class="search-container2" >
        <form action="/projetJSP_war_exploded/etudiants?action=trier" method="post">
        <select name="niveau" class="filter-select">
            <option value="none">Tous les niveaux</option>
            <option value="L1">Licence 1</option>
            <option value="L2">Licence 2</option>
            <option value="L3">Licence 3</option>
            <option value="M1">Master 1</option>
            <option value="M2">Master 2</option>
        </select>

        <select name="etab" class="filter-select">
            <option value="none">Tous les établissements</option>
            <option value="ENI">ENI</option>
            <option value="EMIT">EMIT</option>
            <option value="ENS">ENS</option>
            <option value="MCI">MCI</option>
            <option value="ISTE">ISTE</option>
        </select>

        <select name="age" class="filter-select">
            <option value="none">Tous âges</option>
            <option value="-18">Moins de 18 ans</option>
            <option value="+18">Plus de 18 ans</option>
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
            <th>Date de Naissance</th>
            <th>Institution</th>
            <th>Mail</th>
            <th>Niveau</th>
            <th class="action">Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty recherches}">
                <c:forEach var="etudiant" items="${recherches}">
                    <tr>
                        <td>${etudiant.matricule}</td>
                        <td>${etudiant.nom}</td>
                        <td>${etudiant.sexe}</td>
                        <td>${etudiant.datenais}</td>
                        <td>${etudiant.institution}</td>
                        <td>${etudiant.mail}</td>
                        <td>${etudiant.idniv}</td>
                        <td class="actions">
                            <a href="/projetJSP_war_exploded/etudiants?action=modform&matricule=${etudiant.matricule}">
                                <button class="btn-edit">
                                    <i class="fas fa-edit"></i>
                                </button>
                            </a>
                            <a href="/projetJSP_war_exploded/etudiants?action=supform">
                                <button class="btn-delete">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:when test="${not empty triers}">
                <c:forEach var="etudiant" items="${triers}">
                    <tr>
                        <td>${etudiant.matricule}</td>
                        <td>${etudiant.nom}</td>
                        <td>${etudiant.sexe}</td>
                        <td>${etudiant.datenais}</td>
                        <td>${etudiant.institution}</td>
                        <td>${etudiant.mail}</td>
                        <td>${etudiant.idniv}</td>
                        <td class="actions">
                            <a href="/projetJSP_war_exploded/etudiants?action=modform&matricule=${etudiant.matricule}">
                                <button class="btn-edit">
                                    <i class="fas fa-edit"></i>
                                </button>
                            </a>
                            <a href="/projetJSP_war_exploded/etudiants?action=supform">
                                <button class="btn-delete">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
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
                            <a href="/projetJSP_war_exploded/etudiants?action=modform&matricule=${etudiant.matricule}">
                                <button class="btn-edit">
                                    <i class="fas fa-edit"></i>
                                </button>
                            </a>
                            <a href="/projetJSP_war_exploded/etudiants?action=supform&matricule=${etudiant.matricule}">
                                <button class="btn-delete">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
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
                <label for="nom">Nom et Prénom</label>
                <input type="text" id="nom_prenom" name="nom" required>
            </div>

            <div class="input-group">
                <label for="sexe">Sexe</label>
                <select id="sexe" name="sexe" required>
                    <option value="">Sélectionner</option>
                    <option value="Masculin">Masculin</option>
                    <option value="Feminin">Féminin</option>
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
<c:if test="${testsup}">
    <div id="sup_div_flou">
        <div class="sup_div">
            <h2>Voulez vous vraiment supprimer cet étudiant ?</h2>
            <p>Cet element:${matricule}  va être supprimé définitivement</p>
            <div class="btn_supprimer">
                <a href="/projetJSP_war_exploded/etudiants?action=supprimer&matricule=${matricule}">
                <button id="oui_sup">OUI</button>
                </a>
                <a href="/projetJSP_war_exploded/etudiants?action=lister">
                <button id="non_sup">NON</button>
                </a>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${testmod}">
    <c:forEach var="etudiant" items="${modetudiant}">
<div id="modifier_div_flou">
    <div class="modifier_div">
        <h2>Modification d'étudiant</h2>
        <form action="/projetJSP_war_exploded/etudiants?action=modifier" method="post">
            <div class="input-group">
                <label for="matricule">Matricule</label>
                <input type="text" id="matricule_mod" name="matricule" value="${etudiant.matricule}" required>
            </div>

            <div class="input-group">
                <label for="nom_prenom">Nom et Prénom</label>
                <input type="text" id="nom_prenom_mod" name="nom" value="${etudiant.nom}" required>
            </div>

            <div class="input-group">
                <label for="sexe">Sexe</label>
                <select id="sexe_mod" name="sexe" required>
                    <option value="${etudiant.sexe}">${etudiant.sexe}</option>
                    <option value="Masculin">Masculin</option>
                    <option value="Feminin">Féminin</option>
                </select>
            </div>

            <div class="input-group">
                <label for="date_naissance">Date de Naissance</label>
                <input type="date" id="date_naissance_mod" name="datenais" value="${etudiant.datenais}" required>
            </div>

            <div class="input-group">
                <label for="institution">Institution</label>
                <select id="institution_mod" name="institution" required>
                    <option value="${etudiant.institution}">${etudiant.institution}</option>
                    <option value="ENI">ENI</option>
                    <option value="EMIT">EMIT</option>
                    <option value="ENS">ENS</option>
                    <option value="MCI">MCI</option>
                    <option value="ISTE">ISTE</option>
                </select>
            </div>

            <div class="input-group">
                <label for="mail">Mail</label>
                <input type="email" id="mail_mod" name="mail" value="${etudiant.mail}" required>
            </div>

            <div class="input-group">
                <label for="niveau">Niveau</label>
                <select id="niveau_mod" name="idniv" required>
                    <option value="${etudiant.idniv}">${etudiant.idniv}</option>
                    <option value="L1">Licence 1</option>
                    <option value="L2">Licence 2</option>
                    <option value="L3">Licence 3</option>
                    <option value="M1">Master 1</option>
                    <option value="M2">Master 2</option>
                </select>
            </div>
            <div class="bouton_ajouter">
                <button type="reset" class="btn_ann">Annuler</button>
                <button type="submit" class="btn_aj">Confirmer</button>
            </div>
        </form>
    </div>
</div>
    </c:forEach>
</c:if>
</body>
</html>
