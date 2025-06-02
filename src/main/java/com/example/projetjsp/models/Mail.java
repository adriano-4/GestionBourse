package com.example.projetjsp.models;

import java.util.Date;

public class Mail {
    private String nom;
    private String matricule;
    private String mail;
    private Date date_envoie;

    public Mail(){
    }
    public Mail(Date date_envoie,String matricule){
        this.matricule = matricule;
        this.date_envoie = date_envoie;
    }
    public String getNom() {
        return nom;
    }
    public void setNom(String nom) {
        this.nom = nom;
    }
    public String getMatricule() {
        return matricule;
    }
    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }
    public String getMail() {
        return mail;
    }
    public void setMail(String mail) {
        this.mail = mail;
    }
    public Date getDate_envoie() {
        return date_envoie;
    }
    public void setDate_envoie(Date date_envoie) {
        this.date_envoie = date_envoie;
    }
}