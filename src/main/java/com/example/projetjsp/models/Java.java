package com.example.projetjsp.models;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Date;

public class Java {
    private int id;
    private String expediteur;
    private String destinataire;
    private String objet;
    private String message;
    private Timestamp date;

    public Java() {
    }

    public Java(int id, String expediteur, String destinataire, String objet, String message, Timestamp date) {
        this.id = id;
        this.expediteur = expediteur;
        this.destinataire = destinataire;
        this.objet = objet;
        this.message = message;
        this.date = date;
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getExpediteur() {
        return expediteur;
    }

    public void setExpediteur(String expediteur) {
        this.expediteur = expediteur;
    }

    public String getDestinataire() {
        return destinataire;
    }

    public void setDestinataire(String destinataire) {
        this.destinataire = destinataire;
    }

    public String getObjet() {
        return objet;
    }

    public void setObjet(String objet) {
        this.objet = objet;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }
}
