package com.example.projetjsp.dao;

import com.example.projetjsp.models.Payer;
import com.example.projetjsp.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.sql.Date;
import java.util.ArrayList;

public class PayerDao {
    public static List<Payer> getTousPayements() {
        List<Payer> liste = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT e.nom as name,p.idpaye,p.anne_univ,p.date as daty,p.nbr_mois,p.matricule,p.idequipement,eq.montant as equipement,m.montant as bourse,m.niveau FROM etudiant e,montant m,equipements eq,payer p WHERE e.matricule=p.matricule AND e.idniv=m.idniv AND eq.idequipement=p.idequipement")){
            while (rs.next()) {
                Payer p = new Payer();
                p.setName(rs.getString("name"));
                p.setIdpaye(rs.getInt("idpaye"));
                p.setAnne_univ(rs.getString("anne_univ"));
                p.setDaty(rs.getDate("daty"));
                p.setNbr_mois(rs.getInt("nbr_mois"));
                p.setMatricule(rs.getString("matricule"));
                p.setIdequipement(rs.getInt("idequipement"));
                p.setEquipement(rs.getInt("equipement"));
                p.setBourse(rs.getInt("bourse"));
                p.setNiveau(rs.getString("niveau"));
                liste.add(p);
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return liste;
    }
    public static List<Payer> getPayementsID(int idpaye) {
        List<Payer> liste = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT p.idpaye,p.anne_univ,p.date as daty,p.nbr_mois,p.matricule,p.idequipement FROM payer WHERE idpaye LIKE ?")){
            stmt.setInt(1, idpaye);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Payer p = new Payer();
                p.setIdpaye(rs.getInt("idpaye"));
                p.setAnne_univ(rs.getString("anne_univ"));
                p.setDaty(rs.getDate("daty"));
                p.setNbr_mois(rs.getInt("nbr_mois"));
                p.setMatricule(rs.getString("matricule"));
                p.setIdequipement(rs.getInt("idequipement"));
                liste.add(p);
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return liste;
    }
    public static void ajouterPayement(Payer p) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("INSERT INTO payer (anne_univ,date,nbr_mois,matricule,idequipement) VALUES (?, ?, ?, ?, ?)")){
            stmt.setString(1, p.getAnne_univ());
            stmt.setDate(2, new java.sql.Date(p.getDaty().getTime()));
            stmt.setInt(3, p.getNbr_mois());
            stmt.setString(4, p.getMatricule());
            stmt.setInt(5, p.getIdequipement());
            stmt.executeUpdate();
        }catch (SQLException e){
            e.printStackTrace();
        }
    }
    public static void modifierPayer(Payer p) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("UPDATE payer SET anne_univ=?,date=?,nbr_mois=?,matricule=?,idequipement=? WHERE idpaye=?")){
            stmt.setString(1, p.getAnne_univ());
            stmt.setDate(2, new java.sql.Date(p.getDaty().getTime()));
            stmt.setInt(3, p.getNbr_mois());
            stmt.setString(4, p.getMatricule());
            stmt.setInt(5, p.getIdequipement());
            stmt.setInt(6, p.getIdpaye());
            stmt.executeUpdate();
        }catch (SQLException e){
            e.printStackTrace();
        }
    }
    public static void supprimerPayer(int idpaye) {
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM payer where idpaye=?")){
            stmt.setInt(1, idpaye);
            stmt.executeUpdate();
        }catch (SQLException e){
            e.printStackTrace();
        }
    }
}