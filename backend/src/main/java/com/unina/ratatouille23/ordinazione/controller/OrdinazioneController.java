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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.unina.ratatouille23.ordinazione.entity.Ordinazione;
import com.unina.ratatouille23.ordinazione.entity.OrdinazioneDTO;
import com.unina.ratatouille23.ordinazione.services.OrdinazioneService;

@RestController
@RequestMapping("/order")
public class OrdinazioneController {
    @Autowired
    private OrdinazioneService servizioOrdinazioni;

    @Autowired
    private SimpMessagingTemplate simpMessagingTemplate;

    @GetMapping("/get/sala/AS")
    List<Ordinazione> getOrdinazioniSalaDaAddetto(@RequestParam(value = "idu") int idUtente) {
        return servizioOrdinazioni.getOrdinazioniDaAddettoAllaSala(idUtente);
    }

    @GetMapping("/get/sala/all")
    List<Ordinazione> getOrdinazioniSala(@RequestParam(value = "idr") int idRistorante) {
        return servizioOrdinazioni.getOrdinazioniDaAddettoAllaSala(idRistorante);
    }

    @GetMapping("/get/all")
    List<Ordinazione> getOrdinazioni(@RequestParam(value = "idr") int idRistorante) {
        return servizioOrdinazioni.getOrdinazioni(idRistorante);
    }

    @PostMapping("/add")
    void registraNuovaOrdinazione(@RequestBody Ordinazione nuovaOrdinazione) {
        //Client connesso su /ws
        servizioOrdinazioni.registraNuovaOrdinazione(nuovaOrdinazione);
        //Client in ascolto su un endpoint /ws/order/{idr}
        simpMessagingTemplate.convertAndSend(servizioOrdinazioni.getBroadcastURL(nuovaOrdinazione), new OrdinazioneDTO(nuovaOrdinazione, "INSERT"));
    }

    @DeleteMapping("/delete")
    void eliminaOrdinazione(@RequestBody Ordinazione ordinazioneDaEliminare) {
        servizioOrdinazioni.eliminaOrdinazione(ordinazioneDaEliminare);
        //Client in ascolto su un endpoint /ws/order/{idr}
        simpMessagingTemplate.convertAndSend(servizioOrdinazioni.getBroadcastURL(ordinazioneDaEliminare), new OrdinazioneDTO(ordinazioneDaEliminare, "DELETE"));
    }

    @PutMapping("/update")
    void aggiornaOrdinazione(@RequestBody Ordinazione ordinazioneDaAggiornare) {
        servizioOrdinazioni.modificaOrdinazione(ordinazioneDaAggiornare);
        simpMessagingTemplate.convertAndSend(servizioOrdinazioni.getBroadcastURL(ordinazioneDaAggiornare), new OrdinazioneDTO(ordinazioneDaAggiornare, "UPDATE"));
    }

}
