<%@ page import="java.util.Date" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="static java.lang.Class.forName" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: MAMY
  Date: 20/06/2024
  Time: 20:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Ajouter un Étudiant</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Toastify CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <!-- FontAwesome CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
</head>
<body>
<script>
    function backHome() {
        window.location.href = "listEtudiant.jsp"; // Changer vers l'URL correcte
    }
</script>
<button class="btn btn-secondary m-3" onclick="backHome()">
    <i class="fa fa-arrow-left"></i> Retour
</button>
<div class="container mt-5">
    <h2 class="mb-4">Formulaire pour ajouter un étudiant</h2>
    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
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

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bourse", "root", "");
                String sql = "INSERT INTO etudiant (matricule, nom, sexe, datenais, institution, niveau, mail, anneeUniv) VALUES (?,?,?,?,?,?,?,?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, matricule);
                pstmt.setString(2, nom);
                pstmt.setString(3, sexe);
                pstmt.setString(4, datenais);
                pstmt.setString(5, institution);
                pstmt.setString(6, niveau);
                pstmt.setString(7, mail);
                pstmt.setString(8, anneeUniv);
                int rows = pstmt.executeUpdate();
                response.sendRedirect("listEtudiant.jsp");
                if (rows > 0) {
    %>
    <script>
        Toastify({
            text: "Étudiant ajouté avec succès",
            duration: 3000,
            close: true,
            gravity: "top",
            position: "right",
            backgroundColor: "#28a745",
            stopOnFocus: true
        }).showToast();
        setTimeout(function() {
            window.location.href = "listEtudiant.jsp"; // Changer vers l'URL correcte
        }, 3000);
    </script>
    <%
                }
            } catch (Exception e) {
    %>
    <div class="alert alert-danger">
        Erreur : <%= e.getMessage() %>
    </div>
    <%
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
    <form method="post">
        <div class="form-group">
            <label for="matricule">Numéro matricule :</label>
            <input type="text" class="form-control" id="matricule" name="matricule" placeholder="Entrer le numéro matricule" required>
        </div>
        <div class="form-group">
            <label for="nom">Nom de l'étudiant :</label>
            <input type="text" class="form-control" id="nom" name="nom" placeholder="Entrer le nom de l'étudiant" required>
        </div>
        <div class="form-group">
            <label for="sexe">Sexe :</label>
            <select class="form-control" id="sexe" name="sexe" required>
                <option>Masculin</option>
                <option>Féminin</option>
            </select>
        </div>
        <div class="form-group">
            <label for="datenais">Date de naissance :</label>
            <input type="date" class="form-control" id="datenais" name="datenais" required>
        </div>
        <div class="form-group">
            <label for="institution">Nom de l'institution :</label>
            <input type="text" class="form-control" id="institution" name="institution" placeholder="Entrer le nom de l'institution" required>
        </div>
        <div class="form-group">
            <label for="niveau">Niveau de l'étudiant :</label>
            <select class="form-control" id="niveau" name="niveau" required>
                <option>L1</option>
                <option>L2</option>
                <option>L3</option>
                <option>M1</option>
                <option>M2</option>
            </select>
        </div>
        <div class="form-group">
            <label for="mail">Mail de l'étudiant :</label>
            <input type="email" class="form-control" id="mail" name="mail" placeholder="Entrer le mail de l'étudiant" required>
        </div>
        <div class="form-group">
            <label for="anneeUniv">Année universitaire :</label>
            <input type="text" class="form-control" id="anneeUniv" name="anneeUniv" placeholder="Entrer l'année universitaire" required>
        </div>
        <button type="submit" class="btn btn-primary">Ajouter</button>
        <a href="listEtudiant.jsp" class="btn btn-danger">Annuler</a>
    </form>
</div>
<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- Toastify JS -->
<script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
</body>
</html>
