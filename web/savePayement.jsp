<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    // Récupérer les données du formulaire
    String idpaye = request.getParameter("idpaye");
    String matricule = request.getParameter("matricule");
    String anneeUniv = request.getParameter("anneeUniv");
    String date = request.getParameter("date");
    String nombreMois = request.getParameter("nombreMois");


    Connection conn = null;
    PreparedStatement pstmt = null;
    String url = "jdbc:mysql://localhost:3306/bourse";
    String user = "root";
    String password = ""; // Assurez-vous que cette valeur est sécurisée

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Créer la requête SQL UPDATE
        String sql = "UPDATE payer SET matricule=?, anneeUniv=?, date=?, nombreMois=? WHERE idpaye=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, matricule);
        pstmt.setString(2, anneeUniv);
        pstmt.setString(3, date);
        pstmt.setString(4, nombreMois);
        pstmt.setString(5, idpaye);// Utilisation de idpaye pour la clause WHERE

        int rows = pstmt.executeUpdate();
        if (rows > 0) {
            response.sendRedirect("listPayer.jsp");
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
