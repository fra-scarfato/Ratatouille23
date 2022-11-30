package com.unina.ratatouille23.areautente.dao;

import java.util.List;

import com.unina.ratatouille23.areautente.entity.AddettoAllaSala;
import com.unina.ratatouille23.areautente.entity.Amministratore;
import com.unina.ratatouille23.areautente.entity.Utente;

import java.util.ArrayList;

public class UtenteDAO {
    private List<Utente> tuttiUtenti = new ArrayList<Utente>();

    public UtenteDAO() {
        tuttiUtenti.add(new Amministratore("Francesco","Scarfato","io@gmail.com","ioioio"));
        tuttiUtenti.add(new AddettoAllaSala("Vincenzo", "Brancaccio","vinc@gmail.com","ioioio"));
    }

    public List<Utente> getAllUtenti() {
        return tuttiUtenti;
    }

    public void aggiungiUtente(Utente nuovoUtente) {
        tuttiUtenti.add(nuovoUtente);
    }

    public void eliminaUtente(Utente utenteDaEliminare) {
        tuttiUtenti.remove(utenteDaEliminare);
    }
}
