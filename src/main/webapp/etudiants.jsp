<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Étudiants</title>
</head>
<body>
<h1>Liste des Étudiants :</h1>
<br/>
<ul>
    <c:forEach var="etudiant" items="${etudiants}">
        <li>${etudiant.matricule}</li>
        <li>${etudiant.nom}</li>
        <li>${etudiant.sexe}</li>
        <li>${etudiant.datenais}</li>
        <li>${etudiant.institution}</li>
        <li>${etudiant.mail}</li>
        <li>${etudiant.idniv}</li>
    </c:forEach>
</ul>
</body>
</html>