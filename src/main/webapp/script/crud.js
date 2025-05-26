document.addEventListener('DOMContentLoaded', function() {
    const ajouterBtn = document.querySelector('.ajouter');
    const annulerBtn = document.querySelector('#ajouter_div_flou .btn_ann');
    const ajouterDivFlou = document.getElementById('ajouter_div_flou');
    const supdivflou = document.getElementById('sup_div_flou');
    const nonsup = document.getElementById('non_sup');
    const deleteButtons = document.querySelectorAll('.btn-delete');
    const editButtons = document.querySelectorAll('.btn-edit');
    const modifierDiv = document.getElementById('modifier_div_flou');
    const annulerModifBtn = document.querySelector('#modifier_div_flou .btn_ann');

    ajouterBtn.addEventListener('click', function() {
        ajouterDivFlou.style.display = 'flex';
    });

    annulerBtn.addEventListener('click', function() {
        ajouterDivFlou.style.display = 'none';
    });

    deleteButtons.forEach(button => {
        button.addEventListener('click', function() {
            supdivflou.style.display = 'flex';
        });
    });

    nonsup.addEventListener('click', function() {
        supdivflou.style.display = 'none';
    });

    document.querySelector('tbody').addEventListener('click', function(e) {
        if (e.target.closest('.btn-edit')) {
            const button = e.target.closest('.btn-edit');
            const row = button.closest('tr');

            const matricule = row.cells[0].textContent;
            const nomPrenom = row.cells[1].textContent;
            const sexe = row.cells[2].textContent;
            const dateNaissance = row.cells[3].textContent;
            const institution = row.cells[4].textContent;
            
            const mail = row.cells[5].textContent;
            const niveau = row.cells[6].textContent;

            const dateParts = dateNaissance.split('/');
            const formattedDate = dateParts.length === 3
                ? `${dateParts[2]}-${dateParts[1].padStart(2, '0')}-${dateParts[0].padStart(2, '0')}`
                : dateNaissance;

            document.getElementById('matricule_mod').value = matricule;
            document.getElementById('nom_prenom_mod').value = nomPrenom;
            document.getElementById('sexe_mod').value = sexe;
            document.getElementById('date_naissance_mod').value = formattedDate;
            document.getElementById('institution_mod').value = institution;
            document.getElementById('mail_mod').value = mail;
            document.getElementById('niveau_mod').value = niveau;

            // Affichage du modal
            document.getElementById('modifier_div_flou').style.display = 'flex';
        }
    });

    annulerModifBtn.addEventListener('click', function() {
        modifierDiv.style.display = 'none';
    });
});