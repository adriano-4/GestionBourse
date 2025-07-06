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
    <title>payer</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/etudiant.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/crud1.css">
    <script src="${pageContext.request.contextPath}/script/crudpayer.js?v=1.0"></script>
</head>
<body>
<header>
    <div class="gauche">
        <img onclick="window.location.href='${pageContext.request.contextPath}/dashboard.jsp'" src="${pageContext.request.contextPath}/image/logo_bourse.png" alt="Logo" width="180">
    </div>
    <a href="/projetJSP_war_exploded/payements?action=lister">
        <p class="titre">Listes des Payements</p>
    </a>
    <div class="droite">
        <p>Nom d'utilisateur :<span>admin</span></p>
        <button id="déco" onclick="window.location.href='${pageContext.request.contextPath}/dashboard.jsp'">
            <i class="fa fa-home"></i>
            <span>Acceuil</span>
        </button>
    </div>
</header>
<div class="recherche">
    <!-- Champ de recherche + bouton -->
    <div class="search-container">
        <button class="ajouter">Ajouter<i class="fa fa-plus"></i></button>
        <form action="/projetJSP_war_exploded/payements?action=rechercher" method="post">
            <input type="text" name="rec" placeholder="Rechercher un étudiant..." class="search-input">
            <button class="search-btn">
                <i class="fas fa-search"></i>
            </button>
        </form>
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
            <th>Niveau</th>
            <th>Année universitaire</th>
            <th>Date</th>
            <th>Nombre de mois</th>
            <th>Equipement</th>
            <th>Total payer</th>
            <th class="action">Actions</th>
        </tr>
        </thead>
        <tbody>
<c:choose>
    <c:when test="${not empty recpayer}">
        <c:forEach var="payement" items="${recpayer}">
        <tr>
            <td>${payement.matricule}</td>
            <td>${payement.name}</td>
            <td>${payement.niveau}</td>
            <td>${payement.anne_univ}</td>
            <td>${payement.daty}</td>
            <td>${payement.nbr_mois}</td>
            <td>${payement.idequipement}</td>
            <td>${payement.equipement+(payement.bourse*payement.nbr_mois)} Ar</td>
            <td class="actions">
                <a href="/projetJSP_war_exploded/payements?action=modform&idpaye=${payement.idpaye}">
                    <button class="btn-edit">
                        <i class="fas fa-edit"></i>
                    </button>
                </a>
                <a href="/projetJSP_war_exploded/payements?action=supform&idpaye=${payement.idpaye}">
                    <button class="btn-delete">
                        <i class="fas fa-trash-alt"></i>
                    </button>
                </a>
            </td>
        </tr>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <c:forEach var="payement" items="${payments}">
        <tr>
            <td>${payement.matricule}</td>
            <td>${payement.name}</td>
            <td>${payement.niveau}</td>
            <td>${payement.anne_univ}</td>
            <td>${payement.daty}</td>
            <td>${payement.nbr_mois}</td>
            <td>${payement.idequipement}</td>
            <td>${payement.equipement+(payement.bourse*payement.nbr_mois)} Ar</td>
            <td class="actions">
                <a href="/projetJSP_war_exploded/payements?action=modform&idpaye=${payement.idpaye}">
                    <button class="btn-edit">
                        <i class="fas fa-edit"></i>
                    </button>
                </a>
                <a href="/projetJSP_war_exploded/payements?action=supform&idpaye=${payement.idpaye}">
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
        <h2>Ajout de payement</h2>
        <form action="/projetJSP_war_exploded/payements?action=ajouter" method="post">
            <div class="input-group">
                <label for="idpaye">ID paye</label>
                <input type="number" id="institution" name="idpaye" value="0">
            </div>

        <div class="input-group">
            <label for="matricule">Matricule</label>
            <input type="text" id="matricule" name="matricule" required>
        </div>

        <div class="input-group">
            <label for="anne_univ">Année universitaire</label>
            <input type="text" id="annee" name="anne_univ" required>
        </div>

        <div class="input-group">
            <label for="nbr_mois">Nombre de mois</label>
            <input type="number" id="nb_mois" name="nbr_mois" required>
        </div>

        <div class="input-group">
            <label for="idequipement">Equipements</label>
            <select name="idequipement" id="equipement" required>
                <option value="" disabled selected>Selectionner option</option>
                <option value="">sans</option>
                <option value="1">avec</option>
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
            <h2>Voulez vous vraiment supprimer cet payements ?</h2>
            <p>Cet element:${idpaye}  va être supprimé définitivement</p>
            <div class="btn_supprimer">
                <a href="/projetJSP_war_exploded/payements?action=supprimer&idpaye=${idpaye}">
                    <button id="oui_sup">OUI</button>
                </a>
                <a href="/projetJSP_war_exploded/payements?action=lister">
                    <button id="non_sup">NON</button>
                </a>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${testmod}">
    <c:forEach var="payer" items="${modpayer}">
<div id="modifier_div_flou">
    <div class="modifier_div">
        <h2>Modification du payement</h2>
        <form action="/projetJSP_war_exploded/payements?action=modifier" method="post">
            <div class="input-group">
                <label for="institution">ID paye</label>
                <input type="number" id="institution_mod" name="idpaye" value="${payer.idpaye}">
            </div>

            <div class="input-group">
                <label for="matricule">Matricule</label>
                <input type="text" id="matricule_mod" name="matricule" value="${payer.matricule}" required>
            </div>

            <div class="input-group">
                <label for="annee">Année universitaire</label>
                <input type="text" id="annee_mod" name="anne_univ" value="${payer.anne_univ}" required>
            </div>

            <div class="input-group">
                <label for="daty">Date Payement</label>
                <input type="text" id="annee" name="daty" value="${payer.daty}" required>
            </div>


            <div class="input-group">
                <label for="nb_mois">Nombre de mois</label>
                <input type="number" id="nb_mois_mod" name="nbr_mois" value="${payer.nbr_mois}" required>
            </div>

            <div class="input-group">
                <label for="equipement">Equipements</label>
                <select name="idequipement" id="equipement_mod" required>
                    <option value="${payer.idequipement}">${payer.idequipement}</option>
                    <option value="2">sans</option>
                    <option value="1">avec</option>
                </select>
            </div>

            <div class="bouton_ajouter">
                <a href="/projetJSP_war_exploded/payements?action=lister"><button type="button" class="btn_ann">Annuler</button></a>
                <button type="submit" class="btn_aj">Confirmer</button>
            </div>
        </form>
    </div>
</div>
    </c:forEach>
</c:if>
</body>
</html>
