package com.unina.ratatouille23.ordinazione.entity;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.unina.ratatouille23.utente.entity.Utente;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
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
    @Column(name = "id_ordinazione")
    private Integer id;

    @Column(name = "id_ristorante", nullable = false)
    private int idRistorante;

    @ManyToOne
    @JoinColumn(name = "fk_id_gestore")
    @JsonIgnoreProperties(value = {"applications", "hibernateLazyInitializer"})
    private Utente gestoreOrdinazione;

    @ManyToOne
    @JoinColumn(name = "fk_id_addettosala")
    @JsonIgnoreProperties(value = {"applications", "hibernateLazyInitializer"})
    private Utente addettoAllaSala;

    @Column(name = "n_tavolo", nullable = false)
    private int numeroTavolo;

    private String note;

    @Column(nullable = false)
    private String stato;

    @Column(nullable = false)
    private String data; //TODO: Vedi tipo

    @Column(nullable = false)
    private double costoTotale; //TODO: Su frontend

    @OneToMany(targetEntity = ElementoOrdinato.class, cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)
    //@OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "fk_id_ordinazione", referencedColumnName = "id_ordinazione")
    //Owner della relazione, viene istanziata l'ordinazione e poi vengono istanziati gli elementi ordinati
    //con l'id dell'ordinazione come foreign key
    private List<ElementoOrdinato> elementiOrdinati;
    

    public Ordinazione(int idRistorante, Integer id, Utente gestoreOrdinazione, int numeroTavolo, String note, String stato, String data, double costoTotale, List<ElementoOrdinato> elementiOrdinati) {
        this.id = id;
        this.idRistorante = idRistorante;
        this.gestoreOrdinazione = gestoreOrdinazione;
        this.numeroTavolo = numeroTavolo;
        this.note = note;
        this.stato = stato;
        this.data = data;
        this.costoTotale = costoTotale;
        this.elementiOrdinati = elementiOrdinati;
    }


    public Ordinazione() {
    }


    public int getIdRistorante() {
        return this.idRistorante;
    }

    public void setIdRistorante(int idRistorante) {
        this.idRistorante = idRistorante;
    }

    
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