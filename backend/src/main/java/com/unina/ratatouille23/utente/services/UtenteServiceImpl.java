package com.unina.ratatouille23.areautente.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.unina.ratatouille23.areautente.entity.Utente;
import com.unina.ratatouille23.areautente.repository.UtenteRepository;

@Service
public class UtenteServiceImpl implements UtenteService{
    @Autowired
    UtenteRepository utenteRepository;

    @Override
    public void registraNuovoUtente(Utente utenteDaRegistrare) {
        utenteRepository.save(utenteDaRegistrare);
    }

    @Override
    public List<Utente> getTuttiGliUtenti(int idRistorante) {
        return utenteRepository.trovaUtentiDelRistorante(idRistorante);
    }

    @Override
    public void rimuoviUtente(Utente utenteDaRimuovere) {
      utenteRepository.delete(utenteDaRimuovere);
    }
    
}
