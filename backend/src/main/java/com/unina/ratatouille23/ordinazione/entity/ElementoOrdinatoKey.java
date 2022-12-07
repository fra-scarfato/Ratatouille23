package com.unina.ratatouille23.ordinazione.entity;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

@Embeddable
public class ElementoOrdinatoKey implements Serializable{
    
    @Column(name = "id_elemento")
    private Integer idElemento;

    @Column(name = "id_ordinazione")
    private Integer idOrdinazione;

    
    public Integer getIdElemento() {
        return this.idElemento;
    }

    public void setIdElemento(Integer idElemento) {
        this.idElemento = idElemento;
    }

    public Integer getIdOrdinazione() {
        return this.idOrdinazione;
    }

    public void setIdOrdinazione(Integer idOrdinazione) {
        this.idOrdinazione = idOrdinazione;
    }

}
