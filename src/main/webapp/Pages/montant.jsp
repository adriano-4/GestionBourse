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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/crud3.css">

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const ajouterBtn = document.querySelector('.ajouter');
            const ajouterDivFlou = document.getElementById('ajouter_div_flou');
            const modifDivFlou = document.getElementById('modifier_div_flou');
            const supDivFlou = document.getElementById('sup_div_flou');

            if (ajouterBtn && ajouterDivFlou) {
                ajouterBtn.addEventListener('click', function () {
                    ajouterDivFlou.style.display = 'flex';
                });
            }

            document.querySelectorAll('.btn_ann').forEach(btn => {
                btn.addEventListener('click', function () {
                    const parentPopup = btn.closest('.popup, #ajouter_div_flou, #modifier_div_flou, #sup_div_flou');
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

                document.querySelectorAll('tbody tr').forEach(r => {
                    r.style.cursor = '';
                    r.classList.remove('row-selectable');
                    r.removeEventListener('click', handleRowClick);
                });

                hideInfoBox();

                const cells = row.querySelectorAll('td');
                const idniv = cells[0].textContent.trim();
                const niveau = cells[1].textContent.trim();
                const statut = cells[2].textContent.trim();
                const montant = cells[3].textContent.trim().replace(" Ar", "");

                if (currentAction === "edit") {
                    document.getElementById('idniv_mod').value = idniv;
                    document.getElementById('niveau_mod').value = niveau;
                    document.getElementById('statut_mod').value = statut;
                    document.getElementById('montant_mod').value = montant;

                    const form = modifDivFlou.querySelector('form');
                    form.action = `/projetJSP_war_exploded/montants?action=modifier&idniv=${idniv}`;

                    modifDivFlou.style.display = 'flex';
                } else if (currentAction === "delete") {
                    const ouiSupBtn = document.getElementById('oui_sup');
                    const nonSupBtn = document.getElementById('non_sup');

                    ouiSupBtn.onclick = () => {
                        window.location.href = `/projetJSP_war_exploded/montants?action=supprimer&idniv=${idniv}`;
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
        <button class="btn-edit-- btn-edit" id="btn_ed">
            <i class="fas fa-edit"></i>
        </button>
        <button class="btn-delete-- btn-delete" id="btn_del">
            <i class="fas fa-trash-alt"></i>
        </button>
        <button class="ajouter">
            <i class="fa fa-plus"></i>
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
            <th>ID Niveau</th>
            <th>Niveau</th>
            <th>Statut</th>
            <th>Montant</th>
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
            <button id="oui_sup">OUI</button>
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
                <button type="reset" class="btn_ann">Annuler</button>
                <button type="submit" class="btn_aj">Ajouter</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
