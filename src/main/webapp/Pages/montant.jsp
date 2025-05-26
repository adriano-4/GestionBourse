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
    <title>montant</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/etudiant.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/etudiant2.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/crud.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/crud2.css">
    <script src="${pageContext.request.contextPath}/script/crudmontant.js?v=1.0"></script>
</head>
<body>
<header>
    <div class="gauche">
        <img onclick="window.location.href='${pageContext.request.contextPath}/dashboard.jsp'" src="${pageContext.request.contextPath}/image/logo_bourse.png" alt="Logo" width="180">
    </div>
    <p class="titre">Montant par niveau</p>
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
    </div>

    <div class="search-container2" >

    </div>

</div>
<div class="tableau">
    <table>
        <thead>
        <tr>
            <th>ID Niveau</th>
            <th>Niveau</th>
            <th>Statut</th>
            <th>Montant</th>
            <th class="action">Actions</th>
        </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty montants}">
                    <tr class="empty-table-message">
                        <td colspan="7">
                            <div class="empty-message-container">
                                <i class="fas fa-clipboard-list empty-icon"></i>
                                <p>Aucune donnée disponible</p>
                            </div>
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="montant" items="${montants}">
                    <tr>
                        <td>${montant.idniv}</td>
                        <td>${montant.niveau}</td>
                        <td>${montant.statut}</td>
                        <td>${montant.montant} Ar</td>
                        <td class="actions">
                            <button class="btn-edit" onclick="modifier_montant()">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="btn-delete" onclick="supprimer_montant()">
                                <i class="fas fa-trash-alt"></i>
                            </button>
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
        <h2>Ajout de montant</h2>
        <form action="/projetJSP_war_exploded/montants?action=ajouter" method="post">
        <div class="input-group">
            <label for="idniv">ID Niveau</label>
            <input type="text" id="idniv" name="idniv" required>
        </div>

        <div class="input-group">
            <label for="niveau">Niveau</label>
            <input type="text" id="niveau" name="niveau" required>
        </div>

        <div class="input-group">
            <label for="statut">Statut</label>
            <select name="statut" id="statut" required>
                <option value="" disabled selected>Choisir un statut</option>
                <option value="redoublant">Redoublant</option>
                <option value="passant">Passant</option>
            </select>
        </div>

        <div class="input-group">
            <label for="montant">Montant</label>
            <input type="text" id="montant" name="montant" required>
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
        <h2>Voulez vous vraiment supprimer ce montant ?</h2>
        <p>Cet element va être supprimé définitivement</p>
        <div class="btn_supprimer">
            <button id="oui_sup" onclick="annuler_supprimer()">OUI</button>
            <button id="non_sup">NON</button>
        </div>
    </div>
</div>
<div id="modifier_div_flou">
    <div class="modifier_div">
        <h2>Modification de montant</h2>
        <form action="/projetJSP_war_exploded/montants?action=ajouter" method="post">
            <div class="input-group">
                <label for="idniv">ID Niveau</label>
                <input type="text" id="idniv_mod" name="idniv" required>
            </div>

            <div class="input-group">
                <label for="niveau">Niveau</label>
                <input type="text" id="niveau_mod" name="niveau" required>
            </div>

            <div class="input-group">
                <label for="statut">Statut</label>
                <select name="statut" id="statut_mod" required>
                    <option value="" disabled selected>Choisir un statut</option>
                    <option value="redoublant">Redoublant</option>
                    <option value="passant">Passant</option>
                </select>
            </div>

            <div class="input-group">
                <label for="montant">Montant</label>
                <input type="text" id="montant_mod" name="montant" required>
            </div>

            <div class="bouton_ajouter">
                <button type="reset" class="btn_ann" onclick="annuler_modifier()">Annuler</button>
                <button type="submit" class="btn_aj">Ajouter</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
