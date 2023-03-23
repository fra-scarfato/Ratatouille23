package com.unina.ratatouille23.ordinazione.entity;

public class OrdinazioneDTO {
    private Ordinazione ordinazione;
    private String operazione;

    public OrdinazioneDTO() {
    }

    public OrdinazioneDTO(Ordinazione ordinazione, String operazione) {
        this.ordinazione = ordinazione;
        this.operazione = operazione;
    }

    public Ordinazione getOrdinazione() {
        return this.ordinazione;
    }

    public void setOrdinazione(Ordinazione ordinazione) {
        this.ordinazione = ordinazione;
    }

    public String getOperazione() {
        return this.operazione;
    }

    public void setOperazione(String operazione) {
        this.operazione = operazione;
    }



}
