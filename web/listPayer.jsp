<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Liste des paiements</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
</head>
<body>
<script>
    function goToUpdate(idpaye, matricule, anneeUniv, date, nombreMois) {
        // Redirect to updatePayement.jsp
        window.location.href = "updatePayement.jsp?idpaye=" + encodeURIComponent(idpaye) +
            "&matricule=" + encodeURIComponent(matricule) +
            "&anneeUniv=" + encodeURIComponent(anneeUniv) +
            "&date=" + encodeURIComponent(date) +
            "&nombreMois=" + encodeURIComponent(nombreMois);
    }

    function deletePayer(idpaye) {
        if (confirm("Voulez-vous vraiment supprimer ce paiement?")) {
            fetch("deletePayer.jsp?idpaye=" + encodeURIComponent(idpaye))
                .then(response => response.text())
                .then(data => {
                    if (data.trim() === "Success") {
                        alert("Paiement supprimé avec succès");
                        window.location.reload(); // Recharger la page après la suppression
                    } else {
                        alert("Échec de la suppression du paiement");
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
   
    <h2 class="mb-4">LISTE DES PAIEMENTS</h2>
     <a href="insertPayer.jsp" class="btn btn-success mb-3">
        <i class="fa fa-plus-square fa-lg"></i> Ajouter
    </a>
    <table class="table table-striped">
        <thead class="thead-dark">
        <tr>
            <th scope="col">Identifiant</th>
            <th scope="col">Matricule</th>
            <th scope="col">Année Universitaire</th>
            <th scope="col">Date</th>
            <th scope="col">Nombre de Mois</th>
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
                String query = "SELECT * FROM payer";

                // Exécuter la requête
                rs = stmt.executeQuery(query);

                // Parcourir le résultat et peupler le tableau
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("idpaye") %></td>
            <td><%= rs.getString("matricule") %></td>
            <td><%= rs.getString("anneeUniv") %></td>
            <td><%= rs.getString("date") %></td>
            <td><%= rs.getInt("nombreMois") %></td>
            <td>
                <button class="btn btn-primary btn-sm" onclick="goToUpdate('<%= rs.getString("idpaye") %>',
                        '<%= rs.getString("matricule") %>', '<%= rs.getString("anneeUniv") %>', '<%= rs.getString("date") %>',
                        '<%= rs.getString("nombreMois") %>')">
                    <i class="fas fa-edit"></i> Modifier
                </button>
                <button class="btn btn-danger btn-sm" onclick="deletePayer('<%= rs.getString("idpaye") %>')">
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
