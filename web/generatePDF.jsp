<%@ page import="com.itextpdf.text.*" %>
<%@ page import="com.itextpdf.text.pdf.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="application/pdf" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Locale" %>

<%
    String matricule = request.getParameter("matricule");
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Connexion � la base de donn�es
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bourse", "root", "");

        // R�cup�ration des donn�es de l'�tudiant
        String query = "SELECT e.*, m.montant, p.date AS date_paiement, p.nombreMois " +
                       "FROM etudiant e " +
                       "LEFT JOIN montant m ON e.niveau = m.niveau " +
                       "LEFT JOIN payer p ON e.matricule = p.matricule " +
                       "WHERE e.matricule = ?";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, matricule);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            // Cr�ation du document PDF
            Document document = new Document();
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            PdfWriter.getInstance(document, baos);
            document.open();

             // Formater la date actuelle
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd MMMM yyyy", new Locale("fr", "FR"));
        String currentDate = LocalDate.now().format(dateFormatter);

        // Formater la date de naissance
        LocalDate dateNais = rs.getDate("datenais").toLocalDate();
        String formattedDateNais = dateNais.format(dateFormatter);
        
         // Cr�er un style de paragraphe centr�
        Paragraph titreStyle = new Paragraph();
        titreStyle.setAlignment(Element.ALIGN_CENTER);

        // Ajouter les paragraphes centr�s
        titreStyle.add(new Chunk("Re�u de paiement de bourse"));
        document.add(titreStyle);
        
        document.add(new Paragraph(" "));
        titreStyle = new Paragraph();
        titreStyle.setAlignment(Element.ALIGN_CENTER);
        titreStyle.add(new Chunk("Aujourd'hui le " + currentDate));
        document.add(titreStyle);

        // Ajouter un espace apr�s les titres centr�s
        document.add(new Paragraph(" "));

        // Ajout du contenu au PDF
        document.add(new Paragraph("Matricule: " + rs.getString("matricule")));
        document.add(new Paragraph("Nom: " + rs.getString("nom")));
        document.add(new Paragraph("N�(e) le: " + formattedDateNais));
        document.add(new Paragraph("Sexe: " + rs.getString("sexe")));
        document.add(new Paragraph("Institution: " + rs.getString("institution") + " / Niveau: " + rs.getString("niveau")));
            
            document.add(new Paragraph("\nD�tails du paiement:"));
            document.add(new Paragraph(" "));
            PdfPTable table = new PdfPTable(2);
            table.addCell("Mois");
            table.addCell("Montant");
            
            // �quipement (constant pour tous les �tudiants)
            table.addCell("�quipement");
            table.addCell("66000");
            
            int totalPaye = 66000; // Commencer avec le montant de l'�quipement
            
            // Ajouter les mois pay�s
            int nbrMois = rs.getInt("nombreMois");
            int montantMensuel = rs.getInt("montant");
            for (int i = 0; i < nbrMois; i++) {
                table.addCell("Mois " + (i + 1));
                table.addCell(String.valueOf(montantMensuel));
                totalPaye += montantMensuel;
            }
            
            document.add(table);
            
            document.add(new Paragraph("\nTotal Pay�: " + totalPaye + " Ariary"));

            document.close();

            // Envoi du PDF au navigateur
            response.setContentType("application/pdf");
            response.setContentLength(baos.size());
            OutputStream os = response.getOutputStream();
            baos.writeTo(os);
            os.flush();
            os.close();
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Fermer les ressources
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>