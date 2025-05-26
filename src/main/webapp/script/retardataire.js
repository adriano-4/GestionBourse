document.addEventListener('DOMContentLoaded', function() {
    const monthFilter = document.getElementById('month-filter');

const monthNames = [
    "Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
    "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"
];

monthNames.forEach((month, index) => {
    const monthNumber = (index + 1).toString().padStart(2, '0'); // Format "01", "02", etc.
    const option = document.createElement('option');
    option.value = monthNumber;
    option.textContent = month;
    monthFilter.appendChild(option);
});

monthFilter.addEventListener('change', function() {
    const selectedMonth = this.value;
    console.log("Mois sélectionné :", selectedMonth);
    // Ici, vous pouvez ajouter votre logique de filtrage
});
});