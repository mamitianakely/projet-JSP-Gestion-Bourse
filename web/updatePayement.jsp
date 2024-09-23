<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Modification pour paiement</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<script>
    function backHome() {
        window.location.href = 'listMontant.jsp';
    }
</script>
<button class="btn btn-secondary m-3" onclick="backHome()">
    <i class="fa fa-arrow-left fa-lg"></i> Retour
</button>
<div class="container mt-5">
    <h2 class="mb-4">Modifier un paiement</h2>
    <form action="savePayement.jsp" method="post">
        <div class="form-group">
            <label for="idpaye">Identifiant du paiement :</label>
            <input type="text" class="form-control" id="idpaye" name="idpaye" value="<%= request.getParameter("idpaye")%>" readonly>
        </div>
        <div class="form-group">
            <label for="matricule">Numéro Matricule :</label>
            <input type="text" class="form-control" id="matricule" name="matricule" value="<%= request.getParameter("matricule")%>" readonly>
        </div>
        <div class="form-group">
            <label for="anneeUniv">Année Universitaire :</label>
            <input type="text" class="form-control" id="anneeUniv" name="anneeUniv" value="<%= request.getParameter("anneeUniv")%>" readonly>
        </div>
        <div class="form-group">
            <label for="date">Date de paiement :</label>
            <input type="datetime-local" class="form-control" id="date" name="date" value="<%= request.getParameter("date")%>" required>
        </div>
        <div class="form-group">
            <label for="nombreMois">Nombre de mois :</label>
            <input type="number" class="form-control" id="nombreMois" name="nombreMois" value="<%= request.getParameter("nombreMois")%>" required>
        </div>
        <button type="submit" class="btn btn-primary">Enregistrer</button>
        <a href="listEtudiant.jsp" class="btn btn-danger">Annuler</a>
    </form>
</div>
<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
