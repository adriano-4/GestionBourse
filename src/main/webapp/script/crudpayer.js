document.addEventListener('DOMContentLoaded', function() {
    const ajouterBtn = document.querySelector('.ajouter');
    const annulerBtn = document.querySelector('.btn_ann');
    const ajouterDivFlou = document.getElementById('ajouter_div_flou');

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

    function getAnneeUniversitaire() {
        const now = new Date();
        const currentYear = now.getFullYear();
        const nextYear = currentYear + 1;

        if (now.getMonth() >= 8) {
            return `${currentYear}-${nextYear}`;
        } else {
            return `${currentYear-1}-${currentYear}`;
        }
    }
    const anneeInput = document.getElementById('annee');
    if (anneeInput) {
        anneeInput.value = getAnneeUniversitaire();
    }

});

function supprimer_payer() {
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
function modifier_payer() {
    const modifier_div_flou = document.getElementById('modifier_div_flou');
    if(modifier_div_flou) {
        modifier_div_flou.style.display = 'flex';
    }
}