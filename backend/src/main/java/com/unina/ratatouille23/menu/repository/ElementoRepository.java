package com.unina.ratatouille23.menu.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.unina.ratatouille23.menu.entity.Elemento;

public interface ElementoRepository extends CrudRepository<Elemento, Integer> {
    @Query(value = "SELECT * FROM elemento WHERE elemento.id_categoria=(SELECT categoria.id FROM categoria WHERE categoria.id_ristorante=?1)", nativeQuery = true)
    List<Elemento> trovaElementiDelRistorante(int idRistorante);
}
