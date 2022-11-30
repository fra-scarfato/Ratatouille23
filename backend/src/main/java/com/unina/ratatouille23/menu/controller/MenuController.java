package com.unina.ratatouille23.menu.controller;

import java.util.List;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.unina.ratatouille23.menu.entity.Categoria;
import com.unina.ratatouille23.menu.entity.Elemento;

@RestController
@RequestMapping("/menu")
public class MenuController {
    
    @GetMapping("/element/get")
    List<Elemento> getMenu() {
        //TODO
        return null;
    }

    @GetMapping("/category/get")
    List<Categoria> getCategorie() {
        //TODO
        return null;
    }

    @PostMapping("/element/add")
    void aggiungiElementoAlMenu(@RequestBody Elemento elementoDaAggiungere) {
        //TODO
    }

    @PostMapping("/category/add")
    void aggiungiCategoria(@RequestBody Categoria categoriaDaAggiungere) {
        //TODO
    }

    @DeleteMapping("/element/delete")
    void rimuoviElementoDalMenu(@RequestBody Elemento elementoDaAggiungere) {
        //TODO
    }

    @DeleteMapping("/category/delete")
    void rimuoviCategoria(@RequestBody Categoria categoriaDaAggiungere) {
        //TODO
    }
}
