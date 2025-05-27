package com.example.projetjsp.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Date;

import com.example.projetjsp.dao.MontantDao;
import com.example.projetjsp.models.Montant;
import com.example.projetjsp.models.Payer;
import com.example.projetjsp.dao.PayerDao;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;

@WebServlet("/payements")
public class PayerServ extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        boolean testsup = false;
        boolean testmod = false;

        if (action == null || action.equals("lister")) {
            List <Payer> liste = PayerDao.getTousPayements();
            request.setAttribute("payments", liste);
            request.getRequestDispatcher("/Pages/payer.jsp").forward(request, response);
        }else if (action.equals("modform")){
            int idpaye = Integer.parseInt(request.getParameter("idpaye"));
            testmod = true;
            List<Payer> payer = PayerDao.getPayementsID(idpaye);
            request.setAttribute("modpayer", payer);
            request.setAttribute("testmod", testmod);
            request.getRequestDispatcher("/Pages/payer.jsp").forward(request, response);
        }else if (action.equals("supform")){
            int idpaye = Integer.parseInt(request.getParameter("idpaye"));
            testsup = true;
            request.setAttribute("idpaye", idpaye);
            request.setAttribute("testsup", testsup);
            request.getRequestDispatcher("/Pages/payer.jsp").forward(request, response);
        }else if (action.equals("supprimer")) {
            int idpaye = Integer.parseInt(request.getParameter("idpaye"));
            PayerDao.supprimerPayer(idpaye);
            response.sendRedirect("payements?action=lister");
        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("ajouter")) {
            int idpaye = Integer.parseInt(request.getParameter("idpaye"));
            String anne_univ = request.getParameter("anne_univ");
            java.sql.Date daty = java.sql.Date.valueOf(LocalDate.now());
            int nbr_mois = Integer.parseInt(request.getParameter("nbr_mois"));
            String matricule = request.getParameter("matricule");
            int idequipement = Integer.parseInt(request.getParameter("idequipement"));
            PayerDao.ajouterPayement(new Payer(idpaye,anne_univ,daty,nbr_mois,matricule,idequipement));
            response.sendRedirect("payements?action=lister");
        }else if (action.equals("modifier")) {
            int idpaye = Integer.parseInt(request.getParameter("idpaye"));
            String anne_univ = request.getParameter("anne_univ");
            java.sql.Date daty = java.sql.Date.valueOf(request.getParameter("daty"));
            int nbr_mois = Integer.parseInt(request.getParameter("nbr_mois"));
            String matricule = request.getParameter("matricule");
            int idequipement = Integer.parseInt(request.getParameter("idequipement"));
            PayerDao.modifierPayer(new Payer(idpaye,anne_univ,daty,nbr_mois,matricule,idequipement));
            response.sendRedirect("payements?action=lister");
        }
    }
}