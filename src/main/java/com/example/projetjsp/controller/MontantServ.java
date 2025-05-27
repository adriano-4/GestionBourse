package com.example.projetjsp.controller;

import java.io.IOException;
import java.util.List;
import java.util.Date;

import com.example.projetjsp.dao.EtudiantDao;
import com.example.projetjsp.models.Etudiant;
import com.example.projetjsp.models.Montant;
import com.example.projetjsp.dao.MontantDao;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;

@WebServlet("/montants")
public class MontantServ extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        boolean testsup = false;
        boolean testmod = false;

        if (action == null || action.equals("lister")) {
            List<Montant> liste = MontantDao.getTousMontants();
            request.setAttribute("montants", liste);
            request.getRequestDispatcher("/Pages/montant.jsp").forward(request, response);
        }else if (action.equals("modform")){
            String idniv = request.getParameter("idniv");
            testmod = true;
            List<Montant> montant = MontantDao.getMontantsID(idniv);
            request.setAttribute("modmontant", montant);
            request.setAttribute("testmod", testmod);
            request.getRequestDispatcher("/Pages/montant.jsp").forward(request, response);
        }else if (action.equals("supform")){
            String idniv = request.getParameter("idniv");
            testsup = true;
            request.setAttribute("idniv", idniv);
            request.setAttribute("testsup", testsup);
            request.getRequestDispatcher("/Pages/montant.jsp").forward(request, response);
        }else if (action.equals("supprimer")) {
            String idniv = request.getParameter("idniv");
            MontantDao.supprimerMontant(idniv);
            response.sendRedirect("montants?action=lister");
        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action.equals("ajouter")) {
            String idniv = request.getParameter("idniv");
            String niveau = request.getParameter("niveau");
            String statut = request.getParameter("statut");
            int montant = Integer.parseInt(request.getParameter("montant"));
            MontantDao.ajouterMontant(new Montant(idniv, niveau, statut, montant));
            response.sendRedirect("montants?action=lister");
        }else if (action.equals("modifier")) {
            String idniv = request.getParameter("idniv");
            String niveau = request.getParameter("niveau");
            String statut = request.getParameter("statut");
            int montant = Integer.parseInt(request.getParameter("montant"));
            MontantDao.modifierMontant(new Montant(idniv, niveau, statut, montant));
            response.sendRedirect("montants?action=lister");
        }
    }
}