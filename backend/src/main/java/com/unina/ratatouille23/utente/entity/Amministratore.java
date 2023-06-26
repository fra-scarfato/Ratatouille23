package com.unina.ratatouille23.utente.entity;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue("Amministratore")
public class Amministratore extends Utente {
    
    public Amministratore() {
    }

}
