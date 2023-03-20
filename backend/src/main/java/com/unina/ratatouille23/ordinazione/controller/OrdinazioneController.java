package com.unina.ratatouille23.ordinazione.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.unina.ratatouille23.ordinazione.entity.Ordinazione;
import com.unina.ratatouille23.ordinazione.services.OrdinazioneService;
import com.unina.ratatouille23.utente.entity.Utente;

@RestController
@RequestMapping("/order")
public class OrdinazioneController {
    @Autowired
    private OrdinazioneService servizioOrdinazioni;

    @Autowired
    private SimpMessagingTemplate simpMessagingTemplate;

    @GetMapping("/get")
    List<Ordinazione> getOrdinazioni(@RequestBody Utente gestoreOrdinazione) {
        return servizioOrdinazioni.getOrdinazioni(gestoreOrdinazione);
    }

    @PostMapping("/add")
    void registraNuovaOrdinazione(@RequestBody Ordinazione nuovaOrdinazione) {
        //Client connesso su /ws
        servizioOrdinazioni.registraNuovaOrdinazione(nuovaOrdinazione);
        //Client in ascolto su un endpoint /ws/order/{idr}
        simpMessagingTemplate.convertAndSend("/ws/order/1", nuovaOrdinazione);
    }

    @DeleteMapping("/delete")
    void eliminaOrdinazione(@RequestBody Ordinazione ordinazioneDaEliminare) {
        servizioOrdinazioni.eliminaOrdinazione(ordinazioneDaEliminare);
        //Client in ascolto su un endpoint /order/{idr}
        simpMessagingTemplate.convertAndSend(servizioOrdinazioni.getBroadcastURL(ordinazioneDaEliminare), "Un ordinazione è stata eliminata. Aggiorna");
    }

    @PutMapping("/update")
    void aggiornaOrdinazione(@RequestBody Ordinazione ordinazioneDaAggiornare) {
        servizioOrdinazioni.modificaOrdinazione(ordinazioneDaAggiornare);
        simpMessagingTemplate.convertAndSend(servizioOrdinazioni.getBroadcastURL(ordinazioneDaAggiornare), ordinazioneDaAggiornare);
    }

}
