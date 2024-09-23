<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Liste des retardataires</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
</head>
<body>
   <button class="btn btn-primary m-3" onclick="window.location.href = 'listEtudiant.jsp'">
        <i class="fa fa-arrow-left fa-lg"></i> retour
    </button>
<div class="container mt-5">
    <h2>Liste des retardataires pour un mois donné</h2>

    <!-- Formulaire de recherche par mois -->
    <form class="form-inline mb-3">
        <label for="mois" class="mr-2">Sélectionner un mois :</label>
        <input type="month" class="form-control mr-3" id="mois">
        <button type="button" class="btn btn-primary" onclick="searchRetardataires()">Rechercher</button>
    </form>

    <!-- Tableau des retardataires -->
    <table class="table table-striped">
        <thead class="thead-dark">
        <tr>
            <th scope="col">Matricule</th>
            <th scope="col">Nom</th>
            <th scope="col">Date de naissance</th>
            <th scope="col">Institution</th>
            <th scope="col">Niveau</th>
            <th scope="col">Mail</th>
            <th scope="col">Année Universitaire</th>
            <th scope="col">Mois payé</th>
        </tr>
        </thead>
        <tbody id="retardatairesTable">
            <!-- Ici seront affichés les retardataires -->
        </tbody>
    </table>
</div>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    function searchRetardataires() {
        const mois = document.getElementById('mois').value;
        fetch('searchRetardataires.jsp?mois=' + encodeURIComponent(mois))
            .then(response => response.text())
            .then(data => {
                document.getElementById('retardatairesTable').innerHTML = data;
            })
            .catch(error => {
                console.error("Error:", error);
            });
    }
</script>

</body>
</html>
