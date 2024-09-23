<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Étudiants et Paiements</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .card-container {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
        }
        .card {
            margin: 20px;
            flex: 1 1 18rem;
            max-width: 20rem;
        }
        .card-body {
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .btn-block {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Gestion des Étudiants et Paiements</h1>
        <div class="card-container">
            <div class="card">
                <div class="card-body text-center">
                    <a href="insertEtudiant.jsp" class="btn btn-primary btn-block">Ajouter étudiant</a>
                    <a href="listEtudiant.jsp" class="btn btn-secondary btn-block">Liste des étudiants</a>
                </div>
            </div>
            <div class="card">
                <div class="card-body text-center">
                    <a href="insertMontant.jsp" class="btn btn-primary btn-block">Ajouter des montants</a>
                    <a href="listMontant.jsp" class="btn btn-secondary btn-block">Liste des montants</a>
                </div>
            </div>
            <div class="card">
                <div class="card-body text-center">
                    <a href="insertPayer.jsp" class="btn btn-primary btn-block">Ajouter des paiements</a>
                    <a href="listPayer.jsp" class="btn btn-secondary btn-block">Liste des paiements</a>
                </div>
            </div>
        </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
