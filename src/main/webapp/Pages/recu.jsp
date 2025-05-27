<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 18/05/2025
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>recu</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/etudiant.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.4.2/css/all.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/recu.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
      document.querySelector('.exporter').addEventListener('click', function () {
        const pdfRecu = document.querySelector('.pdf_recu');
        html2canvas(pdfRecu).then(canvas => {
          const imgData = canvas.toDataURL('image/png');

          const {jsPDF} = window.jspdf;
          const pdf = new jsPDF({
            orientation: 'landscape',
            unit: 'pt',
            format: 'a4'
          });

          const imgProps = pdf.getImageProperties(imgData);
          const pdfWidth = pdf.internal.pageSize.getWidth();
          const pdfHeight = (imgProps.height * pdfWidth) / imgProps.width;

          pdf.addImage(imgData, 'PNG', 0, 0, pdfWidth, pdfHeight);
          pdf.save('recu-paiement.pdf');

          window.location.href = '${pageContext.request.contextPath}/payements';
        });
      });
    });
  </script>

  <style>
    .pdf_recu{
      font-size: 14px;
    }
    .date_titre{
      width: 100%;
      justify-content: center;
      height: 80px;
      display: flex;
      align-items: center;
      font-weight: 600;

    }
    .info1{
      margin-left: 100px;
      display: flex;
      align-items: center;
      margin-top: 20px;

    }
    .info1 p{
      font-weight: 600;
    }
    .tableau_recu{
      width: 400px;
      margin-left: 100px;
      margin-top: 20px;
    }
    .tableau_recu table{
      width: 100%;
      border-collapse: collapse;
      font-size: 14px;
    }
    .tableau_recu table tr th,.tableau_recu table tr td{
      border: 1px solid rgba(0, 0, 0, 0.34);
      padding: 10px;
    }

  </style>
</head>
<body>
<header>
  <div class="gauche">
    <img src="${pageContext.request.contextPath}/image/logo_bourse.png" alt="Logo" width="180">
  </div>
  <p class="titre">Reçu de payement de bourse</p>
  <div class="droite">
    <p>Nom d'utilisateur :<span>Belou</span></p>
  </div>
</header>

<div class="pdf">
  <div class="exporter_div">
    <button class="exporter">Exporter<i class="fa fa-download"></i></button>
  </div>
  <div class="pdf_recu">
    <div class="date_titre">
      <p>Aujourd'hui le 25 Avril 2025</p>
    </div>
    <div class="info1">
      <p>Matricule : </p>
      <span>3011</span>
    </div>
    <div class="info1">
      <p>RANDRIANAMBININA Toky Adriano</p>
    </div>
    <div class="info1">
      <p>Né le 06 janvier 2007</p>
    </div>
    <div class="info1">
      <p>Institution : </p>
      <span>ENI</span>
      <p>/ Niveau : </p>
      <span>L2</span>
    </div>
    <div class="tableau_recu">
      <table>
        <thead>
        <tr>
          <th>Mois</th>
          <th>Montant</th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <td>Equipement</td>
          <td></td>
        </tr>
        <tr>
          <td>Janvier</td>
          <td></td>
        </tr>
        <tr>
          <td>Février</td>
          <td></td>
        </tr>
        <tr>
          <td>Mars</td>
          <td></td>
        </tr>
        <tr>
          <td>Total</td>
          <td></td>
        </tr>
        </tbody>
      </table>
    </div>
    <div class="info1">
      <p>Total Payé : </p>
      <span>179000</span><span> Ar</span>
    </div>
  </div>
</div>
</body>
</html>
