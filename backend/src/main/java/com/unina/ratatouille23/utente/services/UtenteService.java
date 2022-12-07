package com.unina.ratatouille23.utente.services;

import org.springframework.stereotype.Service;

import com.unina.ratatouille23.utente.entity.Utente;
import java.util.List;

@Service
public interface UtenteService {
    public void registraNuovoUtente(Utente utenteDaRegistrare);
    public List<Utente> getTuttiGliUtenti(int idRistorante);
    public void rimuoviUtente(Utente utenteDaRimuovere);
}
