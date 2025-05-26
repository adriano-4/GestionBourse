document.addEventListener('DOMContentLoaded', function() {
    const ajouterBtn = document.querySelector('.ajouter');
    const annulerBtn = document.querySelector('.btn_ann');
    const ajouterDivFlou = document.getElementById('ajouter_div_flou');

    if(ajouterBtn && annulerBtn && ajouterDivFlou) {
        ajouterBtn.addEventListener('click', function() {
            ajouterDivFlou.style.display = 'block';
            console.log("mangina teo la");

        });

        annulerBtn.addEventListener('click', function() {
            ajouterDivFlou.style.display = 'none';
            console.log("Bouton Annuler cliqué");
        });
    } else {
        console.error("Un ou plusieurs éléments n'ont pas été trouvés");
    }

});
function supprimer_montant() {
    const supdivflou = document.getElementById('sup_div_flou');
    if(supdivflou) {
        supdivflou.style.display = 'flex';
    }
}
function  annuler_supprimer(){
    const supdivflou = document.getElementById('sup_div_flou');
    if(supdivflou) {
        supdivflou.style.display = 'none';
    }
}
function  annuler_modifier(){
    const modifier_div_flou = document.getElementById('modifier_div_flou');
    if(modifier_div_flou) {
        modifier_div_flou.style.display = 'none';
    }
}
function modifier_montant() {
    const modifier_div_flou = document.getElementById('modifier_div_flou');
    if(modifier_div_flou) {
        modifier_div_flou.style.display = 'flex';
    }
}