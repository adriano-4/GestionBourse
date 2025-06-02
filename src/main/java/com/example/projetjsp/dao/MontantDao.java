package com.example.projetjsp.dao;

import com.example.projetjsp.models.Montant;
import com.example.projetjsp.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.sql.Date;
import java.util.ArrayList;

public class MontantDao {
    public static List<Montant> getTousMontants(){
        List<Montant> liste = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM montant");) {
            while (rs.next()) {
                Montant m = new Montant();
                m.setIdniv(rs.getString("idniv"));
                m.setNiveau(rs.getString("niveau"));
                m.setStatut(rs.getString("statut"));
                m.setMontant(rs.getInt("montant"));
                liste.add(m);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return liste;
    }
    public static List<Montant> getMontantsID(String idniv){
        List<Montant> liste = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM montant WHERE idniv=?")){
            stmt.setString(1, idniv);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Montant m = new Montant();
                m.setIdniv(rs.getString("idniv"));
                m.setNiveau(rs.getString("niveau"));
                m.setStatut(rs.getString("statut"));
                m.setMontant(rs.getInt("montant"));
                liste.add(m);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return liste;
    }
    public static void ajouterMontant(Montant m){
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO montant VALUES (?, ?, ?, ?)")){
            stmt.setString(1, m.getIdniv());
            stmt.setString(2, m.getNiveau());
            stmt.setString(3, m.getStatut());
            stmt.setInt(4, m.getMontant());
            stmt.executeUpdate();
        }catch (SQLException e){
            e.printStackTrace();
        }
    }
    public static void modifierMontant(Montant m){
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("UPDATE montant SET niveau=?, statut=?, montant=? WHERE idniv=?")){
            stmt.setString(1, m.getNiveau());
            stmt.setString(2, m.getStatut());
            stmt.setInt(3, m.getMontant());
            stmt.setString(4, m.getIdniv());
            stmt.executeUpdate();
        }catch (SQLException e){
            e.printStackTrace();
        }
    }
    public static void supprimerMontant(String idniv){
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM etudiant WHERE idniv=?")){
            stmt.setString(1, idniv);
            stmt.executeUpdate();
        }catch (SQLException e){
            e.printStackTrace();
        }
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM montant WHERE idniv=?")){
            stmt.setString(1, idniv);
            stmt.executeUpdate();
        }catch (SQLException e){
            e.printStackTrace();
        }
    }
}