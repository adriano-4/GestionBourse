package com.example.projetjsp.models;

public class Montant {
    private String idniv;
    private String niveau;
    private String statut;
    private int montant;

    public Montant (){
    }
    public Montant(String idniv, String niveau, String statut, int montant) {
        this.idniv = idniv;
        this.niveau = niveau;
        this.statut = statut;
        this.montant = montant;
    }
    //getter et setter
    public String getIdniv() {
        return idniv;
    }
    public void setIdniv(String idniv) {
        this.idniv = idniv;
    }
    public String getNiveau() {
        return niveau;
    }
    public void setNiveau(String niveau) {
        this.niveau = niveau;
    }
    public String getStatut() {
        return statut;
    }
    public void setStatut(String statut) {
        this.statut = statut;
    }
    public int getMontant() {
        return montant;
    }
    public void setMontant(int montant) {
        this.montant = montant;
    }
}