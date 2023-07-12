package com.unina.ratatouille23.ordinazione.services;

import java.util.List;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.unina.ratatouille23.ordinazione.entity.Ordinazione;
import com.unina.ratatouille23.ordinazione.repository.ElementoOrdinatoRepository;
import com.unina.ratatouille23.ordinazione.repository.OrdinazioneRepository;
import com.unina.ratatouille23.utente.entity.Utente;

import jakarta.transaction.Transactional;

@Service
public class OrdinazioneServiceImpl implements OrdinazioneService{
    @Autowired
    private OrdinazioneRepository ordinazioneRepository;

    @Autowired
    private ElementoOrdinatoRepository elementoOrdinatoRepository;

    //URL della Websocket aperta
    private String broadcastURL = "/ws/order/";
    
    @Override
    @Transactional
    public int registraNuovaOrdinazione(Ordinazione ordinazioneDaRegistrare) {
        ordinazioneRepository.save(ordinazioneDaRegistrare);
        elementoOrdinatoRepository.saveAll(ordinazioneDaRegistrare.getElementiOrdinati());
        return ordinazioneDaRegistrare.getId();
    }

    @Override
    public void eliminaOrdinazione(Ordinazione ordinazioneDaEliminare) {
        elementoOrdinatoRepository.deleteElementiOrdinati(ordinazioneDaEliminare.getId());
        ordinazioneRepository.delete(ordinazioneDaEliminare);
    }

    //Tutte le ordinazioni
    @Override
    public List<Ordinazione> getOrdinazioni(int idRistorante) {
        List<Ordinazione> ordinazioni = ordinazioneRepository.getTutteLeOrdinazioni(idRistorante);
        for (Ordinazione ordinazione : ordinazioni) {
            ordinazione.setGestoreOrdinazione((Utente) Hibernate.unproxy(ordinazione.getGestoreOrdinazione()));
            ordinazione.setAddettoAllaSala((Utente) Hibernate.unproxy(ordinazione.getAddettoAllaSala()));
        }
        return ordinazioni;
    }

    //Tutte le ordinazioni in attesa
    @Override
    public List<Ordinazione> getOrdinazioniSala(int idRistorante) {
       
        List<Ordinazione> ordinazioni = ordinazioneRepository.getOrdinazioniSala(idRistorante);
        for (Ordinazione ordinazione : ordinazioni) {
            ordinazione.setGestoreOrdinazione((Utente) Hibernate.unproxy(ordinazione.getGestoreOrdinazione()));
            ordinazione.setAddettoAllaSala((Utente) Hibernate.unproxy(ordinazione.getAddettoAllaSala()));
        }
        return ordinazioni;
    }

    //Tutte le ordinazioni prese dal cameriere in attesa
    @Override
    public List<Ordinazione> getOrdinazioniDaAddettoAllaSala(int idUtente) {
       
        List<Ordinazione> ordinazioni = ordinazioneRepository.getOrdinazioniAddettoAllaSala(idUtente);
        for (Ordinazione ordinazione : ordinazioni) {
            ordinazione.setGestoreOrdinazione((Utente) Hibernate.unproxy(ordinazione.getGestoreOrdinazione()));
            ordinazione.setAddettoAllaSala((Utente) Hibernate.unproxy(ordinazione.getAddettoAllaSala()));
        }
        return ordinazioni;
    }

    @Override
    public void modificaOrdinazioneSala(Ordinazione nuovaOrdinazione) {
        elementoOrdinatoRepository.deleteElementiOrdinati(nuovaOrdinazione.getId());
        elementoOrdinatoRepository.saveAll(nuovaOrdinazione.getElementiOrdinati());
        ordinazioneRepository.aggiornaOrdinazione(nuovaOrdinazione.getNote(), nuovaOrdinazione.getCostoTotale(), nuovaOrdinazione.getId());
    } 

    @Override
    public void modificaOrdinazioneCucina(Ordinazione nuovaOrdinazione) {
        ordinazioneRepository.save(nuovaOrdinazione);
    } 
    
    @Override
    public String getBroadcastURL(Ordinazione ordinazione) {
        String idRistorante = String.valueOf(ordinazione.getAddettoAllaSala().getIdRistorante());
        return broadcastURL.concat(idRistorante);
    }

    @Override
    public Ordinazione getOrdinazioneByID(int idOrdinazione) {
        return ordinazioneRepository.findByID(idOrdinazione);
    }
    
}
