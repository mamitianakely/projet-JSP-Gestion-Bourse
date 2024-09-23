<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: MAMY
  Date: 21/06/2024
  Time: 01:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Ajouter les montants</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
</head>
<body>
<script>
    function backHome() {
        window.location.href = "listMontant.jsp"; // Changer vers l'URL correcte
    }
</script>
<button class="btn btn-secondary m-3" onclick="backHome()">
    <i class="fa fa-arrow-left"></i> Retour
</button>
<div class="container mt-5">
    <h2 class="mb-4">Formulaire pour ajouter un montant</h2>
    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String idNiv = request.getParameter("idNiv");
            String niveau = request.getParameter("niveau");
            int montant = Integer.parseInt(request.getParameter("montant"));

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bourse", "root", "");
                String sql = "INSERT INTO montant (idNiv, niveau, montant) VALUES (?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, idNiv);
                pstmt.setString(2, niveau);
                pstmt.setInt(3, montant);

                int rows = pstmt.executeUpdate();
                response.sendRedirect("listMontant.jsp");
                if (rows > 0) {
    %>
    <script>
        Toastify({
            text: "Montant ajouté avec succès",
            duration: 3000,
            close: true,
            gravity: "top",
            position: "right",
            backgroundColor: "#28a745",
            stopOnFocus: true
        }).showToast();
        setTimeout(function() {
            window.location.href = "listMontant.jsp";
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
            <label for="idNiv">Identifiant du niveau :</label>
            <input type="text" class="form-control" id="idNiv" name="idNiv" placeholder="Entrer l'identifiant" required>
        </div>
        <div class="form-group">
            <label for="niveau">Niveau de l'Étudiant :</label>
            <select class="form-control" id="niveau" name="niveau" required>
                <option>L1</option>
                <option>L2</option>
                <option>L3</option>
                <option>M1</option>
                <option>M2</option>
            </select>
        </div>
        <div class="form-group">
            <label for="montant">Montant :</label>
            <input type="number" class="form-control" id="montant" name="montant" placeholder="Entrer le montant" required>
        </div>
        <button type="submit" class="btn btn-primary">Ajouter</button>
        <a href="index.jsp" class="btn btn-danger">Annuler</a>
    </form>
</div>
<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
</body>
</html>
