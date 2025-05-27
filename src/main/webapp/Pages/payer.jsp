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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/etudiant2.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/crud.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/crud2.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/crud3.css">
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const ajouterBtn = document.querySelector('.ajouter');
            const ajouterDivFlou = document.getElementById('ajouter_div_flou');
            const modifDivFlou = document.getElementById('modifier_div_flou');
            const supDivFlou = document.getElementById('sup_div_flou');

            // Ouvrir le popup "Ajouter"
            if (ajouterBtn && ajouterDivFlou) {
                ajouterBtn.addEventListener('click', function () {
                    ajouterDivFlou.style.display = 'flex';
                });
            }

            // Fermer tous les popups
            document.querySelectorAll('.btn_ann').forEach(btn => {
                btn.addEventListener('click', function () {
                    const parentPopup = btn.closest('.popup, #ajouter_div_flou, #modifier_div_flou, #sup_div_flou');
                    if (parentPopup) {
                        parentPopup.style.display = 'none';
                    }
                });
            });

            // Remplissage automatique de l'année universitaire
            function getAnneeUniversitaire() {
                const now = new Date();
                const currentYear = now.getFullYear();
                const nextYear = currentYear + 1;

                if (now.getMonth() >= 8) {
                    return `${currentYear}-${nextYear}`;
                } else {
                    return `${currentYear - 1}-${currentYear}`;
                }
            }

            const anneeInput = document.getElementById('annee');
            if (anneeInput) {
                anneeInput.value = getAnneeUniversitaire();
            }

            // Partie SELECTION D'UNE LIGNE (comme étudiant)
            let currentAction = null;
            const infoBox = document.getElementById('info-selection');
            const actionTypeText = document.getElementById('action-type');

            const editTrigger = document.querySelector('.btn-edit--');
            const deleteTrigger = document.querySelector('.btn-delete--');

            editTrigger.addEventListener('click', () => {
                currentAction = "edit";
                actionTypeText.textContent = "modifier";
                showInfoBox();
                highlightRowsForSelection();
            });

            deleteTrigger.addEventListener('click', () => {
                currentAction = "delete";
                actionTypeText.textContent = "supprimer";
                showInfoBox();
                highlightRowsForSelection();
            });

            function showInfoBox() {
                infoBox.style.display = 'flex';
            }

            function hideInfoBox() {
                infoBox.style.display = 'none';
            }

            function highlightRowsForSelection() {
                document.querySelectorAll('tbody tr').forEach(row => {
                    row.style.cursor = 'pointer';
                    row.classList.add('row-selectable');
                    row.addEventListener('click', handleRowClick);
                });
            }

            function handleRowClick(e) {
                const row = e.currentTarget;

                document.querySelectorAll('tbody tr').forEach(r => {
                    r.style.cursor = '';
                    r.classList.remove('row-selectable');
                    r.removeEventListener('click', handleRowClick);
                });

                hideInfoBox();

                const cells = row.querySelectorAll('td');
                const matricule = cells[0].textContent.trim();
                const name = cells[1].textContent.trim();
                const niveau = cells[2].textContent.trim();
                const anneeUniv = cells[3].textContent.trim();
                const date = cells[4].textContent.trim(); // non utilisé ici
                const nbMois = cells[5].textContent.trim();
                const equipement = cells[6].textContent.trim();

                // NOTE : tu peux ajouter l'id de la ligne dans un <td hidden> si tu en as besoin

                if (currentAction === "edit") {
                    document.getElementById('matricule_mod').value = matricule;
                    document.getElementById('annee_mod').value = anneeUniv;
                    document.getElementById('nb_mois_mod').value = nbMois;
                    document.getElementById('equipement_mod').value = (equipement === "avec") ? "1" : "";

                    const form = modifDivFlou.querySelector('form');
                    form.action = `/projetJSP_war_exploded/payements?action=modifier&matricule=${matricule}`;

                    modifDivFlou.style.display = 'flex';

                } else if (currentAction === "delete") {
                    const ouiSupBtn = document.getElementById('oui_sup');
                    const nonSupBtn = document.getElementById('non_sup');

                    ouiSupBtn.onclick = () => {
                        window.location.href = `/projetJSP_war_exploded/payements?action=supprimer&matricule=${matricule}`;
                    };

                    nonSupBtn.onclick = () => {
                        supDivFlou.style.display = 'none';
                    };

                    supDivFlou.style.display = 'flex';
                }

                currentAction = null;
            }
        });
    </script>

</head>
<body>
<header>
    <div class="gauche">
        <img onclick="window.location.href='${pageContext.request.contextPath}/dashboard.jsp'" src="${pageContext.request.contextPath}/image/logo_bourse.png" alt="Logo" width="180">
    </div>
    <p class="titre">Listes des Payements</p>
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
        <button class="btn-edit-- btn-edit" id="btn_ed">
            <i class="fas fa-edit"></i>
        </button>
        <button class="btn-delete-- btn-delete" id="btn_del">
            <i class="fas fa-trash-alt"></i>
        </button>
        <button class="ajouter">
            <i class="fa fa-plus"></i>
        </button>
        <input type="text" placeholder="Rechercher un étudiant..." class="search-input">
        <button class="search-btn" id="search-btn">
            <i class="fas fa-search"></i>
        </button>
    </div>

    <div class="search-container2" >

    </div>

</div>
<div id="info-selection" class="info-message" style="display: none;">
    <i class="fa fa-info-circle"></i>
    <p>Veuillez sélectionner une ligne à <span id="action-type">modifier</span>.</p>
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
        </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty payments}">
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
                <label for="institution">ID paye</label>
                <input type="number" id="institution" name="idpaye">
            </div>

        <div class="input-group">
            <label for="matricule">Matricule</label>
            <input type="text" id="matricule" name="matricule" required>
        </div>

        <div class="input-group">
            <label for="annee">Année universitaire</label>
            <input type="text" id="annee" name="anne_univ" required>
        </div>

        <div class="input-group">
            <label for="nb_mois">Nombre de mois</label>
            <input type="number" id="nb_mois" name="nbr_mois" required>
        </div>

        <div class="input-group">
            <label for="equipement">Equipements</label>
            <select name="idequipement" id="equipement" required>
                <option value="" disabled selected>Choisir un statut</option>
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
<div id="modifier_div_flou">
    <div class="modifier_div">
        <h2>Modification du payement</h2>
        <form action="/projetJSP_war_exploded/payements?action=ajouter" method="post">
            <div class="input-group">
                <label for="institution">ID paye</label>
                <input type="number" id="institution_mod" name="idpaye">
            </div>

            <div class="input-group">
                <label for="matricule">Matricule</label>
                <input type="text" id="matricule_mod" name="matricule" required>
            </div>

            <div class="input-group">
                <label for="annee">Année universitaire</label>
                <input type="text" id="annee_mod" name="anne_univ" required>
            </div>

            <div class="input-group">
                <label for="nb_mois">Nombre de mois</label>
                <input type="number" id="nb_mois_mod" name="nbr_mois" required>
            </div>

            <div class="input-group">
                <label for="equipement">Equipements</label>
                <select name="idequipement" id="equipement_mod" required>
                    <option value="" disabled selected>Choisir un statut</option>
                    <option value="">sans</option>
                    <option value="1">avec</option>
                </select>
            </div>

            <div class="bouton_ajouter">
                <button type="reset" class="btn_ann">Annuler</button>
                <button type="submit" class="btn_aj">Confirmer</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
