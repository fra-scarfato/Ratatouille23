package com.unina.ratatouille23.menu.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class Elemento {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_elemento", unique = true)
    private Integer id;

    @Column(nullable = false)
    private String nome;

    @Column(nullable = false)
    private String descrizione;

    @Column(nullable = false)
    private double costo;

    @Column(nullable = false)
    private String allergeni;
    
    @ManyToOne
    @JoinColumn(name = "fk_id_categoria")
    @JsonBackReference
    private Categoria categoria;

    public Elemento(Integer id, String nome, String descrizione, double costo, String allergeni, Categoria categoria) {
        this.id = id;
        this.nome = nome;
        this.descrizione = descrizione;
        this.costo = costo;
        this.allergeni = allergeni;
        this.categoria = categoria;
    }
    

    public Elemento() {
    }

    public Categoria getCategoria() {
        return this.categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return this.nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescrizione() {
        return this.descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public double getCosto() {
        return this.costo;
    }

    public void setCosto(double costo) {
        this.costo = costo;
    }

    public String getAllergeni() {
        return this.allergeni;
    }

    public void setAllergeni(String allergeni) {
        this.allergeni = allergeni;
    }


}
