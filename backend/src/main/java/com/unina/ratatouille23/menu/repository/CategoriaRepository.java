package com.unina.ratatouille23.menu.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.unina.ratatouille23.menu.entity.Categoria;

public interface CategoriaRepository extends CrudRepository<Categoria, Integer> {
    @Query(value = "SELECT * FROM categoria WHERE categoria.id_ristorante=?1", nativeQuery = true)
    List<Categoria> trovaCategorieDelRistorante(int idRistorante);
}
