package com.unina.ratatouille23.areautente.controller;

import java.util.List;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.unina.ratatouille23.areautente.dao.UtenteDAO;
import com.unina.ratatouille23.areautente.entity.Utente;

@RestController
@RequestMapping("/user")
public class UtenteController {
    UtenteDAO utenteDAO = new UtenteDAO();

    @GetMapping("/get")
    List<Utente> getAllUtenti() {
        return utenteDAO.getAllUtenti();
    }

    @PostMapping("/add")
    void aggiungiUtente(@RequestBody Utente nuovoUtente) {
        utenteDAO.aggiungiUtente(nuovoUtente);
    }

    @DeleteMapping("/delete")
    void eliminaUtente(@RequestBody Utente utenteDaEliminare) {
        utenteDAO.eliminaUtente(utenteDaEliminare);
    }
    
}
