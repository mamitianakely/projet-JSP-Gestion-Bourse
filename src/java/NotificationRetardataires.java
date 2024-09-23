import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class NotificationRetardataires {

    public static void main(String[] args) {
    String url = "jdbc:mysql://localhost:3306/bourse";
    String user = "root";
    String password = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            String query = "SELECT E.mail, E.nom, P.date " +
                           "FROM etudiant E " +
                           "JOIN payer P ON E.matricule = P.matricule " +
                           "WHERE P.nombreMois = 0 AND TIMESTAMPDIFF(MINUTE, P.date, NOW()) >= 1";

            try (PreparedStatement ps = conn.prepareStatement(query);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    String email = rs.getString("mail");
                    String nom = rs.getString("nom");
                    Date datePaiement = rs.getDate("date");

                    System.out.println("Envoi d'email à : " + email + " pour " + nom);
                    sendEmail(email, nom, datePaiement);
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
}


    private static void sendEmail(String to, String nom, Date datePaiement) {
        String host = "smtp.gmail.com";
        final String from = "ramampiandralarissa@gmail.com";
        final String password = "ldqa bedk tsbc zhvx";

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.debug", "true");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                return new javax.mail.PasswordAuthentication(from, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("Notification de retard de paiement");
            message.setText("Cher " + nom + ",\n\nVous êtes en retard pour le paiement depuis le " + datePaiement + ". Veuillez effectuer le paiement dès que possible.\n\nMerci.");

            Transport.send(message);
            System.out.println("Email envoyé avec succès à " + to);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
