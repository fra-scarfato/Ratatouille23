package com.unina.ratatouille23.areautente.entity;

public class Amministratore extends Utente{
    public Amministratore(String nome, String cognome, String email, String password) {
        super.setNome(nome);
        super.setCognome(cognome);
        super.setEmail(email);
        super.setPassword(password);
    }
}
