package com.example.projetjsp.dao;

import com.example.projetjsp.models.Mail;
import com.example.projetjsp.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.sql.Date;
import java.util.ArrayList;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class MailDao {
    public static List<Mail> getMails() {
        List<Mail> liste = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT e.matricule,e.nom,e.mail,m.date_envoie FROM etudiant e,mail m WHERE e.matricule=m.matricule")) {

            while (rs.next()) {
                Mail m = new Mail();
                m.setMatricule(rs.getString("matricule"));
                m.setNom(rs.getString("nom"));
                m.setMail(rs.getString("mail"));
                m.setDate_envoie(rs.getDate("date_envoie"));
                liste.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return liste;
    }

    public static void ajouterMail(Mail m) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("INSERT INTO mail (date_envoie, matricule) VALUES (?, ?)")) {
            stmt.setDate(1, new java.sql.Date(m.getDate_envoie().getTime()));
            stmt.setString(2, m.getMatricule());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public static void envoieMail(String to, String objet, String contenus) throws MessagingException {
        final String from = "ririniony@gmail.com";
        final String password = "papl ulcq zoyx ebeb";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(from, password);
                    }
                });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(from));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(objet);
        message.setText(contenus);

        Transport.send(message);
    }
}
