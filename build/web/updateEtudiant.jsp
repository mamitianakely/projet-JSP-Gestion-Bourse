<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Modification pour étudiant</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<script>
    function backHome() {
        window.location.href = 'listEtudiant.jsp';
    }
</script>
<button class="btn btn-secondary m-3" onclick="backHome()">
    <i class="fa fa-arrow-left fa-lg"></i> Retour
</button>
<div class="container mt-5">
    <h2 class="mb-4">Modifier un étudiant</h2>
    <form action="saveEtudiant.jsp" method="post">
        <div class="form-group">
            <label for="matricule">Numéro matricule :</label>
            <input type="text" class="form-control" id="matricule" name="matricule" value="<%= request.getParameter("matricule")%>" required>
        </div>
        <div class="form-group">
            <label for="nom">Nom de l'Étudiant :</label>
            <input type="text" class="form-control" id="nom" name="nom" value="<%= request.getParameter("nom")%>" required>
        </div>
        <div class="form-group">
            <label for="sexe">Sexe :</label>
            <select class="form-control" id="sexe" name="sexe" required>
                <option value="Masculin" <%= "Masculin".equals(request.getParameter("sexe")) ? "selected" : "" %>>Masculin</option>
                <option value="Feminin" <%= "Feminin".equals(request.getParameter("sexe")) ? "selected" : "" %>>Feminin</option>
            </select>
        </div>
        <div class="form-group">
            <label for="datenais">Date de naissance :</label>
            <input type="date" class="form-control" id="datenais" name="datenais" value="<%= request.getParameter("datenais")%>" required>
        </div>
        <div class="form-group">
            <label for="institution">Nom de l'Institution :</label>
            <input type="text" class="form-control" id="institution" name="institution" value="<%= request.getParameter("institution")%>" required>
        </div>
        <div class="form-group">
            <label for="niveau">Niveau :</label>
            <select class="form-control" id="niveau" name="niveau" required>
                <option value="L1" <%= "L1".equals(request.getParameter("niveau")) ? "selected" : "" %>>L1</option>
                <option value="L2" <%= "L2".equals(request.getParameter("niveau")) ? "selected" : "" %>>L2</option>
                <option value="L3" <%= "L3".equals(request.getParameter("niveau")) ? "selected" : "" %>>L3</option>
                <option value="M1" <%= "M1".equals(request.getParameter("niveau")) ? "selected" : "" %>>M1</option>
                <option value="M2" <%= "M2".equals(request.getParameter("niveau")) ? "selected" : "" %>>M2</option>
            </select>
        </div>
        <div class="form-group">
            <label for="mail">Mail de l'étudiant :</label>
            <input type="email" class="form-control" id="mail" name="mail" value="<%= request.getParameter("mail")%>" required>
        </div>
        <div class="form-group">
            <label for="anneeUniv">Année universitaire :</label>
            <input type="text" class="form-control" id="anneeUniv" name="anneeUniv" value="<%= request.getParameter("anneeUniv")%>" required>
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
