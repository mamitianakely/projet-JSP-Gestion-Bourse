<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>LISTE DES ETUDIANTS</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
</head>
<body>
<script>
    function goToUpdate(matricule, nom, sexe, datenais, institution, niveau, mail, anneeUniv) {
        // Redirect to updateEtudiant.jsp
        window.location.href = "updateEtudiant.jsp?matricule=" + encodeURIComponent(matricule) +
            "&nom=" + encodeURIComponent(nom) +
            "&sexe=" + encodeURIComponent(sexe) +
            "&datenais=" + encodeURIComponent(datenais) +
            "&institution=" + encodeURIComponent(institution) +
            "&niveau=" + encodeURIComponent(niveau) +
            "&mail=" + encodeURIComponent(mail) +
            "&anneeUniv=" + encodeURIComponent(anneeUniv);
    }

    function deleteEtudiant(matricule) {
    if (confirm("Voulez-vous vraiment supprimer cet étudiant?")) {
        fetch("deleteEtudiant.jsp?matricule=" + encodeURIComponent(matricule))
            .then(response => response.text())
            .then(data => {
                console.log("Response from server:", data.trim());// Log the response
                   
                if (data.trim() === "Success") {
                    alert("Étudiant supprimé avec succès.");
                    window.location.reload();
                } else {
                    alert("Échec de la suppression de l'étudiant.");
                    window.location.reload();
                }
            })
            .catch(error => {
                console.error("Error:", error);
                alert("Erreur de tentative de suppression.");
            });
    }
}

    function searchEtudiant() {
        const search = document.getElementById('search').value;
        fetch('searchEtudiant.jsp?search=' + encodeURIComponent(search))
            .then(response => response.text())
            .then(data => {
                document.getElementById('etudiantTable').innerHTML = data;
            })
            .catch(error => {
                console.error("Error:", error);
            });
    }

    function filterEtudiant() {
        const niveau = document.getElementById('niveau').value;
        const etablissement = document.getElementById('etablissement').value;

        fetch('filterEtudiant.jsp?niveau=' + encodeURIComponent(niveau) + '&etablissement=' + encodeURIComponent(etablissement))
            .then(response => response.text())
            .then(data => {
                document.getElementById('etudiantTable').innerHTML = data;
            })
            .catch(error => {
                console.error("Error:", error);
            });
    }
    
    function refreshEtudiantList() {
        fetch('refreshEtudiant.jsp')
            .then(response => response.text())
            .then(data => {
                document.getElementById('etudiantTable').innerHTML = data;
            })
            .catch(error => {
                console.error("Error:", error);
            });
    }
    
    function generatePDF(matricule) {
        window.open('generatePDF.jsp?matricule=' + encodeURIComponent(matricule), '_blank');
    }
    
    function filterMineurEtudiant() {
        fetch('filterMineurs.jsp')
            .then(response => response.text())
            .then(data => {
                document.getElementById('etudiantTable').innerHTML = data;
            })
            .catch(error => {
                console.error("Error:", error);
            });
    }
    
</script>

<script>
    function backHome(){
        window.location.href = "index.jsp"; // Changer vers l'URL correcte
    }
</script>

<button class="btn btn-primary m-3" onclick="backHome()">
    <i class="fa fa-arrow-left fa-lg"></i>
</button>

<div class="form-inline m-3">
    <label for="niveau" class="mr-2">Niveau:</label>
    <select class="form-control mr-3" id="niveau">
        <option value="">Tous</option>
        <option value="L1">L1</option>
        <option value="L2">L2</option>
        <option value="L3">L3</option>
        <option value="M1">M1</option>
        <option value="M2">M2</option>
    </select>

    <label for="etablissement" class="mr-2">Etablissement:</label>
    <select class="form-control" id="etablissement">
        <option value="">Tous</option>
        <option value="ENI">ENI</option>
        <option value="EMIT">EMIT</option>
        <option value="DEGS">DEGS</option>
    </select>

    <button class="btn btn-primary ml-3" onclick="filterEtudiant()">
        <i class="fa fa-filter"></i> Filtrer
    </button>
    
    <button class="btn btn-primary ml-3" onclick="filterMineurEtudiant()">
        <i class="fa fa-filter"></i> Filtrer Mineurs
    </button>
    
    <button class="btn btn-primary ml-3" onclick="window.location.href = 'retardataires.jsp'">
        <i class="fa fa-plus-square fa-lg"></i> Voir les retardataires
    </button>

    <button class="btn btn-info ml-3" onclick="refreshEtudiantList()">
        <i class="fas fa-sync"></i> Rafraîchir
    </button>
    
