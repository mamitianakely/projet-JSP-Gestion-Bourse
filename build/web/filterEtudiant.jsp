<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Récupérer les paramètres de requête
    String niveau = request.getParameter("niveau");
    String etablissement = request.getParameter("etablissement");

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
        if (niveau != null && !niveau.isEmpty()) {
            query += " AND niveau = ?";
        }

        if (etablissement != null && !etablissement.isEmpty()) {
            query += " AND institution = ?";
        }

        // Préparer la requête
        PreparedStatement pstmt = con.prepareStatement(query);

        // Affecter les paramètres de la requête préparée
        int paramIndex = 1;
        if (niveau != null && !niveau.isEmpty()) {
            pstmt.setString(paramIndex++, niveau);
        }
        if (etablissement != null && !etablissement.isEmpty()) {
            pstmt.setString(paramIndex++, etablissement);
        }

        // Exécuter la requête préparée
        rs = pstmt.executeQuery();

        // Générer le HTML pour la table des étudiants
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
