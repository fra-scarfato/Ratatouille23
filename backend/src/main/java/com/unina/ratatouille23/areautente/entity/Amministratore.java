package com.unina.ratatouille23.areautente.entity;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue("amministratore")
public class Amministratore extends Utente {
    
    public Amministratore() {
    }

}
