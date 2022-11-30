package com.unina.ratatouille23.areautente.entity;

public class Supervisore extends Utente{
    public Supervisore(String nome, String cognome, String email, String password) {
        super.setNome(nome);
        super.setCognome(cognome);
        super.setEmail(email);
        super.setPassword(password);
    }
}
