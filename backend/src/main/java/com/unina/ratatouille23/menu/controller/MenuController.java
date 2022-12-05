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
import com.unina.ratatouille23.menu.services.MenuService;
import org.springframework.web.bind.annotation.PutMapping;


@RestController
@RequestMapping("/menu")
public class MenuController {
    @Autowired
    private MenuService servizioMenu;

    @GetMapping("/element/get")
    List<Elemento> getMenu(@RequestParam(value = "idr") int idRistorante) {
        return servizioMenu.getTuttiGliElementi(idRistorante);
    }

    @GetMapping("/category/get")
    List<Categoria> getCategorie(@RequestParam(value = "idr") int idRistorante) {
        return servizioMenu.getTutteLeCategorie(idRistorante);
    }

    @PostMapping("/element/add")
    void aggiungiElementoAlMenu(@RequestBody Elemento elementoDaAggiungere) {
        servizioMenu.aggiungiNuovoElemento(elementoDaAggiungere);
    }

    @PostMapping("/category/add")
    void aggiungiCategoria(@RequestBody Categoria categoriaDaAggiungere) {
        servizioMenu.aggiungiNuovaCategoria(categoriaDaAggiungere);
    }

    @DeleteMapping("/element/delete")
    void rimuoviElementoDalMenu(@RequestBody Elemento elementoDaRimuovere) {
        servizioMenu.rimuoviElemento(elementoDaRimuovere);
    }

    @DeleteMapping("/category/delete")
    void rimuoviCategoria(@RequestBody Categoria categoriaDaRimuovere) {
        servizioMenu.rimuoviCategoria(categoriaDaRimuovere);
    }

    @PutMapping("/element/update")
    public void modificaElemento(@RequestBody Elemento elementoDaAggiornare) {
        servizioMenu.aggiornaElemento(elementoDaAggiornare);
    }
}
