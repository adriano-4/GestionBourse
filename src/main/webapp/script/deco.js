document.addEventListener('DOMContentLoaded', function() {
const cont=document.getElementById('cont');
const non2=document.getElementById('non2');
const deco= document.getElementById('déco');
const oui2=document.getElementById('oui2');

    if(cont && non2 && deco && oui2) {
        deco.addEventListener('click', function() {
            cont.style.display = 'flex';
            console.log("Bouton Ajouter cliqué");
        });

        non2.addEventListener('click', function() {
            cont.style.display = 'none';
            console.log("Bouton Annuler cliqué");
        });
        oui2.addEventListener('click', function (){
            window.location.href='http://localhost:8080/projetJSP_war_exploded/';
        });
    } else {
        console.error("Un ou plusieurs éléments n'ont pas été trouvés");
    }
});