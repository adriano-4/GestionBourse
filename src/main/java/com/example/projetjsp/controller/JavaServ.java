package com.example.projetjsp.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.util.List;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.mail.util.ByteArrayDataSource;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.http.Part;

import com.example.projetjsp.dao.JavaDao;
import com.example.projetjsp.models.FichierJoint;
import com.example.projetjsp.models.Java;

@WebServlet("/javas")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,    // 1MB
        maxFileSize = 1024 * 1024 * 10,     // 10MB
        maxRequestSize = 1024 * 1024 * 50   // 50MB
)
public class JavaServ extends HttpServlet {
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_FROM = "tokyadriano45@gmail.com";
    private static final String EMAIL_PASSWORD = "mtql pilm vctv obem";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.equals("lister")) {
            List<Java> liste = JavaDao.getTousHistorique();
            request.setAttribute("javas", liste);
            request.getRequestDispatcher("/Pages/JAVA.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

            String destinataire = request.getParameter("destinataire");
            String objet = request.getParameter("objet");
            String messageTexte = request.getParameter("message");

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

                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress(EMAIL_FROM));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinataire));
                message.setSubject(objet);

                Multipart multipart = new MimeMultipart();

                MimeBodyPart messageBodyPart = new MimeBodyPart();
                messageBodyPart.setContent(messageTexte, "text/plain; charset=utf-8");
                multipart.addBodyPart(messageBodyPart);

                for (Part part : request.getParts()) {
                    if (part.getName().equals("fichiers") && part.getSize() > 0) {
                        MimeBodyPart filePart = new MimeBodyPart();
                        filePart.setFileName(MimeUtility.encodeText(part.getSubmittedFileName()));
                        filePart.setDataHandler(new DataHandler(new ByteArrayDataSource(
                                part.getInputStream(),
                                part.getContentType())));
                        multipart.addBodyPart(filePart);

                    }
                }
                message.setContent(multipart);

                Transport.send(message);

                Java historique = new Java();
                historique.setExpediteur(EMAIL_FROM);
                historique.setDestinataire(destinataire);
                historique.setObjet(objet);
                historique.setMessage(messageTexte);
                historique.setDate(new Timestamp(System.currentTimeMillis()));

                boolean success = JavaDao.ajouterHistorique(historique);

                if (success) {
                    int mailId = JavaDao.getLastInsertedId();

                    if (mailId > 0) {
                        for (Part part : request.getParts()) {
                            if (part.getName().equals("fichiers") && part.getSize() > 0) {
                                FichierJoint fichier = new FichierJoint();
                                fichier.setNom(part.getSubmittedFileName());
                                fichier.setTaille(part.getSize());
                                fichier.setTypeMime(part.getContentType());


                                JavaDao.ajouterFichier(mailId, fichier);
                            }
                        }
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de l'enregistrement.");
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Erreur d'envoi d'email: " + e.getMessage());
            }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }

            org.json.JSONObject json = new org.json.JSONObject(sb.toString());
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
