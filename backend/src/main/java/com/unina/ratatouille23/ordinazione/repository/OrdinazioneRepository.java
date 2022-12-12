package com.unina.ratatouille23.ordinazione.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.unina.ratatouille23.ordinazione.entity.Ordinazione;

public interface OrdinazioneRepository extends CrudRepository<Ordinazione, Integer>{
    @Query(value = "SELECT * FROM ordinazione WHERE ordinazione.fk_id_utente=(SELECT utente.id_utente FROM utente WHERE utente.id_ristorante=?1)", nativeQuery = true)
    public List<Ordinazione> getTutteLeOrdinazioni(int idRistorante);
}
