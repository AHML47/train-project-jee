package model;

import java.time.LocalDate;

public class User {
    private int id;
    private String nom;
    private String prenom;
    private String email;
    private String tel;
    private String cin;
    private String direction;
    private String adresse;
    private LocalDate dob;         // date de naissance
    private String cardNumber;     // numéro carte de paiement
    private String password;

    public User() {}

    /**
     * Full constructor (without ID, for new registrations).
     */
    public User(String nom,
                String prenom,
                String email,
                String tel,
                String cin,
                String direction,
                String adresse,
                LocalDate dob,
                String cardNumber,
                String password) {
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.tel = tel;
        this.cin = cin;
        this.direction = direction;
        this.adresse = adresse;
        this.dob = dob;
        this.cardNumber = cardNumber;
        this.password = password;
    }

    // --- Getters and Setters ---

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }
    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }
    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getTel() {
        return tel;
    }
    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getCin() {
        return cin;
    }
    public void setCin(String cin) {
        this.cin = cin;
    }

    public String getDirection() {
        return direction;
    }
    public void setDirection(String direction) {
        this.direction = direction;
    }

    public String getAdresse() {
        return adresse;
    }
    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public LocalDate getDob() {
        return dob;
    }
    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public String getCardNumber() {
        return cardNumber;
    }
    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
}