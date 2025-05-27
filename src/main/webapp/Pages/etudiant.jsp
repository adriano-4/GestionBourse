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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/etudiant2.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/crud.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/crud2.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/crud3.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.4.2/css/all.min.css">

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            console.log("DOM complètement chargé");

            const ajouterBtn = document.querySelector('.ajouter');
            const ajouterDivFlou = document.getElementById('ajouter_div_flou');

            if (ajouterBtn && ajouterDivFlou) {
                ajouterBtn.addEventListener('click', function () {
                    ajouterDivFlou.style.display = 'block';
                });
            }
            document.querySelectorAll('.btn_ann').forEach(btn => {
                btn.addEventListener('click', function () {
                    const parentPopup = btn.closest('.popup, #ajouter_div_flou ,#modifier_div_flou');
                    if (parentPopup) {
                        parentPopup.style.display = 'none';
                    }
                });
            });


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

                // Enlève le style et les listeners
                document.querySelectorAll('tbody tr').forEach(r => {
                    r.style.cursor = '';
                    r.classList.remove('row-selectable');
                    r.removeEventListener('click', handleRowClick);
                });

                hideInfoBox(); // 👉 cacher le message

                const cells = row.querySelectorAll('td');
                const matricule = cells[0].textContent;

                if (currentAction === "edit") {
                    document.getElementById('matricule_mod').value = cells[0].textContent;
                    document.getElementById('nom_prenom_mod').value = cells[1].textContent;
                    document.getElementById('sexe_mod').value = cells[2].textContent;
                    document.getElementById('date_naissance_mod').value = formatDateForInput(cells[3].textContent);
                    document.getElementById('institution_mod').value = cells[4].textContent;
                    document.getElementById('mail_mod').value = cells[5].textContent;
                    document.getElementById('niveau_mod').value = cells[6].textContent;

                    const modifierDivFlou = document.getElementById('modifier_div_flou');
                    const form = modifierDivFlou.querySelector('form');
                    form.action = `/projetJSP_war_exploded/etudiants?action=modifier&matricule=${matricule}`;
                    modifierDivFlou.style.display = 'flex';

                } else if (currentAction === "delete") {
                    const supDivFlou = document.getElementById('sup_div_flou');
                    const ouiSupBtn = document.getElementById('oui_sup');
                    const nonSupBtn = document.getElementById('non_sup');

                    ouiSupBtn.onclick = () => {
                        window.location.href = `/projetJSP_war_exploded/etudiants?action=supprimer&matricule=${matricule}`;
                    };

                    nonSupBtn.onclick = () => {
                        supDivFlou.style.display = 'none';
                    };

                    supDivFlou.style.display = 'flex';
                }

                currentAction = null;
            }

            function formatDateForInput(dateString) {
                if (!dateString) return '';
                const parts = dateString.split('-');
                return `${parts[0]}-${parts[1]}-${parts[2]}`;
            }
        });


    </script>
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
        <button class="btn-edit-- btn-edit" id="btn_ed">
            <i class="fas fa-edit"></i>
        </button>
        <button class="btn-delete-- btn-delete" id="btn_del">
            <i class="fas fa-trash-alt"></i>
        </button>
        <button class="ajouter">
            <i class="fa fa-plus"></i>
        </button>
        <form action="" method="post">
            <input type="text" placeholder="Rechercher un étudiant..." class="search-input">
            <button class="search-btn" id="search-btn">
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
            <th>Sexe</th>
            <th>Date de Naissance</th>
            <th>Institution</th>
            <th>Mail</th>
            <th>Niveau</th>
        </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty etudiants}">
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
                    <c:forEach var="etudiant" items="${etudiants}" varStatus="loop">
                        <tr id="etudiant-${loop.index}">
                            <td>${etudiant.matricule}</td>
                            <td>${etudiant.nom}</td>
                            <td>${etudiant.sexe}</td>
                            <td>${etudiant.datenais}</td>
                            <td>${etudiant.institution}</td>
                            <td>${etudiant.mail}</td>
                            <td>${etudiant.idniv}</td>
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
                <label for="nom_prenom">Nom et Prénom</label>
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
<div id="modifier_div_flou">
    <div class="modifier_div">
        <h2>Modification d'étudiant</h2>
        <form  method="post">
            <div class="input-group">
                <label for="matricule">Matricule</label>
                <input type="text" id="matricule_mod" name="matricule" required>
            </div>

            <div class="input-group">
                <label for="nom_prenom">Nom et Prénom</label>
                <input type="text" id="nom_prenom_mod" name="nom" required>
            </div>

            <div class="input-group">
                <label for="sexe">Sexe</label>
                <select id="sexe_mod" name="sexe" required>
                    <option value="">Sélectionner</option>
                    <option value="Masculin">Masculin</option>
                    <option value="Feminin">Féminin</option>
                </select>
            </div>

            <div class="input-group">
                <label for="date_naissance">Date de Naissance</label>
                <input type="date" id="date_naissance_mod" name="datenais" required>
            </div>

            <div class="input-group">
                <label for="institution">Institution</label>
                <select id="institution_mod" name="institution" required>
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
                <input type="email" id="mail_mod" name="mail" required>
            </div>

            <div class="input-group">
                <label for="niveau">Niveau</label>
                <select id="niveau_mod" name="idniv" required>
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
                <button type="submit" class="btn_aj">Confirmer</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
