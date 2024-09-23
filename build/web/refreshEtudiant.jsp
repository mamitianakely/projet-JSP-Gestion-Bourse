<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
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
        String query = "SELECT * FROM etudiant";
        stmt = con.createStatement();

        // Exécuter la requête
        rs = stmt.executeQuery(query);

        // Générer le HTML pour le tableau des étudiants
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
