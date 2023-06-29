package com.unina.ratatouille23.ordinazione.services;

import java.util.List;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.unina.ratatouille23.ordinazione.entity.ElementoOrdinato;
import com.unina.ratatouille23.ordinazione.entity.Ordinazione;
import com.unina.ratatouille23.ordinazione.repository.ElementoOrdinatoRepository;
import com.unina.ratatouille23.ordinazione.repository.OrdinazioneRepository;
import com.unina.ratatouille23.utente.entity.AddettoAllaSala;
import com.unina.ratatouille23.utente.entity.Utente;

@Service
public class OrdinazioneServiceImpl implements OrdinazioneService{
    @Autowired
    private OrdinazioneRepository ordinazioneRepository;

    @Autowired
    private ElementoOrdinatoRepository elementoOrdinatoRepository;

    //URL della Websocket aperta
    private String broadcastURL = "/ws/order/";
    
    @Override
    public void registraNuovaOrdinazione(Ordinazione ordinazioneDaRegistrare) {
        ordinazioneRepository.save(ordinazioneDaRegistrare);
        List<ElementoOrdinato> elementiOrdinati = ordinazioneDaRegistrare.getElementiOrdinati();
        for (ElementoOrdinato elementoOrdinato : elementiOrdinati) {
            elementoOrdinatoRepository.save(elementoOrdinato);
        }
    }

    @Override
    public void eliminaOrdinazione(Ordinazione ordinazioneDaEliminare) {
        ordinazioneRepository.delete(ordinazioneDaEliminare);
    }

    @Override
    public List<Ordinazione> getOrdinazioni(int idRistorante) {
        List<Ordinazione> ordinazioni = ordinazioneRepository.getTutteLeOrdinazioni(idRistorante);
        for (Ordinazione ordinazione : ordinazioni) {
            ordinazione.setGestoreOrdinazione((Utente) Hibernate.unproxy(ordinazione.getGestoreOrdinazione()));
        }
        return ordinazioni;
    }

    @Override
    public List<Ordinazione> getOrdinazioniDaAddettoAllaSala(int idUtente) {
       
        List<Ordinazione> ordinazioni = ordinazioneRepository.getOrdinazioniAddettoAllaSala(idUtente);
        for (Ordinazione ordinazione : ordinazioni) {
            ordinazione.setGestoreOrdinazione((Utente) Hibernate.unproxy(ordinazione.getGestoreOrdinazione()));
        }
        return ordinazioni;
    }

    @Override
    public void modificaOrdinazione(Ordinazione nuovaOrdinazione) {
        ordinazioneRepository.save(nuovaOrdinazione);
    } 
    
    @Override
    public String getBroadcastURL(Ordinazione ordinazione) {
        String idRistorante = String.valueOf(ordinazione.getGestoreOrdinazione().getIdRistorante());
        return broadcastURL.concat(idRistorante);
    }
    
}
