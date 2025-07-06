package com.example.projetjsp.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.Properties;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;

import com.google.gson.JsonParser;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import com.example.projetjsp.dao.JavaDao;
import com.example.projetjsp.models.Java;
import com.google.gson.JsonObject;
import org.json.JSONObject;

@WebServlet("/javas")
public class JavaServ extends HttpServlet {
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_FROM = "tokyadriano45@gmail.com";
    private static final String EMAIL_PASSWORD = "mtql pilm vctv obem";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.equals("lister")) {
            List<Java> liste = JavaDao.getTousHistorique();
            request.setAttribute("javas", liste);
            request.getRequestDispatcher("/Pages/JAVA.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        BufferedReader reader = request.getReader();
        StringBuilder jsonBuffer = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonBuffer.append(line);
        }

        JsonObject json = JsonParser.parseString(jsonBuffer.toString()).getAsJsonObject();
        String destinataire = json.get("destinataire").getAsString();
        String objet = json.get("objet").getAsString();
        String message = json.get("message").getAsString();


        try {
            Properties props = new Properties();
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");
            props.put("mail.smtp.ssl.trust", SMTP_HOST);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);

            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_FROM, EMAIL_PASSWORD);
                }
            });

            session.setDebug(true);

            Message mimeMessage = new MimeMessage(session);
            mimeMessage.setFrom(new InternetAddress(EMAIL_FROM));
            mimeMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinataire));
            mimeMessage.setSubject(objet);
            mimeMessage.setText(message);

            Transport.send(mimeMessage);

            Java historique = new Java();
            historique.setExpediteur(EMAIL_FROM);
            historique.setDestinataire(destinataire);
            historique.setObjet(objet);
            historique.setMessage(message);
            historique.setDate(new Timestamp(System.currentTimeMillis()));

            boolean success = JavaDao.ajouterHistorique(historique);

            if (success) {
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de l'enregistrement.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Erreur d'envoi d'email: " + e.getMessage());
        }
    }
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }

            JSONObject json = new JSONObject(sb.toString());
            int mailId = json.getInt("id");

            boolean success = JavaDao.supprimerHistorique(mailId);
            response.setContentType("application/json");
            response.getWriter().write("{\"success\":" + success + "}");

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}