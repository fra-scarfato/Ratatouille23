package com.unina.ratatouille23.ordinazione.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.unina.ratatouille23.ordinazione.entity.Ordinazione;
import com.unina.ratatouille23.ordinazione.repository.OrdinazioneRepository;

@Service
public class OrdinazioneServiceImpl implements OrdinazioneService{
    @Autowired
    private OrdinazioneRepository ordinazioneRepository;

    private String broadcastURL = "/ws/order/";
    
    @Override
    public void registraNuovaOrdinazione(Ordinazione ordinazioneDaRegistrare) {
        ordinazioneRepository.save(ordinazioneDaRegistrare);        
    }

    @Override
    public void eliminaOrdinazione(Ordinazione ordinazioneDaEliminare) {
        ordinazioneRepository.delete(ordinazioneDaEliminare);
    }

    @Override
    public List<Ordinazione> getTutteLeOrdinazioni(int idRistorante) {
        return ordinazioneRepository.getTutteLeOrdinazioni(idRistorante);
    }

    //TODO
    @Override
    public void modificaOrdinazione(Ordinazione ordinazioneDaAggiornare) {
        
    } 
    
    @Override
    public String getBroadcastURL(Ordinazione ordinazione) {
        String idRistorante = String.valueOf(ordinazione.getGestoreOrdinazione().getIdRistorante());
        return broadcastURL.concat(idRistorante);
    }
    
}
