package com.unina.ratatouille23.ordinazione.entity;

import com.unina.ratatouille23.menu.entity.Elemento;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class ElementoOrdinato {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "fk_id_elemento")
    private Elemento elementoDaOrdinare;

    @Column(name = "quantità", nullable = false)
    private int quantita;

    //Il riferimento all'ordinazione è stato implementato tramite annotation in Ordinazione.java


    public ElementoOrdinato(Integer id, Elemento elementoDaOrdinare, int quantità) {
        this.id = id;
        this.elementoDaOrdinare = elementoDaOrdinare;
        this.quantita = quantità;
    }


    public ElementoOrdinato() {
    }


    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Elemento getElementoDaOrdinare() {
        return elementoDaOrdinare;
    }

    public void setElementoDaOrdinare(Elemento elementoDaOrdinare) {
        this.elementoDaOrdinare = elementoDaOrdinare;
    }

    public int getQuantita() {
        return quantita;
    }

    public void setQuantita(int quantità) {
        this.quantita = quantità;
    }
    
    
}
