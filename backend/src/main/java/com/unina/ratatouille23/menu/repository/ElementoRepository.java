package com.unina.ratatouille23.menu.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.transaction.annotation.Transactional;

import com.unina.ratatouille23.menu.entity.Elemento;


public interface ElementoRepository extends CrudRepository<Elemento, Integer> {
    @Query(value = "SELECT * FROM elemento WHERE elemento.fk_id_categoria=(SELECT categoria.id_categoria FROM categoria WHERE categoria.id_ristorante=?1)", nativeQuery = true)
    List<Elemento> trovaElementiDelRistorante(int idRistorante);

    @Transactional
    @Modifying
    @Query(value = "UPDATE elemento e SET e.nome=?1, e.descrizione=?2, e.costo=?3, e.allergeni=?4, e.fk_id_categoria=?5 WHERE e.id_elemento=?6", nativeQuery = true)
    void aggiornaElemento(String nome, String descrizione, double costo, String allergeni, int idCategoria, int id);
}
