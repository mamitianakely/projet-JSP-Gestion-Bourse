<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    // Récupérer les données du formulaire
    String matricule = request.getParameter("matricule");
    String nom = request.getParameter("nom");
    String sexe = request.getParameter("sexe");
    String datenais = request.getParameter("datenais");
    String institution = request.getParameter("institution");
    String niveau = request.getParameter("niveau");
    String mail = request.getParameter("mail");
    String anneeUniv = request.getParameter("anneeUniv");

    Connection conn = null;
    PreparedStatement pstmt = null;
    String url = "jdbc:mysql://localhost:3306/bourse";
    String user = "root";
    String password = ""; // Assurez-vous que cette valeur est sécurisée

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Créer la requête SQL UPDATE
        String sql = "UPDATE etudiant SET nom=?, sexe=?, datenais=?, institution=?, niveau=?, mail=?, anneeUniv=? WHERE matricule=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, nom);
        pstmt.setString(2, sexe);
        pstmt.setString(3, datenais);
        pstmt.setString(4, institution);
        pstmt.setString(5, niveau);
        pstmt.setString(6, mail);
        pstmt.setString(7, anneeUniv);
        pstmt.setString(8, matricule); // Utilisation de matricule pour la clause WHERE

        int rows = pstmt.executeUpdate();
        if (rows > 0) {
            response.sendRedirect("listEtudiant.jsp");
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
