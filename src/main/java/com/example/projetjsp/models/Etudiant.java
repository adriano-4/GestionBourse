package com.example.projetjsp.models;

import java.util.Date;

public class Etudiant {
    private String matricule;
    private String nom;
    private String sexe;
    private Date datenais;
    private String institution;
    private String mail;
    private String idniv;

    //constructor
    public Etudiant() {
    }
    public Etudiant(String matricule, String nom, String sexe,Date datenais, String institution, String mail, String idniv) {
        this.matricule = matricule;
        this.nom = nom;
        this.sexe = sexe;
        this.datenais = datenais;
        this.institution = institution;
        this.mail = mail;
        this.idniv = idniv;
    }
    //getter et setter
    public String getMatricule() {
        return matricule;
    }
    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }
    public String getNom() {
        return nom;
    }
    public void setNom(String nom) {
        this.nom = nom;
    }
    public String getSexe() {
        return sexe;
    }
    public void setSexe(String sexe) {
        this.sexe = sexe;
    }
    public Date getDatenais() {
        return datenais;
    }
    public void setDatenais(Date datenais) {
        this.datenais = datenais;
    }
    public String getInstitution() {
        return institution;
    }
    public void setInstitution(String institution) {
        this.institution = institution;
    }
    public String getMail() {
        return mail;
    }
    public void setMail(String mail) {
        this.mail = mail;
    }
    public String getIdniv() {
        return idniv;
    }
    public void setIdniv(String idniv) {
        this.idniv = idniv;
    }
}