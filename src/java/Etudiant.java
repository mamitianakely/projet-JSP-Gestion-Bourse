/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


public class Etudiant {
    private String matricule;
    private String nom;
    private String sexe;
    private java.sql.Date dateNais;
    private String institution;
    private String niveau;
    private String mail;
    private String anneeUniv;

    // Constructeur
    public Etudiant(String matricule, String nom, String sexe, java.sql.Date dateNais, 
                    String institution, String niveau, String mail, String anneeUniv) {
        this.matricule = matricule;
        this.nom = nom;
        this.sexe = sexe;
        this.dateNais = dateNais;
        this.institution = institution;
        this.niveau = niveau;
        this.mail = mail;
        this.anneeUniv = anneeUniv;
    }

    // Getters
    public String getMatricule() { return matricule; }
    public String getNom() { return nom; }
    public String getSexe() { return sexe; }
    public java.sql.Date getDateNais() { return dateNais; }
    public String getInstitution() { return institution; }
    public String getNiveau() { return niveau; }
    public String getMail() { return mail; }
    public String getAnneeUniv() { return anneeUniv; }

    // Setters
    public void setMatricule(String matricule) { this.matricule = matricule; }
    public void setNom(String nom) { this.nom = nom; }
    public void setSexe(String sexe) { this.sexe = sexe; }
    public void setDateNais(java.sql.Date dateNais) { this.dateNais = dateNais; }
    public void setInstitution(String institution) { this.institution = institution; }
    public void setNiveau(String niveau) { this.niveau = niveau; }
    public void setMail(String mail) { this.mail = mail; }
    public void setAnneeUniv(String anneeUniv) { this.anneeUniv = anneeUniv; }
}