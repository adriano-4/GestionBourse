package com.example.projetjsp.dao;

import com.example.projetjsp.models.FichierJoint;
import com.example.projetjsp.models.Java;
import com.example.projetjsp.utils.DBConnection;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.Date;

public class JavaDao {
    public static List<Java> getTousHistorique(){
        List<Java> liste = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM historique");) {
            while (rs.next()) {
                Java h = new Java();
                h.setId(rs.getInt("id"));
                h.setExpediteur(rs.getString("expediteur"));
                h.setDestinataire(rs.getString("destinataire"));
                h.setObjet(rs.getString("objet"));
                h.setMessage(rs.getString("message"));
                h.setDate(rs.getTimestamp("date"));
                liste.add(h);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return liste;
    }
    public static boolean ajouterHistorique(Java mail) {
        String sql = "INSERT INTO historique (expediteur, destinataire, objet, message, date) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, mail.getExpediteur());
            pstmt.setString(2, mail.getDestinataire());
            pstmt.setString(3, mail.getObjet());
            pstmt.setString(4, mail.getMessage());
            pstmt.setTimestamp(5, mail.getDate());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public static int getLastInsertedId() {
        String sql = "SELECT LAST_INSERT_ID()";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                return rs.getInt(1);
            }
            return -1;

        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    public static boolean ajouterFichier(int mailId, FichierJoint fichier) {
        String sql = "INSERT INTO fichiers_joints (mail_id, nom_fichier, taille, type_mime) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, mailId);
            ps.setString(2, fichier.getNom());
            ps.setLong(3, fichier.getTaille());
            ps.setString(4, fichier.getTypeMime());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public static boolean supprimerHistorique(int id) {
        String sql = "DELETE FROM historique WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Méthode supplémentaire utile pour la suppression
    public static Java getHistoriqueById(int id) {
        String sql = "SELECT * FROM historique WHERE id = ?";
        Java mail = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                mail = new Java();
                mail.setId(rs.getInt("id"));
                mail.setExpediteur(rs.getString("expediteur"));
                mail.setDestinataire(rs.getString("destinataire"));
                mail.setObjet(rs.getString("objet"));
                mail.setMessage(rs.getString("message"));
                mail.setDate(rs.getTimestamp("date"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mail;
    }
}
