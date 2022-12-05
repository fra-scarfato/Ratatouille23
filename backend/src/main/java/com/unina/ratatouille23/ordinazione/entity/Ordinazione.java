package com.unina.ratatouille23.ordinazione.entity;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;

public class Ordinazione {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(unique = true)
    private Integer id;

    @Column(nullable = false)
    private int numeroTavolo;

    @Column(nullable = false)
    private String note;

    @Column(nullable = false)
    private String stato;

    @Column(nullable = false)
    private String data; //TODO: Vedi tipo

    @Column(nullable = false)
    private double costoTotale;
    /* 
    @OneToMany(mappedBy = "elemento", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private Categoria categoria; */
}