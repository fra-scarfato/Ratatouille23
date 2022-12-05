package com.unina.ratatouille23.areautente.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.unina.ratatouille23.areautente.entity.Utente;

public interface UtenteRepository extends CrudRepository<Utente, Integer> {
    @Query(value = "SELECT * FROM utente WHERE utente.id_ristorante=?1", nativeQuery = true)
    List<Utente> trovaUtentiDelRistorante(int idRistorante);
}
