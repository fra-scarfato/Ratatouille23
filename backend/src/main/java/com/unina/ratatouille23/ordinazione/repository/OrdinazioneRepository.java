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
    @Modifying(flushAutomatically = true, clearAutomatically = true)
    @Query(value = "UPDATE ordinazione SET ordinazione.note=?1, ordinazione.costo_totale=?2 WHERE ordinazione.id_ordinazione=?3", nativeQuery = true)
    void aggiornaOrdinazione(String note, double costoTotale, int id);

    @Query(value = "SELECT * FROM ordinazione WHERE ordinazione.fk_id_addettosala=?1 AND ordinazione.stato='In attesa'", nativeQuery = true)
    public List<Ordinazione> getOrdinazioniAddettoAllaSala(int idUtente);

    @Query(value = "SELECT * FROM ordinazione WHERE ordinazione.id_ristorante=?1 AND ordinazione.stato='In attesa'", nativeQuery = true)
    public List<Ordinazione> getOrdinazioniSala(int idRistorante);

    @Query(value = "SELECT * FROM ordinazione WHERE ordinazione.id_ordinazione=?1", nativeQuery = true)
    public Ordinazione findByID(int idOrdinazione);
}
