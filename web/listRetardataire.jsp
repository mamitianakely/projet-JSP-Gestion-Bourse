<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: MAMY
  Date: 25/06/2024
  Time: 23:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Retardataires</title>
</head>
<body>
<h1>Liste des retardataires</h1>
    <%
        String mois = request.getParameter("mois");
        String annee = request.getParameter("annee");

        List<Map<String, String>> retardataires = null;
        if (mois == null || annee == null) {
            System.out.println("Veuillez fournir les paramètres 'mois' et 'annee'.");
        } else {
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;
            retardataires = new ArrayList<>();
            try {
                // load the mysql jdbc driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish the database connection
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bourse", "root", "");

                // Requête SQL pour récupérer les étudiants retardataires
                String sql = "SELECT e.matricule, e.nom, e.mail, e.niveau, e.niveau " +
                        "FROM etudiant e LEFT JOIN payer p ON e.matricule = p.matricule AND MONTH(p.date) = ? AND YEAR(p.date) = ? " +
                        "WHERE p.matricule IS NULL";
                stmt = con.prepareStatement(sql);
                ((PreparedStatement) stmt).setInt(1, Integer.parseInt(mois));
                ((PreparedStatement) stmt).setInt(2, Integer.parseInt(annee));
                rs = stmt.executeQuery(sql);

                //trater les resultats
                while (rs.next()) {
                    Map<String, String> etudiant = new HashMap<>();
                    etudiant.put("matricule", rs.getString("matricule"));
                    etudiant.put("nom", rs.getString("nom"));
                    etudiant.put("mail", rs.getString("mail"));
                    etudiant.put("niveau", rs.getString("niveau"));
                    etudiant.put("institution", rs.getString("institution"));
                    retardataires.add(etudiant);
                }
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("Erreur lors de la récupération de données:" + e.getMessage());
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        if (retardataires.isEmpty()) {
            System.out.println("Aucun retardataire trouvé pour le mois" + mois + "/" + annee + ".");
        } else {
    %>
            <table border="1">
                <thead>
                <tr>
                    <th>Matricule</th>
                    <th>Nom</th>
                    <th>Email</th>
                    <th>Niveau</th>
                    <th>Institution</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (Map<String, String> etudiant : retardataires) {
                %>
                <tr>
                    <td><%= etudiant.get("matricule") %></td>
                    <td><%= etudiant.get("nom") %></td>
                    <td><%= etudiant.get("mail") %></td>
                    <td><%= etudiant.get("niveau") %></td>
                    <td><%= etudiant.get("institution") %></td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
    <%
        }
    %>

</body>
</html>
