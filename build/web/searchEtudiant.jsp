<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--<%@ page import="java.sql.*, java.io.*, java.util.*" %>
<%@ page import="javax.naming.*, javax.servlet.*, javax.servlet.http.*, javax.sql.*" %>--%>
<%@ page import="java.lang.String" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>

<%
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bourse", "root", "");
        stmt = con.createStatement();

        String search = request.getParameter("search");
        String query = "SELECT * FROM etudiant";
        if (search != null && !search.isEmpty()) {
            query += " WHERE matricule LIKE '%" + search + "%' OR nom LIKE '%" + search + "%' OR sexe LIKE '%" + search +
                    "%' OR datenais LIKE '%" + search + "%' OR institution LIKE '%" + search + "%' OR niveau LIKE '%" + search + "%' OR mail LIKE '%" + search +
                    "%' OR anneeUniv LIKE '%" + search + "%'" ;
        }

        rs = stmt.executeQuery(query);

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
        <button class="btn btn-primary btn-sm"
                onclick="goToUpdate('<%= rs.getString("matricule") %>',
                        '<%= rs.getString("nom") %>',
                        '<%= rs.getString("sexe") %>',
                    '<%= rs.getString("datenais") %>',
                    '<%= rs.getString("institution") %>',
                    '<%= rs.getString("niveau") %>',
                        '<%= rs.getString("mail") %>',
                    '<%= rs.getString("anneeUniv") %>')">;
            <i class="fas fa-edit"></i>
        </button>
        <button class="btn btn-danger btn-sm" onclick="deleteEtudiant('<%= rs.getString("matricule") %>')">
            <i class="fas fa-trash-alt"></i>
        </button>
    </td>
</tr>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
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
