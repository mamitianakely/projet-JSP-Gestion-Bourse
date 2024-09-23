<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String mois = request.getParameter("mois");
    
    Connection con = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Charger le driver JDBC MySQL
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Établir la connexion à la base de données
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bourse", "root", "");

        // Requête SQL pour récupérer les retardataires pour le mois donné
        String query = "SELECT e.matricule, e.nom, e.datenais, e.institution, e.niveau, e.mail, e.anneeUniv, p.nombreMois " +
                       "FROM etudiant e " +
                       "JOIN payer p ON e.matricule = p.matricule " +
                       "WHERE DATE_FORMAT(p.date, '%Y-%m') = ? " +  // Comparaison avec le mois sélectionné
                       "AND p.nombreMois = 0"; // Condition pour déterminer les retardataires (0 mois payés)

        // Préparer la déclaration SQL
        stmt = con.prepareStatement(query);
        stmt.setString(1, mois);

        // Exécuter la requête
        rs = stmt.executeQuery();

        // Afficher les résultats sous forme de lignes de tableau
        while (rs.next()) {
%>
        <tr>
            <td><%= rs.getString("matricule") %></td>
            <td><%= rs.getString("nom") %></td>
            <td><%= rs.getString("datenais") %></td>
            <td><%= rs.getString("institution") %></td>
            <td><%= rs.getString("niveau") %></td>
            <td><%= rs.getString("mail") %></td>
            <td><%= rs.getString("anneeUniv") %></td>
            <td><%= rs.getInt("nombreMois") %></td>
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
