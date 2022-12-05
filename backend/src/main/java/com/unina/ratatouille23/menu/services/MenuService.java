package com.unina.ratatouille23.menu.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.unina.ratatouille23.menu.entity.Categoria;
import com.unina.ratatouille23.menu.entity.Elemento;

@Service
public interface MenuService {
    public void aggiungiNuovaCategoria(Categoria nuovaCategoria);
    public void rimuoviCategoria(Categoria categoriaDaRimuovere);
    public List<Categoria> getTutteLeCategorie(int idRistorante);
    public void aggiungiNuovoElemento(Elemento nuovoElemento);
    public void rimuoviElemento(Elemento elementoDaRimuovere);
    public List<Elemento> getTuttiGliElementi(int idRistorante);
    public void aggiornaElemento(Elemento elementoDaAggiornare);   
}