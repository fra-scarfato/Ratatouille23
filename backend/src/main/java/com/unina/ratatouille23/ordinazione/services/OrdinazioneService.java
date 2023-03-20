package com.unina.ratatouille23.ordinazione.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.unina.ratatouille23.ordinazione.entity.Ordinazione;
import com.unina.ratatouille23.utente.entity.Utente;

@Service
public interface OrdinazioneService {
    public void registraNuovaOrdinazione(Ordinazione ordinazioneDaRegistrare);
    public void eliminaOrdinazione(Ordinazione ordinazioneDaEliminare);
    public List<Ordinazione> getOrdinazioni(Utente gestoreOrdinazione);
    public void modificaOrdinazione(Ordinazione ordinazioneDaAggiornare);
    public String getBroadcastURL(Ordinazione nuovOrdinazione);
}
