package com.unina.ratatouille23.areautente.entity;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;

import jakarta.persistence.Column;
import jakarta.persistence.DiscriminatorColumn;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

//Permettono a Jackson di interagire con classi astratte e creare istanze delle giuste sottoclassi tramite il JSON
@JsonTypeInfo(
        use = JsonTypeInfo.Id.NAME,
        include = JsonTypeInfo.As.PROPERTY,
        visible = true,
        property = "ruolo") //Chiave presente nel JSON che identifica il tipo
@JsonSubTypes({
        @JsonSubTypes.Type(value = Amministratore.class, name = "amministratore"),  
        @JsonSubTypes.Type(value = AddettoAllaSala.class, name = "addetto alla sala"),
        @JsonSubTypes.Type(value = AddettoAllaCucina.class, name = "addetto alla cucina"),
        @JsonSubTypes.Type(value = Supervisore.class, name = "supervisore")
})

@Entity
@DiscriminatorColumn(name="ruolo")
public abstract class Utente {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(unique = true)
    private Integer id;

    @Column(nullable = false)
    private String nome;

    @Column(nullable = false)
    private String cognome;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private Integer idRistorante;


    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNome() {
        return this.nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCognome() {
        return this.cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getIdRistorante() {
        return this.idRistorante;
    }

    public void setIdRistorante(Integer idRistorante) {
        this.idRistorante = idRistorante;
    }
    
}
