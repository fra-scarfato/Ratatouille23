package com.unina.ratatouille23.menu.repository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.transaction.annotation.Transactional;

import com.unina.ratatouille23.menu.entity.Elemento;


public interface ElementoRepository extends CrudRepository<Elemento, Integer> {
    @Transactional
    @Modifying
    @Query(value = "UPDATE elemento e SET e.nome=?1, e.descrizione=?2, e.costo=?3, e.allergeni=?4, e.fk_id_categoria=?5 WHERE e.id_elemento=?6", nativeQuery = true)
    void aggiornaElemento(String nome, String descrizione, double costo, String allergeni, int idCategoria, int id);
}
