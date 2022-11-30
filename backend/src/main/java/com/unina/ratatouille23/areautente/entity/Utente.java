package com.unina.ratatouille23.areautente.entity;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;

//Permettono a Jackson di interagire con classi astratte e creare istanze delle giuste sottoclassi tramite il JSON
@JsonTypeInfo(
        use = JsonTypeInfo.Id.NAME,
        include = JsonTypeInfo.As.PROPERTY,
        property = "ruolo")//Chiave presente nel JSON che identifica il tipo
@JsonSubTypes({
        @JsonSubTypes.Type(value = Amministratore.class, name = "Amministratore"),  
        @JsonSubTypes.Type(value = AddettoAllaSala.class, name = "Addetto alla sala"),
        @JsonSubTypes.Type(value = AddettoAllaCucina.class, name = "Addetto alla cucina"),
        @JsonSubTypes.Type(value = Supervisore.class, name = "Supervisore")  
})

public abstract class Utente {
    private int id;
    private String nome;
    private String cognome;
    private String email;
    private String password;

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
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

    public String getPassword() {
        return this.password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
