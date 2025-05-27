package com.example.projetjsp.controller;

import java.io.IOException;
import java.util.List;
import java.util.Date;
import com.example.projetjsp.models.Etudiant;
import com.example.projetjsp.dao.EtudiantDao;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;

@WebServlet("/etudiants")
public class EtudiantServ extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        boolean testsup = false;
        boolean testmod = false;

        if (action == null || action.equals("lister")) {
            List<Etudiant> listeEtudiants = EtudiantDao.getTousEtudiants();
            request.setAttribute("etudiants", listeEtudiants);
            request.getRequestDispatcher("/Pages/etudiant.jsp").forward(request, response);
        }else if (action.equals("supform")){
            String matricule = request.getParameter("matricule");
            testsup = true;
            request.setAttribute("matricule", matricule);
            request.setAttribute("testsup", testsup);
            request.getRequestDispatcher("/Pages/etudiant.jsp").forward(request, response);
        }else if (action.equals("modform")){
            String matricule = request.getParameter("matricule");
            testmod = true;
            List<Etudiant> etudiant = EtudiantDao.getEtudiantsID(matricule);
            request.setAttribute("modetudiant", etudiant);
            request.setAttribute("testmod", testmod);
            request.getRequestDispatcher("/Pages/etudiant.jsp").forward(request, response);
        }else if(action.equals("supprimer")){
            String matricule = request.getParameter("matricule");
            EtudiantDao.supprimerEtudiant(matricule);
            response.sendRedirect("etudiants?action=lister");
        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action.equals("ajouter")) {
            String matricule = request.getParameter("matricule");
            String nom = request.getParameter("nom");
            String sexe = request.getParameter("sexe");
            java.sql.Date datenais = java.sql.Date.valueOf(request.getParameter("datenais"));
            String institution = request.getParameter("institution");
            String mail = request.getParameter("mail");
            String idniv = request.getParameter("idniv");
            EtudiantDao.ajouterEtudiant(new Etudiant(matricule, nom, sexe, datenais, institution, mail, idniv));
            response.sendRedirect("etudiants?action=lister");
        }else if(action.equals("modifier")){
            String matricule = request.getParameter("matricule");
            String nom = request.getParameter("nom");
            String sexe = request.getParameter("sexe");
            java.sql.Date datenais = java.sql.Date.valueOf(request.getParameter("datenais"));
            String institution = request.getParameter("institution");
            String mail = request.getParameter("mail");
            String idniv = request.getParameter("idniv");
            EtudiantDao.modifierEtudiant(new Etudiant(matricule, nom, sexe, datenais, institution, mail, idniv));
            response.sendRedirect("etudiants?action=lister");
        }else if(action.equals("retard")){
            int mois = Integer.parseInt(request.getParameter("mois"));
            List<Etudiant> listeretard = EtudiantDao.getRetardataires(mois);
            request.setAttribute("retardataires", listeretard);
            request.getRequestDispatcher("/Pages/retardataire.jsp").forward(request, response);
        }else if (action.equals("rechercher")){
            String recherche = request.getParameter("recherche");
            List<Etudiant> listerec = EtudiantDao.getrecherche(recherche);
            request.setAttribute("recherches", listerec);
            request.getRequestDispatcher("/Pages/etudiant.jsp").forward(request, response);
        }else if(action.equals("trier")){
            String niveau = request.getParameter("niveau");
            String etab = request.getParameter("etab");
            String age = request.getParameter("age");
            List<Etudiant> listetrier = EtudiantDao.trierEtudiant(niveau, etab, age);
            request.setAttribute("triers", listetrier);
            request.getRequestDispatcher("/Pages/etudiant.jsp").forward(request, response);
        }
    }
}