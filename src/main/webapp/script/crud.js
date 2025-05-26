document.addEventListener('DOMContentLoaded', function() {
    const ajouterBtn = document.querySelector('.ajouter');
    const annulerBtn = document.querySelector('.btn_ann');
    const ajouterDivFlou = document.getElementById('ajouter_div_flou');
    const supdivflou = document.getElementById('sup_div_flou');
    const nonsup = document.getElementById('non_sup');
    const btndelete = document.querySelector('.btn-delete');

    if(ajouterBtn && annulerBtn && ajouterDivFlou) {
        ajouterBtn.addEventListener('click', function() {
            ajouterDivFlou.style.display = 'block';
            console.log("Bouton Ajouter cliqué");
        });

        annulerBtn.addEventListener('click', function() {
            ajouterDivFlou.style.display = 'none';
            console.log("Bouton Annuler cliqué");
        });
    } else {
        console.error("Un ou plusieurs éléments n'ont pas été trouvés");
    }
});

function supprimer_etudiant() {
    const supdivflou = document.getElementById('sup_div_flou');
    if(supdivflou) {
        supdivflou.style.display = 'flex';
    }
}

function modifier_etudiant() {

}
