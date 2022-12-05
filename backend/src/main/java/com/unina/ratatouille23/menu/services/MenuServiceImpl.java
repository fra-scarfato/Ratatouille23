package com.unina.ratatouille23.menu.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.unina.ratatouille23.menu.entity.Categoria;
import com.unina.ratatouille23.menu.entity.Elemento;
import com.unina.ratatouille23.menu.repository.CategoriaRepository;
import com.unina.ratatouille23.menu.repository.ElementoRepository;

@Service
public class MenuServiceImpl implements MenuService {
    @Autowired
    CategoriaRepository categoriaRepository;

    @Autowired
    ElementoRepository elementoRepository;

    @Override
    public void aggiungiNuovaCategoria(Categoria nuovaCategoria) {
        categoriaRepository.save(nuovaCategoria);
    }

    @Override
    public void rimuoviCategoria(Categoria categoriaDaRimuovere) {
        categoriaRepository.delete(categoriaDaRimuovere);        
    }

    @Override
    public List<Categoria> getTutteLeCategorie(int idRistorante) {
        return categoriaRepository.trovaCategorieDelRistorante(idRistorante);
    }

    @Override
    public void aggiungiNuovoElemento(Elemento nuovoElemento) {
        elementoRepository.save(nuovoElemento);
    }

    @Override
    public void rimuoviElemento(Elemento elementoDaRimuovere) {
        elementoRepository.delete(elementoDaRimuovere);
    }

    @Override
    public List<Elemento> getTuttiGliElementi(int idRistorante) {
        return elementoRepository.trovaElementiDelRistorante(idRistorante);
    }

    @Override
    public void aggiornaElemento(Elemento elementoDaAggiornare) {
        String nome = elementoDaAggiornare.getNome();
        String descrizione = elementoDaAggiornare.getDescrizione();
        double costo = elementoDaAggiornare.getCosto();
        String allergeni = elementoDaAggiornare.getAllergeni();
        int idCategoria = elementoDaAggiornare.getCategoria().getId();
        int id = elementoDaAggiornare.getId();
        elementoRepository.aggiornaElemento(nome, descrizione, costo, allergeni, idCategoria, id);
    }
    
}
