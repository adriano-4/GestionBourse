package com.example.projetjsp.models;

import java.util.Date;

public class Payer {
    private int idpaye;
    private String anne_univ;
    private Date daty;
    private int nbr_mois;
    private String matricule;
    private int idequipement;
    private String name;
    private String niveau;
    private int bourse;
    private int equipement;

    public Payer() {
    }
    public Payer(int idpaye, String anne_univ, Date daty, int nbr_mois, String matricule, int idequipement) {
        this.idpaye = idpaye;
        this.anne_univ = anne_univ;
        this.daty = daty;
        this.nbr_mois = nbr_mois;
        this.matricule = matricule;
        this.idequipement = idequipement;
    }
    // getter et setter
    public int getIdpaye() {
        return idpaye;
    }
    public void setIdpaye(int idpaye) {
        this.idpaye = idpaye;
    }
    public String getAnne_univ() {
        return anne_univ;
    }
    public void setAnne_univ(String anne_univ) {
        this.anne_univ = anne_univ;
    }
    public Date getDaty() {
        return daty;
    }
    public void setDaty(Date daty) {
        this.daty = daty;
    }
    public int getNbr_mois() {
        return nbr_mois;
    }
    public void setNbr_mois(int nbr_mois) {
        this.nbr_mois = nbr_mois;
    }
    public String getMatricule() {
        return matricule;
    }
    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }
    public int getIdequipement() {
        return idequipement;
    }
    public void setIdequipement(int idequipement) {
        this.idequipement = idequipement;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getNiveau() {
        return niveau;
    }
    public void setNiveau(String niveau) {
        this.niveau = niveau;
    }
    public int getBourse() {
        return bourse;
    }
    public void setBourse(int bourse) {
        this.bourse = bourse;
    }
    public int getEquipement() {
        return equipement;
    }
    public void setEquipement(int equipement) {
        this.equipement = equipement;
    }
}