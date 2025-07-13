<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>
<%
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE d MMMM yyyy")
            .withLocale(java.util.Locale.FRENCH);
    String dateAujourdhui = LocalDate.now().format(formatter);
%>
<script src="https://cdn.jsdelivr.net/npm/emoji-picker-element@^1/index.js" type="module"></script>
<html>
<head>
    <title>Envoi mail</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/etudiant.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/crud1.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/java.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            const $btnLink = $('.btn-link');
            const $lienContainer = $('#lien');
            const $nomInput = $('.nom_inp');
            const $lienInput = $('.lien_inp');
            const $appliquerBtn = $('#appliquerBtn');
            const $messageInput = $('.message-input');
            const $nouveau = $('#nouveau');

            $lienContainer.hide();

            $btnLink.click(function(e) {
                e.stopPropagation();
                $lienContainer.toggle();
                positionnerPopupLien(this);
            });

            function positionnerPopupLien(bouton) {
                const btnRect = bouton.getBoundingClientRect();
                $lienContainer.css({
                    'display': `flex`,
                });
            }

            $('#cacher').click(function (e){
                nettoyer();
                $nouveau.css({
                    'display': `none`,
                });
                $('#nouveau_mess_bouton').css({
                    'display': `flex`,
                });
                $('.historique').css({
                    'width': `100%`,
                    'transition': `all 0.4s`,
                });

            });

            function nettoyer(){
                $('.destinataire-input').val('');
                $('.objet-input').val('');
                $('.message-input').val('');
                const fileInput = document.getElementById('file-upload');
                fileInput.value = '';
                $('.fichier_div').empty();
                $('.destinataire-input').focus();
                document.querySelector('.total').style.display = "none";
            };

            $('#nouveau_mess_bouton').click(function (e){
                $nouveau.css({
                    'display': `block`,
                    'animation': `nouv 0.4s`,
                });
                $('#nouveau_mess_bouton').css({
                    'display': `none`,
                });
                $('.historique').css({
                   'width': `65%`,
                    'transition': `all 0.4s`,
                });
            });

            $appliquerBtn.click(function() {
                insererLien();
            });

            function insererLien() {
                const nom = $nomInput.val().trim();
                let url = $lienInput.val().trim();

                if (!nom || !url) return;

                if (!/^https?:\/\//i.test(url)) {
                    url = 'https://' + url;
                }

                const linkText = `<a href="${url}" target="_blank" style="color: #007bff; text-decoration: underline;">${nom}</a>`;

                const messageInput = $messageInput[0];
                const startPos = messageInput.selectionStart;

                messageInput.value = messageInput.value.substring(0, startPos) +
                    linkText +
                    messageInput.value.substring(messageInput.selectionEnd);

                messageInput.selectionStart = messageInput.selectionEnd = startPos + linkText.length;
                messageInput.focus();

                reinitialiserFormulaireLien();
            }

            function reinitialiserFormulaireLien() {
                $nomInput.val('');
                $lienInput.val('');
                $appliquerBtn.prop('disabled', true);
                $lienContainer.hide();
            }
            function validerChampsLien() {
                const nomValue = $nomInput.val();
                const lienValue = $lienInput.val();
                $appliquerBtn.prop('disabled', !(nomValue && nomValue.trim() && lienValue && lienValue.trim()));
            }
            $nomInput.on('input', validerChampsLien);
            $lienInput.on('input', validerChampsLien);

            $(document).click(function(e) {
                if (!$(e.target).closest('#lien').length && !$(e.target).closest('.btn-link').length) {
                    $lienContainer.hide();
                }
            });

            $lienContainer.click(function(e) {
                e.stopPropagation();
            });
            validerChampsLien();

            //code de emoji
            const picker = document.createElement('emoji-picker');
            picker.classList.add('emoji-picker');
            picker.style.position = 'absolute';
            picker.style.bottom = '100px';
            picker.style.right = '20px';
            picker.style.display = 'none';
            picker.style.zIndex = '1000';
            picker.setAttribute('class', 'light');
            picker.style.backgroundColor = 'white';
            picker.style.borderRadius = '10px';
            picker.style.boxShadow = '0 0 10px rgba(0,0,0,0.1)';
            document.body.appendChild(picker);

            $('.btn-emoji').click(function(e) {
                e.preventDefault();
                const isVisible = picker.style.display === 'block';
                picker.style.display = isVisible ? 'none' : 'block';

                const btnRect = this.getBoundingClientRect();
                picker.style.bottom = '80px';
                picker.style.right = '10px';
            });
            picker.addEventListener('emoji-click', event => {
                const emoji = event.detail.unicode;
                const messageInput = $('.message-input')[0];
                const startPos = messageInput.selectionStart;
                const endPos = messageInput.selectionEnd;
                messageInput.value = messageInput.value.substring(0, startPos) +
                    emoji +
                    messageInput.value.substring(endPos);
                messageInput.selectionStart = messageInput.selectionEnd = startPos + emoji.length;
                messageInput.focus();
                picker.style.display = 'none';
            });
            document.addEventListener('click', (e) => {
                if (!e.target.closest('.btn-emoji') && !e.target.closest('emoji-picker')) {
                    picker.style.display = 'none';
                }
            });

            $('#btn-sup').click(function () {
                nettoyer();
            });


            const confirmation_sup = document.getElementById("confirmation_sup");
            $(document).on('click', '.bt_sup', function() {
                const deleteBtn = $(this);
                const row = deleteBtn.closest('tr');
                const mailId = row.data('id');

                deleteBtn.html('<i class="fas fa-spinner fa-spin"></i>');
                deleteBtn.prop('disabled', true);

                fetch("${pageContext.request.contextPath}/javas", {
                    method: "DELETE",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({ id: mailId })
                })
                .then(response => {
                    if (!response.ok) throw new Error('Erreur réseau');
                    return response.json();
                })
                .then(data => {
                    if (data.success) {
                        row.fadeOut(300, () => {
                            row.remove();
                        });
                        confirmation_sup.style.display="flex";
                        setTimeout(function() {
                            confirmation_sup.style.display="none";
                        }, 3000);
                    } else {
                        throw new Error('Suppression échouée côté serveur');
                    }
                })
                .catch(error => {
                    console.error("Erreur:", error);
                    deleteBtn.html('<i class="fas fa-trash-alt"></i>');
                    deleteBtn.prop('disabled', false);

                });
            });
            $(document).on('click', '.bt_x', function() {
                confirmation_sup.style.display="none";
            });
        });
    </script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            document.getElementById("envoyer").addEventListener("click", function () {
                const destinataire = document.getElementById("destinataire").value;
                const objet = document.getElementById("objet").value;
                const message = document.getElementById("message").value;
                const fileInput = document.getElementById("file-upload");

                if (!destinataire || !objet || !message) {
                    document.getElementById("confirmation_envoi").style.display = "flex";
                    setTimeout(() => {
                        document.getElementById("confirmation_envoi").style.display = "none";
                    }, 3000);
                    return;
                }

                const formData = new FormData();
                formData.append("destinataire", destinataire);
                formData.append("objet", objet);
                formData.append("message", message);

                if (fileInput.files.length > 0) {
                    for (let i = 0; i < fileInput.files.length; i++) {
                        formData.append("fichiers", fileInput.files[i]);
                    }
                }

                const envoyerBtn = document.getElementById("envoyer");
                envoyerBtn.disabled = true;
                envoyerBtn.innerHTML = `Envoi... <i class="fas fa-spinner fa-spin"></i>`;

                console.log(destinataire);
                console.log(objet);
                console.log(message);
                console.log(fileInput.files);

                fetch("/projetJSP_war_exploded/javas", {
                    method: "POST",
                    body: formData
                })
                .then(response => {
                    if (response.ok) {
                        document.getElementById("mail_conf").style.display = "flex";
                        setTimeout(() => {
                            document.getElementById("mail_conf").style.display = "none";
                            location.reload();
                        }, 2000);
                    } else {
                        envoyerBtn.disabled = false;
                        envoyerBtn.innerHTML = `Envoyer <i class="fas fa-paper-plane"></i>`;
                    }
                })
                .catch(error => {
                    console.error("Erreur réseau :", error);
                    envoyerBtn.disabled = false;
                    envoyerBtn.innerHTML = `Envoyer <i class="fas fa-paper-plane"></i>`;
                });
            });
        });
    </script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const taille_total = document.getElementById("taille_total");

            document.getElementById('file-upload').addEventListener('change', function(e) {
                const fichiersDiv = document.querySelector('.fichier_div');
                fichiersDiv.innerHTML = '';
                let taille = 0;
                let pourc = 0;

                document.querySelector('.total').style.display = "flex";

                Array.from(this.files).forEach((file, index) => {
                    taille += file.size;
                    const fichierElement = document.createElement('div');
                    fichierElement.className = 'fichier-selectionne';

                    const fileInfoContainer = document.createElement('div');
                    fileInfoContainer.className = 'file-info-container';

                    const nomFichier = document.createElement('span');
                    nomFichier.className = 'nom-fichier';
                    nomFichier.textContent = file.name;

                    const tailleFichier = document.createElement('span');
                    tailleFichier.className = 'taille-fichier';
                    tailleFichier.textContent = formatFileSize(file.size);

                    const btnSupprimer = document.createElement('button');
                    btnSupprimer.className = 'btn-supprimer';
                    btnSupprimer.textContent = 'x';
                    btnSupprimer.dataset.index = index;
                    btnSupprimer.onclick = function() {
                        const newFiles = Array.from(this.files).filter((_, i) => i != index);
                        const dataTransfer = new DataTransfer();
                        newFiles.forEach(f => dataTransfer.items.add(f));
                        this.files = dataTransfer.files;
                        this.dispatchEvent(new Event('change'));
                        if (this.files.length > 0) {
                            document.querySelector('.total').style.display = "flex";
                        } else {
                            document.querySelector('.total').style.display = "none";
                        }
                    }.bind(this);

                    fileInfoContainer.appendChild(nomFichier);
                    fileInfoContainer.appendChild(tailleFichier);
                    fichierElement.appendChild(fileInfoContainer);
                    fichierElement.appendChild(btnSupprimer);
                    fichiersDiv.appendChild(fichierElement);
                });
                taille_total.innerHTML = formatFileSize(taille);
                pourc = pourcentage(taille);
                console.log(pourc);
                document.querySelector(".bar1").style.width = pourc + "%";
            });

            function pourcentage(pr){
                const r = pr/1024;
                return Math.min((r / 102400) * 100, 100);
            }

            function formatFileSize(bytes) {
                if (bytes === 0) return '0 Bytes';
                const k = 1024;
                const sizes = ['Bytes', 'KB', 'MB', 'GB'];
                const i = Math.floor(Math.log(bytes) / Math.log(k));
                return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
            }
        });
    </script>
