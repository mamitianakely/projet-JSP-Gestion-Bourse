<%-- 
    Document   : getAnneeUniv
    Created on : 1 juil. 2024, 08:05:36
    Author     : fitahiana
--%>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%
    String matricule = request.getParameter("matricule");
    String anneeUniv = "";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bourse", "root", "");
        String sql = "SELECT anneeUniv FROM etudiant WHERE matricule = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, matricule);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            anneeUniv = rs.getString("anneeUniv");
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }

    out.print(anneeUniv);
%>
