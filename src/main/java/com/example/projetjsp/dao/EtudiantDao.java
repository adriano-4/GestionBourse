package com.example.projetjsp.dao;

import com.example.projetjsp.models.Etudiant;
import com.example.projetjsp.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.sql.Date;
import java.util.ArrayList;

public class EtudiantDao {
    public static List<Etudiant> getTousEtudiants() {
        List<Etudiant> liste = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM etudiant")) {

            while (rs.next()) {
                Etudiant e = new Etudiant();
                e.setMatricule(rs.getString("matricule"));
                e.setNom(rs.getString("nom"));
                e.setSexe(rs.getString("sexe"));
                e.setDatenais(rs.getDate("datenais"));
                e.setInstitution(rs.getString("institution"));
                e.setMail(rs.getString("mail"));
                e.setIdniv(rs.getString("idniv"));
                liste.add(e);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return liste;
    }
    public static List<Etudiant> getEtudiantsID(String matricule) {
        List<Etudiant> liste = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM etudiant WHERE matricule LIKE ?")){
            stmt.setString(1, matricule);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Etudiant e = new Etudiant();
                e.setMatricule(rs.getString("matricule"));
                e.setNom(rs.getString("nom"));
                e.setSexe(rs.getString("sexe"));
                e.setDatenais(rs.getDate("datenais"));
                e.setInstitution(rs.getString("institution"));
                e.setMail(rs.getString("mail"));
                e.setIdniv(rs.getString("idniv"));
                liste.add(e);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return liste;
    }
    public static List<Etudiant> getRetardataires(int mois) {
        List<Etudiant> liste = new ArrayList<>();
        try(Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT e.matricule, e.nom, e.sexe, e.datenais, e.institution, e.mail, e.idniv " +
                    "FROM etudiant e LEFT JOIN payer p ON e.matricule = p.matricule AND p.anne_univ = '2024-2025' WHERE (p.date IS NULL OR MONTH(p.date) < ?)")){
            stmt.setInt(1, mois-1);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Etudiant e = new Etudiant();
                e.setMatricule(rs.getString("matricule"));
                e.setNom(rs.getString("nom"));
                e.setSexe(rs.getString("sexe"));
                e.setDatenais(rs.getDate("datenais"));
                e.setInstitution(rs.getString("institution"));
                e.setMail(rs.getString("mail"));
                e.setIdniv(rs.getString("idniv"));
                liste.add(e);
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return liste;
    }
    public static  List<Etudiant> getrecherche(String recherche) {
        List<Etudiant> liste = new ArrayList<>();
        try(Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM etudiant WHERE nom LIKE ? OR matricule LIKE ?")){
            stmt.setString(1, "%"+recherche+"%");
            stmt.setString(2, "%"+recherche+"%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Etudiant e = new Etudiant();
                e.setMatricule(rs.getString("matricule"));
                e.setNom(rs.getString("nom"));
                e.setSexe(rs.getString("sexe"));
                e.setDatenais(rs.getDate("datenais"));
                e.setInstitution(rs.getString("institution"));
                e.setMail(rs.getString("mail"));
                e.setIdniv(rs.getString("idniv"));
                liste.add(e);
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return liste;
    }
    public static List<Etudiant> trierEtudiant(String niveau,String institution,String age){
        List<Etudiant> liste = new ArrayList<>();
        String sql = "";
        if (age.equals("none")){
            if (!institution.equals("none") && !niveau.equals("none")){
                sql = "SELECT e.matricule, e.nom, e.sexe, e.datenais, e.institution, e.mail, e.idniv " +
                        "FROM etudiant e, montant m WHERE e.idniv=m.idniv AND (m.niveau LIKE ? AND e.institution LIKE ?)";
            }else {
                sql = "SELECT e.matricule, e.nom, e.sexe, e.datenais, e.institution, e.mail, e.idniv FROM etudiant e, montant m WHERE e.idniv=m.idniv AND (m.niveau LIKE ? OR e.institution LIKE ?)";
            }
        }else if(age.equals("-18")){
            if (!institution.equals("none") && !niveau.equals("none")){
                sql = "SELECT e.matricule, e.nom, e.sexe, e.datenais, e.institution, e.mail, e.idniv " +
                        "FROM etudiant e, montant m WHERE e.idniv=m.idniv AND (((m.niveau LIKE ? AND e.institution LIKE ?) AND (YEAR(CURDATE()) - YEAR(datenais)) <= 18)";
            }else if (institution.equals("none") && niveau.equals("none")){
                sql = "SELECT e.matricule, e.nom, e.sexe, e.datenais, e.institution, e.mail, e.idniv FROM etudiant e, montant m WHERE e.idniv=m.idniv AND (YEAR(CURDATE()) - YEAR(datenais)) <= 18";
            }else {
                sql = "SELECT e.matricule, e.nom, e.sexe, e.datenais, e.institution, e.mail, e.idniv " +
                        "FROM etudiant e, montant m WHERE e.idniv=m.idniv AND (((m.niveau LIKE ? OR e.institution LIKE ?) AND (YEAR(CURDATE()) - YEAR(datenais)) <= 18)";
            }
        }else {
            if (!institution.equals("none") && !niveau.equals("none")){
                sql = "SELECT e.matricule, e.nom, e.sexe, e.datenais, e.institution, e.mail, e.idniv " +
                        "FROM etudiant e, montant m WHERE e.idniv=m.idniv AND ((m.niveau LIKE ? AND e.institution LIKE ?) AND (YEAR(CURDATE()) - YEAR(datenais)) > 18)";
            }else if (institution.equals("none") && niveau.equals("none")){
                sql = "SELECT e.matricule, e.nom, e.sexe, e.datenais, e.institution, e.mail, e.idniv FROM etudiant e, montant m WHERE e.idniv=m.idniv AND (YEAR(CURDATE()) - YEAR(datenais)) > 18";
            }else {
                sql = "SELECT e.matricule, e.nom, e.sexe, e.datenais, e.institution, e.mail, e.idniv " +
                        "FROM etudiant e, montant m WHERE e.idniv=m.idniv AND ((m.niveau LIKE ? OR e.institution LIKE ?) AND (YEAR(CURDATE()) - YEAR(datenais)) > 18) > 18)";
            }
        }
        try(Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)){
            if (institution.equals("none") && niveau.equals("none")){
                System.out.println("ts misy izy roa!");
            }else {
                stmt.setString(1, "%" + niveau + "%");
                stmt.setString(2, "%" + institution + "%");
            }
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Etudiant e = new Etudiant();
                e.setMatricule(rs.getString("matricule"));
                e.setNom(rs.getString("nom"));
                e.setSexe(rs.getString("sexe"));
                e.setDatenais(rs.getDate("datenais"));
                e.setInstitution(rs.getString("institution"));
                e.setMail(rs.getString("mail"));
                e.setIdniv(rs.getString("idniv"));
                liste.add(e);
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return liste;
    }
    public static void ajouterEtudiant(Etudiant e) {
        try(Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO etudiant VALUES (?, ?, ?, ?, ?, ?, ?)")){
            stmt.setString(1, e.getMatricule());
            stmt.setString(2, e.getNom());
            stmt.setString(3, e.getSexe());
            stmt.setDate(4,new java.sql.Date(e.getDatenais().getTime()));
            stmt.setString(5, e.getInstitution());
            stmt.setString(6, e.getMail());
            stmt.setString(7, e.getIdniv());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    public static void modifierEtudiant(Etudiant e) {
        try(Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement("UPDATE etudiant SET matricule=?, nom=?, sexe=?, datenais=?, institution=?, mail=?, idniv=? WHERE matricule=?")){
            stmt.setString(1, e.getMatricule());
            stmt.setString(2, e.getNom());
            stmt.setString(3, e.getSexe());
            stmt.setDate(4,new java.sql.Date(e.getDatenais().getTime()));
            stmt.setString(5, e.getInstitution());
            stmt.setString(6, e.getMail());
            stmt.setString(7, e.getIdniv());
            stmt.setString(8, e.getMatricule());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    public static void supprimerEtudiant(String matricule) {
        try(Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM payer WHERE matricule=?")){
            stmt.setString(1, matricule);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        try(Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM etudiant WHERE matricule=?")){
            stmt.setString(1, matricule);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}