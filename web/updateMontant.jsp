<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Modifier un montant</title>
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
    <h2 class="mb-4">Modifier un montant</h2>
    <form action="saveMontant.jsp" method="post">
        <div class="form-group">
            <label for="idNiv">Identifiant du niveau :</label>
            <input type="text" class="form-control" id="idNiv" name="idNiv" value="<%= request.getParameter("idNiv")%>" readonly>
        </div>
        <div class="form-group">
            <label for="niveau">Niveau de l'Étudiant :</label>
            <select class="form-control" id="niveau" name="niveau" required>
                <option value="L1" <%= "L1".equals(request.getParameter("niveau")) ? "selected" : "" %>>L1</option>
                <option value="L2" <%= "L2".equals(request.getParameter("niveau")) ? "selected" : "" %>>L2</option>
                <option value="L3" <%= "L3".equals(request.getParameter("niveau")) ? "selected" : "" %>>L3</option>
                <option value="M1" <%= "M1".equals(request.getParameter("niveau")) ? "selected" : "" %>>M1</option>
                <option value="M2" <%= "M2".equals(request.getParameter("niveau")) ? "selected" : "" %>>M2</option>
            </select>
        </div>
        <div class="form-group">
            <label for="montant">Montant :</label>
            <input type="number" class="form-control" id="montant" name="montant" value="<%= request.getParameter("montant")%>" required>
        </div>
        <button type="submit" class="btn btn-primary">Enregistrer</button>
        <a href="listMontant.jsp" class="btn btn-danger">Annuler</a>
    </form>
</div>
<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
