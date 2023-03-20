package com.unina.ratatouille23.ordinazione.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.transaction.annotation.Transactional;

import com.unina.ratatouille23.ordinazione.entity.Ordinazione;

public interface OrdinazioneRepository extends CrudRepository<Ordinazione, Integer>{
    @Query(value = "SELECT * FROM ordinazione WHERE ordinazione.id_ristorante=?1", nativeQuery = true)
    public List<Ordinazione> getTutteLeOrdinazioni(int idRistorante);

    @Transactional
    @Modifying
    @Query(value = "UPDATE ordinazione o SET o.note=?1, o.costo_totale=?2 WHERE o.id_ordinazione=?3", nativeQuery = true)
    void aggiornaOrdinazione(String note, double costoTotale, int id);

    @Query(value = "SELECT * FROM ordinazione WHERE ordinazione.fk_id_utente=?1", nativeQuery = true)
    public List<Ordinazione> getOrdinazioniAddettoAllaSala(int idUtente);
}
