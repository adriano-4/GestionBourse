package com.example.projetjsp.models;

public class FichierJoint {
    private int id;
    private int mailId;
    private String nom;
    private long taille;
    private String typeMime;

    public FichierJoint() {}

    public FichierJoint(String nom, long taille, String typeMime) {
        this.nom = nom;
        this.taille = taille;
        this.typeMime = typeMime;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getMailId() { return mailId; }
    public void setMailId(int mailId) { this.mailId = mailId; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public long getTaille() { return taille; }
    public void setTaille(long taille) { this.taille = taille; }

    public String getTypeMime() { return typeMime; }
    public void setTypeMime(String typeMime) { this.typeMime = typeMime; }
}