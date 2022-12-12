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

    private String broadcastURL = "/order/";
    
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

    @Override
    public void modificaOrdinazione(Ordinazione ordinazioneDaAggiornare) {
        // TODO Auto-generated method stub
        
    } 
    
    @Override
    public String getBroadcastURL(Ordinazione nuovOrdinazione) {
        String idRistorante = String.valueOf(nuovOrdinazione.getGestoreOrdinazione().getIdRistorante());
        return broadcastURL.concat(idRistorante);
    }
    
}