</head>
<body>
<header>
    <div class="gauche">
    </div>
    <a href="#">
        <p class="titre">Envoyer mail</p>
    </a>
    <div class="droite">

    </div>
</header>
<div class="bas">
    <div class="historique">
        <h1><i class="fas fa-envelopes-bulk"> </i> Historique des mails envoyés :</h1>
        <table>
            <thead>
            <tr>
                <th>Expéditeur</th>
                <th>Destinataire</th>
                <th>PJ</th>
                <th>Message</th>
                <th>Date</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${javas}" var="h" varStatus="loop">
                <tr data-id="${h.id}">
                    <td>${h.expediteur}</td>
                    <td>${h.destinataire}</td>
                    <td></td>
                    <td><span id="td_objet">${h.objet} - </span><span id="td_mess">${h.message}</span></td>
                    <td>
                        <span class="date-text">
                            <fmt:formatDate value="${h.date}" pattern="yyyy-MM-dd HH:mm" />
                        </span>
                        <button class="bt_sup">
                            <i class="fas fa-trash-alt" style="cursor: pointer;"></i>
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="nouveau" id="nouveau">
        <div class="entete">
            <h1><i class="fas fa-pen"> </i> Nouveau messages :</h1>
            <p class="date"><%= dateAujourdhui %><span><button id="cacher">x</button></span></p>
        </div>

        <div class="message">
            <div class="mes destinataire">
                <input type="email" class="input destinataire-input" id="destinataire" placeholder="Destinataire">
            </div>
            <div class="mes objet">
                <input type="text" class="input objet-input" id="objet" placeholder="Objet">
            </div>
            <div class="mes message_ecrit">
                <textarea class="input message-input" id="message" placeholder="..."></textarea>
            </div>
            <div class="fichier_div">

            </div>
            <div class="total">
                <div class="bar">
                    <div class="bar1"></div>
                </div>
                <div class="texte_bar">
                    <p>Total :</p><span id="taille_total"></span><span>/100 Mo</span>
                </div>
            </div>
        </div>


        <div class="bas_nouveau">
            <button id="envoyer">Envoyer <i class="fas fa-paper-plane"></i></button>
            <button class="btn btn-file">
                <label for="file-upload" class="btn btn-file">
                    <i style="cursor: pointer" class="fas fa-cloud-upload-alt"></i>
                    <input id="file-upload" type="file" style="display:none;cursor: pointer" multiple>
                </label>
            </button>
            <button class="btn btn-link">
                <i class="fas fa-link"></i>
            </button>
            <button class="btn btn-emoji">
                <i class="far fa-smile"></i>
            </button>
            <button class="btn btn-sup" id="btn-sup">
                <i class="far fa-trash-alt"></i>
                <span>Effacer brouillon</span>
            </button>
        </div>
    </div>
    <div id="lien">
        <div class="input_lien">
            <input type="text" class="nom_inp" placeholder="Nom">
            <input type="text" class="lien_inp" placeholder="Valeur du lien">
        </div>
        <div class="lienbt">
            <button id="appliquerBtn">
                Appliquer
            </button>
        </div>
    </div>
    <div id="mail_conf">
        <div class="confirmation-message">
            <i class="fas fa-check-circle confirmation-icon"></i>
            <h2 class="h2_mail">Votre email a bien été envoyé !</h2>
            <p class="p_mail">Vous pouvez consulter cet email dans votre historique des messages envoyés.</p>
        </div>
    </div>
    <div id="confirmation_sup">
        <p>Conversation supprimée</p>
        <button class="bt_x">x</button>
    </div>
    <div id="confirmation_envoi">
        <p>Envoi impossible (Renseignez tous les champs)</p>
    </div>
</div>
<button id="nouveau_mess_bouton">
    <i class="fas fa-pen"> </i> Nouveau messages
</button>
</body>
</html>
