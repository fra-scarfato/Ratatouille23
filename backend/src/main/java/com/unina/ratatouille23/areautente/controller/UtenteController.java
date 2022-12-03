package com.unina.ratatouille23.areautente.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.unina.ratatouille23.areautente.entity.Utente;
import com.unina.ratatouille23.areautente.repository.UtenteRepository;

@RestController
@RequestMapping("/user")
public class UtenteController {
    @Autowired
    private UtenteRepository utenteRepository;

    @GetMapping("/get")
    List<Utente> getAllUtenti(@RequestParam(value = "idr") int idRistorante) {
        return utenteRepository.trovaUtentiDelRistorante(idRistorante);
    }

    @PostMapping("/add")
    void aggiungiUtente(@RequestBody Utente nuovoUtente) {
        utenteRepository.save(nuovoUtente);
    }

    @DeleteMapping("/delete")
    void eliminaUtente(@RequestBody Utente utenteDaEliminare) {
        utenteRepository.delete(utenteDaEliminare);
    }
}
