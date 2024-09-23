<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String idNiv = request.getParameter("idNiv");
    Connection con = null;
    Statement stmt = null;

    try {
        // Charger le pilote JDBC MySQL
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Établir la connexion à la base de données
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bourse", "root", "");

        // Créer l'instruction de suppression
        stmt = con.createStatement();
        String query = "DELETE FROM montant WHERE idNiv = '" + idNiv + "'";

        // Exécuter l'instruction de suppression
        int result = stmt.executeUpdate(query);

        // Retourner une réponse
        if (result > 0) {
            out.println("Success");
        } else {
            out.println("Failure");
        }
    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("Failure");
    } finally {
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
