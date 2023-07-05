package com.unina.ratatouille23.ordinazione.repository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.unina.ratatouille23.ordinazione.entity.ElementoOrdinato;

import jakarta.transaction.Transactional;

public interface ElementoOrdinatoRepository extends CrudRepository<ElementoOrdinato, Integer>{

    @Transactional
    @Modifying
    @Query(value = "UPDATE elmento_ordinato e SET e.quantità=?1 WHERE e.id=?2", nativeQuery = true)
    void aggiornaQuantità(int quantità, int idElementoOrdinato);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM elemento_ordinato WHERE elemento_ordinato.fk_id_ordinazione=?1", nativeQuery = true)
    public void deleteElementiOrdinati(int id);

}
