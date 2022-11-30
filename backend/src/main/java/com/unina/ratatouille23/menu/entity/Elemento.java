package com.unina.ratatouille23.menu.entity;

public class Elemento {
    private int id;
    private String nome;
    private String descrizione;
    private double costo;
    private String allergeni;
    private Categoria categoria;


    public Elemento(int id, String nome, String descrizione, double costo, String allergeni, Categoria categoria) {
        this.id = id;
        this.nome = nome;
        this.descrizione = descrizione;
        this.costo = costo;
        this.allergeni = allergeni;
        this.categoria = categoria;
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