</div>

<div class="container mt-5">
    <h2 class="mb-4">LISTE DES ETUDIANTS</h2>
    <button class="btn btn-primary mb-3" onclick="window.location.href = 'insertEtudiant.jsp'">
        <i class="fa fa-plus-square fa-lg"></i> Ajouter
    </button>
    <!-- Formulaire de recherche -->
    <div class="form-group">
        <input type="text" class="form-control" id="search" placeholder="Rechercher..." onkeyup="searchEtudiant()">
    </div>

    <table class="table table-striped">
        <thead class="thead-dark">
        <tr>
            <th scope="col">Matricule</th>
            <th scope="col">Nom</th>
            <th scope="col">Sexe</th>
            <th scope="col">Date de naissance</th>
            <th scope="col">Institution</th>
            <th scope="col">Niveau</th>
            <th scope="col">Mail</th>
            <th scope="col">Année Universitaire</th>
            <th scope="col">Actions</th>
        </tr>
        </thead>
        <tbody id="etudiantTable">
        <% 
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                // Charger le driver JDBC MySQL
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Établir la connexion à la base de données
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bourse", "root", "");

                // Créer la requête SQL de base
                String query = "SELECT * FROM etudiant WHERE 1=1";
                
                // Ajouter les conditions de filtrage pour niveau et établissement
                String niveau = request.getParameter("niveau");
                if (niveau != null && !niveau.isEmpty()) {
                    query += " AND niveau = '" + niveau + "'";
                }
                
                String etablissement = request.getParameter("etablissement");
                if (etablissement != null && !etablissement.isEmpty()) {
                    query += " AND institution = '" + etablissement + "'";
                }

                // Exécuter la requête
                stmt = con.createStatement();
                rs = stmt.executeQuery(query);

                // Parcourir le résultat et peupler le tableau
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("matricule") %></td>
            <td><%= rs.getString("nom") %></td>
            <td><%= rs.getString("sexe") %></td>
            <td><%= rs.getString("datenais") %></td>
            <td><%= rs.getString("institution") %></td>
            <td><%= rs.getString("niveau") %></td>
            <td><%= rs.getString("mail") %></td>
            <td><%= rs.getString("anneeUniv") %></td>
            <td>
                <button class="btn btn-primary btn-sm" onclick="goToUpdate('<%= rs.getString("matricule") %>',
                        '<%= rs.getString("nom") %>', '<%= rs.getString("sexe") %>', '<%= rs.getString("datenais") %>',
                        '<%= rs.getString("institution") %>', '<%= rs.getString("niveau") %>', '<%= rs.getString("mail") %>',
                        '<%= rs.getString("anneeUniv") %>')">
                    <i class="fas fa-edit"></i> Modifier
                </button>
                <button class="btn btn-danger btn-sm" onclick="deleteEtudiant('<%= rs.getString("matricule") %>')">
                    <i class="fas fa-trash"></i> Supprimer
                </button>
                 <button class="btn btn-success btn-sm" onclick="generatePDF('<%= rs.getString("matricule") %>')">
                    <i class="fas fa-file-pdf"></i> Générer PDF
                </button>
            </td>
        </tr>
        <%
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            } finally {
                // Fermer les ressources dans un bloc finally pour assurer leur fermeture
                if (rs != null) {
                    try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
                if (stmt != null) {
                    try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
                if (con != null) {
                    try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
        %>
        </tbody>
    </table>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
