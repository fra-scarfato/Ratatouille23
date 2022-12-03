package com.unina.ratatouille23.menu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.unina.ratatouille23.menu.entity.Categoria;
import com.unina.ratatouille23.menu.entity.Elemento;
import com.unina.ratatouille23.menu.repository.CategoriaRepository;
import com.unina.ratatouille23.menu.repository.ElementoRepository;

@RestController
@RequestMapping("/menu")
public class MenuController {
    @Autowired
    private CategoriaRepository categoriaRepository;
    @Autowired
    private ElementoRepository elementoRepository;

    @GetMapping("/element/get")
    List<Elemento> getMenu(@RequestParam(value = "idr") int idRistorante) {
        return elementoRepository.trovaElementiDelRistorante(idRistorante);
    }

    @GetMapping("/category/get")
    List<Categoria> getCategorie(@RequestParam(value = "idr") int idRistorante) {
        return categoriaRepository.trovaCategorieDelRistorante(idRistorante);
    }

    @PostMapping("/element/add")
    void aggiungiElementoAlMenu(@RequestBody Elemento elementoDaAggiungere) {
        elementoRepository.save(elementoDaAggiungere);
    }

    @PostMapping("/category/add")
    void aggiungiCategoria(@RequestBody Categoria categoriaDaAggiungere) {
        categoriaRepository.save(categoriaDaAggiungere);
    }

    @DeleteMapping("/element/delete")
    void rimuoviElementoDalMenu(@RequestBody Elemento elementoDaRimuovere) {
        elementoRepository.delete(elementoDaRimuovere);
    }

    @DeleteMapping("/category/delete")
    void rimuoviCategoria(@RequestBody Categoria categoriaDaRimuovere) {
        categoriaRepository.delete(categoriaDaRimuovere);
    }
}
