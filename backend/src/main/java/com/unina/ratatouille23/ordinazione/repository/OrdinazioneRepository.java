package com.unina.ratatouille23.ordinazione.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.transaction.annotation.Transactional;

import com.unina.ratatouille23.ordinazione.entity.Ordinazione;

public interface OrdinazioneRepository extends CrudRepository<Ordinazione, Integer>{
    @Query(value = "SELECT * FROM ordinazione WHERE ordinazione.fk_id_utente=(SELECT utente.id_utente FROM utente WHERE utente.id_ristorante=?1)", nativeQuery = true)
    public List<Ordinazione> getTutteLeOrdinazioni(int idRistorante);

    @Transactional
    @Modifying
    @Query(value = "UPDATE elemento e SET e.nome=?1, e.descrizione=?2, e.costo=?3, e.allergeni=?4, e.fk_id_categoria=?5 WHERE e.id_elemento=?6", nativeQuery = true)
    void aggiornaOrdinazione(String nome, String descrizione, double costo, String allergeni, int idCategoria, int id); //TODO
}
