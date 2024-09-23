<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
        // Récupérer les données du formulaire
        String idNiv = request.getParameter("idNiv");
        String niveau = request.getParameter("niveau");
        String montant = request.getParameter("montant");

        Connection conn = null;
        PreparedStatement pstmt = null;
        String url = "jdbc:mysql://localhost:3306/bourse";
        String user = "root";
        String password = ""; // Assurez-vous que cette valeur est sécurisée

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Créer la requête SQL UPDATE
        String sql = "UPDATE montant SET niveau=?, montant=? WHERE idNiv=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, niveau);
        pstmt.setString(2, montant);
        pstmt.setString(3, idNiv); // Utilisation de matricule pour la clause WHERE


        int rows = pstmt.executeUpdate();
        if (rows > 0) {
            response.sendRedirect("listMontant.jsp");
        } else {
            System.out.println("<p>Erreur de mise à jour</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("<p>Erreur : " + e.getMessage() + "</p>");
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>