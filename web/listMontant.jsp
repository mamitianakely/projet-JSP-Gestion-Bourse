<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Liste des montants</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
</head>
<body>
<script>
    function goToUpdate(idNiv, niveau, montant) {
        // Redirect to updateMontant.jsp
        window.location.href = "updateMontant.jsp?idNiv=" + encodeURIComponent(idNiv) +
            "&niveau=" + encodeURIComponent(niveau) +
            "&montant=" + encodeURIComponent(montant);
    }

    function deleteMontant(idNiv) {
        if (confirm("Voulez-vous vraiment supprimer ce Montant?")) {
            fetch("deleteMontant.jsp?idNiv=" + encodeURIComponent(idNiv))
                .then(response => response.text())
                .then(data => {
                    if (data.trim() === "Success") {
                        alert("Montant supprimé avec succès");
                        window.location.reload(); // Recharger la page après la suppression
                    } else {
                        alert("Échec de la suppression du montant");
                    }
                })
                .catch(error => {
                    console.error("Erreur:", error);
                    alert("Erreur lors de la tentative de suppression");
                });
        }
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

<div class="container mt-5">
    
    <h2 class="mb-4">Liste des montants</h2>
    <a href="insertMontant.jsp" class="btn btn-success mb-3">
        <i class="fa fa-plus-square fa-lg"></i> Ajouter
    </a>
    <table class="table table-striped">
        <thead class="thead-dark">
        <tr>
            <th scope="col">Identifiant</th>
            <th scope="col">Niveau</th>
            <th scope="col">Montant</th>
            <th scope="col">Actions</th>
        </tr>
        </thead>
        <tbody>
        <% 
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                // Charger le driver JDBC MySQL
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Établir la connexion à la base de données
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bourse", "root", "");

                // Créer la requête SQL
                stmt = con.createStatement();
                String query = "SELECT * FROM montant";

                // Exécuter la requête
                rs = stmt.executeQuery(query);

                // Parcourir le résultat et peupler le tableau
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("idNiv") %></td>
            <td><%= rs.getString("niveau") %></td>
            <td><%= rs.getInt("montant") %></td>
            <td>
                <button class="btn btn-primary btn-sm" onclick="goToUpdate('<%= rs.getString("idNiv") %>',
                        '<%= rs.getString("niveau") %>', '<%= rs.getInt("montant") %>')">
                    <i class="fas fa-edit"></i> Modifier
                </button>
                <button class="btn btn-danger btn-sm" onclick="deleteMontant('<%= rs.getString("idNiv") %>')">
                    <i class="fas fa-trash"></i> Supprimer
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
