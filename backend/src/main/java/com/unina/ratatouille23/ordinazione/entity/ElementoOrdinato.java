package com.unina.ratatouille23.ordinazione.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.unina.ratatouille23.menu.entity.Elemento;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;

@Entity
public class ElementoOrdinato {

    @EmbeddedId
    private ElementoOrdinatoKey id;

    @ManyToOne
    @MapsId("idElemento")
    @JoinColumn(name = "id_elemento")
    private Elemento elementoDaOrdinare;

    @ManyToOne
    @MapsId("idOrdinazione")
    @JoinColumn(name = "id_ordinazione")
    @JsonBackReference
    private Ordinazione ordinazione;

    @Column(nullable = false)
    private int quantità;

    public ElementoOrdinatoKey getId() {
        return id;
    }

    public void setId(ElementoOrdinatoKey id) {
        this.id = id;
    }

    public Elemento getElementoDaOrdinare() {
        return elementoDaOrdinare;
    }

    public void setElementoDaOrdinare(Elemento elementoDaOrdinare) {
        this.elementoDaOrdinare = elementoDaOrdinare;
    }

    public Ordinazione getOrdinazione() {
        return ordinazione;
    }

    public void setOrdinazione(Ordinazione ordinazione) {
        this.ordinazione = ordinazione;
    }

    public int getQuantità() {
        return quantità;
    }

    public void setQuantità(int quantità) {
        this.quantità = quantità;
    }
    
    
}
