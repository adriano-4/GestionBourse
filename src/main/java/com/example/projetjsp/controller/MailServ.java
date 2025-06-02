package com.example.projetjsp.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Date;

import com.example.projetjsp.dao.EtudiantDao;
import com.example.projetjsp.models.Etudiant;
import com.example.projetjsp.models.Mail;
import com.example.projetjsp.dao.MailDao;
import jakarta.mail.MessagingException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;

@WebServlet("/mails")
public class MailServ extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.equals("lister")) {
            List<Mail> listeMails = MailDao.getMails();
            request.setAttribute("mails", listeMails);
            request.getRequestDispatcher("/Pages/mail.jsp").forward(request, response);
        }else if (action.equals("envoyer")) {
            java.sql.Date date_envoie = java.sql.Date.valueOf(LocalDate.now());
            String matricule = request.getParameter("matricule");
            String mail = request.getParameter("mail");
            String nom = request.getParameter("nom");
            String objet = "Notification retard de bourse";
            String contenus = "Cher " + nom + ",\n\n"
                    + "Nous vous informons que vous êtes en retard pour le dernier paiement de votre bourse.\n"
                    + "Veuillez effectuer le retrait durant cette semaine.\n\n"
                    + "Cordialement,\n"
                    + "Le Service des Bourses.";
            try {
                MailDao.envoieMail(mail,objet,contenus);
                MailDao.ajouterMail(new Mail(date_envoie,matricule));
                response.sendRedirect("etudiants?action=retard");
            } catch (MessagingException e) {
                throw new RuntimeException(e);
            }
        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action.equals("ajouter")) {
            String matricule = request.getParameter("matricule");
            java.sql.Date date_envoie = java.sql.Date.valueOf(LocalDate.now());
            MailDao.ajouterMail(new Mail(date_envoie,matricule));
            response.sendRedirect("mails?action=lister");
        }
    }
}
