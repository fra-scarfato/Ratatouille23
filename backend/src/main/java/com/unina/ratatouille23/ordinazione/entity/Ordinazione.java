package com.unina.ratatouille23.ordinazione.entity;

import java.util.List;

import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.unina.ratatouille23.utente.entity.Utente;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;

@Entity
public class Ordinazione {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_ordinazione", unique = true)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "fk_id_utente")
    @JsonIgnoreProperties(value = {"applications", "hibernateLazyInitializer"})
    private Utente gestoreOrdinazione;

    @Column(name = "n_tavolo", nullable = false)
    private int numeroTavolo;

    private String note;

    @Column(nullable = false)
    private String stato;

    @Column(nullable = false)
    private String data; //TODO: Vedi tipo

    @Column(nullable = false)
    private double costoTotale;

    @OneToMany(mappedBy = "ordinazione")
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JsonManagedReference
    private List<ElementoOrdinato> elementiOrdinati;
    

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getNumeroTavolo() {
        return numeroTavolo;
    }

    public void setNumeroTavolo(int numeroTavolo) {
        this.numeroTavolo = numeroTavolo;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getStato() {
        return stato;
    }

    public void setStato(String stato) {
        this.stato = stato;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public double getCostoTotale() {
        return costoTotale;
    }

    public void setCostoTotale(double costoTotale) {
        this.costoTotale = costoTotale;
    }

    public List<ElementoOrdinato> getElementiOrdinati() {
        return elementiOrdinati;
    }

    public void setElementiOrdinati(List<ElementoOrdinato> elementiOrdinati) {
        this.elementiOrdinati = elementiOrdinati;
    }

    public Utente getGestoreOrdinazione() {
        return gestoreOrdinazione;
    }

    public void setGestoreOrdinazione(Utente gestoreOrdinazione) {
        this.gestoreOrdinazione = gestoreOrdinazione;
    }
    
}