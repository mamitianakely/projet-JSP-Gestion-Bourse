<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%-- 
  Created by IntelliJ IDEA.
  User: MAMY
  Date: 22/06/2024
  Time: 09:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Payement</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<script>
    function backHome(){
        window.location.href = "listPayer.jsp"; // Changer vers l'URL correcte
    }

    function updateAnneeUniv() {
        var matricule = document.getElementById("matricule").value;
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "getAnneeUniv.jsp?matricule=" + matricule, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && xhr.status == 200) {
                document.getElementById("anneeUniv").value = xhr.responseText.trim();
            }
        };
        xhr.send();
    }

    function validateForm() {
        var nombreMois = document.getElementById("nombreMois").value;
        if (parseInt(nombreMois) === 0) {
            alert("Le paiement n'est pas encore effectué.");
            return false;
        }
        return true;
    }
</script>
<button class="btn btn-secondary m-3" onclick="backHome()">
    <i class="fa fa-arrow-left"></i> Retour
</button>
<div class="container mt-5">
    <h2 class="mb-4">Formulaire pour un paiement</h2>
    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String idpaye = request.getParameter("idpaye");
            String matricule = request.getParameter("matricule");
            String anneeUniv = request.getParameter("anneeUniv");
            String date = request.getParameter("date");
            int nombreMois = Integer.parseInt(request.getParameter("nombreMois")); // Convertir en entier

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bourse", "root", "");
                String sql = "INSERT INTO payer (idpaye, matricule, anneeUniv, date, nombreMois) VALUES (?,?,?,?,?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, idpaye);
                pstmt.setString(2, matricule);
                pstmt.setString(3, anneeUniv);
                pstmt.setString(4, date);
                pstmt.setInt(5, nombreMois);

                int rows = pstmt.executeUpdate();
                response.sendRedirect("listPayer.jsp");
                if (rows > 0) {
    %>
    <script>
        Toastify({
            text: "Paiement effectué avec succès",
            duration: 3000,
            close: true,
            gravity: "top",
            position: "right",
            backgroundColor: "#28a745",
            stopOnFocus: true
        }).showToast();
        setTimeout(function() {
            window.location.href = "index.jsp"; // Changer vers l'URL correcte
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
    <form method="post" onsubmit="return validateForm()">
        <div class="form-group">
            <label for="idpaye">Identifiant du paiement :</label>
            <input type="text" class="form-control" id="idpaye" name="idpaye" placeholder="Entrer l'identifiant" required>
        </div>
        <div class="form-group">
            <label for="matricule">Numéro Matricule :</label>
            <select class="form-control" id="matricule" name="matricule" onchange="updateAnneeUniv()" required>
                <%
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bourse", "root", "");
                        String sql = "SELECT matricule FROM etudiant";
                        pstmt = conn.prepareStatement(sql);
                        rs = pstmt.executeQuery();
                        while (rs.next()) {
                %>
                <option value="<%= rs.getString("matricule") %>"><%= rs.getString("matricule") %></option>
                <%
                        }
                    } catch (ClassNotFoundException | SQLException e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </select>
        </div>
        <div class="form-group">
            <label for="anneeUniv">Année Universitaire :</label>
            <input type="text" class="form-control" id="anneeUniv" name="anneeUniv" readonly required>
        </div>
        <div class="form-group">
            <label for="date">Date de paiement :</label>
            <input type="datetime-local" class="form-control" id="date" name="date">
        </div>
        <div class="form-group">
            <label for="nombreMois">Nombre de mois :</label>
            <input type="number" class="form-control" id="nombreMois" name="nombreMois" placeholder="Entrer le nombre de mois" required>
        </div>
        <button type="submit" class="btn btn-primary">Ajouter</button>
        <a href="index.jsp" class="btn btn-danger">Annuler</a>
    </form>
</div>
<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
